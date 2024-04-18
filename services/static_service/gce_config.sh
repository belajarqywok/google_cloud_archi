#!/bin/bash
sudo apt update
sudo apt install -y docker.io haproxy

if [ ! -e "index.php" ]; then
    sudo cat << EOF >> index.php
<?php 
\$ip = "ip-here";
// display it back
echo "<h1>HTTP Load Balancing Lab</h1>";
echo "<h2>Client IP</h2>";
echo "Your IP address : " . \$ip;
echo "<h2>Hostname</h2>";
echo "Server Hostname: " . php_uname("n");
echo "<h2>Server Location</h2>";
echo "Region and Zone: " . "region-here";
?>
EOF

    META_IP_STRING=$(curl "http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip" \
        -H "Metadata-Flavor: Google")
    META_REGION_STRING=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" \
        -H "Metadata-Flavor: Google")

    IP=`echo "$META_IP_STRING" | awk -F/ '{print $0}'`
    REGION=`echo "$META_REGION_STRING" | awk -F/ '{print $4}'`

    sudo sed -i "s|ip-here|$IP|" index.php
    sudo sed -i "s|region-here|$REGION|" index.php
fi

if [ ! -e "web.dockerfile" ]; then
    sudo cat << EOF >> web.dockerfile
FROM php:7.4-apache
WORKDIR /var/www/html
COPY index.php .
EXPOSE 80
CMD ["apache2-foreground"]
EOF
fi

IMAGE_NAME=monolith_webapp_svc
IMAGE_VERSION=1.0
if ! sudo docker images $IMAGE_NAME:$IMAGE_VERSION | grep -q $IMAGE_NAME; then
    sudo docker build --tag $IMAGE_NAME:$IMAGE_VERSION --file web.dockerfile .
fi

for i in {0..9}; do
    PORT=$((8000 + i))
    CONTAINER_NAME="monolith_webapp_svc-$i"
    if ! sudo docker ps -a --format '{{.Names}}' | grep -q $CONTAINER_NAME; then
        sudo docker container create --name $CONTAINER_NAME \
            -p "$PORT:80" $IMAGE_NAME:$IMAGE_VERSION
        sudo docker container start $CONTAINER_NAME
    fi
done

if [ ! -e "haproxy.cfg" ]; then
    sudo cat << EOF > haproxy.cfg
global
    daemon
    maxconn 1024

    log /dev/log local0
    log /dev/log local1 notice

    stats timeout 30s

    ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS


defaults
    mode http
    retries 3
    log global

    option httplog
    option redispatch
    option dontlognull

    timeout check 10s
    timeout queue 10s
    timeout client 10s
    timeout server 10s
    timeout connect 10s
    timeout http-request 10s

frontend http_front
    bind *:80
    bind :::80

    mode http

    stick-table type ip size 100k expire 30s store http_req_rate(10s)
    http-request track-sc0 src
    http-request deny deny_status 429 if { sc_http_req_rate(0) gt 100 }

    acl is_websocket hdr(Upgrade) -i websocket
    acl is_websocket hdr_beg(Host) -i ws

    use_backend website_services if is_websocket
    default_backend website_services

backend website_services
    mode http
    timeout queue 10s
    balance roundrobin
    option forwardfor
    http-request set-header X-Forwarded-Port %[dst_port]
    http-request add-header X-Forwarded-Proto https if { ssl_fc }
EOF

    for i in {0..9}; do
        PORT=$((8000 + i))
        sudo echo "    server websocket_svc_${i} 172.17.0.1:${PORT} check" \
            >> haproxy.cfg
    done

    sudo cat << EOF >> haproxy.cfg
listen stats
    bind *:13579
    stats enable
    stats hide-version
    stats refresh 30s
    stats show-node
    stats auth username:password
    stats uri /stats

EOF
fi

sudo haproxy -f ./haproxy.cfg
