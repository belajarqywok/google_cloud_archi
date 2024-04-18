# kubernetes cluster configuration (helm)
CL=cluster

# terraform configuration
TF=provisions

# service name
SVC=notes-svc

# kubernetes namespaces
NS_STG=notes-staging
NS_DEV=notes-development
NS_PROD=notes-production

# container registry location (Google Artifact Registry)
REGISTRY=asia-southeast2-docker.pkg.dev/dicoding-gcloud-archi/submission

# Generate SSH Keys
KEYS := instance-key-sg instance-key-id instance-key-ge instance-key-en
keygen:
	@for key in $(KEYS); do \
      echo "Generating $$key"; \
      ssh-keygen -t ed25519 -f ./keys/$$key -C c211bsy3776; \
  done

# SSH Connect Using Private Key
ssh-priv: ssh -i $(key) $(uname)@$(addr)

# Google Kubernetes Engine (GKE) credential copy
gke-creds:
	gcloud container clusters get-credentials dicoding-cluster-labs \
		--zone asia-southeast2-a \
		--project dicoding-gcloud-archi

# pm2 apply
pm2-apply:
	pm2 start pm2.config.js
	pm2 save

# pm2 start
pm2-start: pm2 start all

# pm2 stop
pm2-stop: pm2 stop all

# pm2 delete
pm2-delete: pm2 delete all

# create k8s 
create-namespaces:
	kubectl create ns $(NS_STG)
	kubectl create ns $(NS_DEV)
	kubectl create ns $(NS_PROD)

# get k8s services
get-svc-endpoint:
	kubectl get svc -n notes-production

# get k8s nodes
get-nodes-endpoint:
	kubectl get nodes --output wide

# helm install (dev)
helm-install-dev:
	helm install $(SVC)-dev $(CL)/ \
		--values $(CL)/values.yaml \
		-f $(CL)/environments/values-dev.yaml -n $(NS_DEV)

# heml upgrade (dev)
helm-upgrade-dev:
	helm upgrade $(SVC)-dev $(CL)/ \
		--values $(CL)/values.yaml \
		-f $(CL)/environments/values-dev.yaml -n $(NS_DEV)

# helm install (prod)
helm-install-prod:
	helm install $(SVC)-prod $(CL)/ \
		--values $(CL)/values.yaml \
		-f $(CL)/environments/values-prod.yaml -n $(NS_PROD)

# helm upgrade (prod)
helm-upgrade-prod:
	helm upgrade $(SVC)-prod $(CL)/ \
		--values $(CL)/values.yaml \
		-f $(CL)/environments/values-prod.yaml -n $(NS_PROD)

# helm delete (prod)
helm-delete-prod:
	helm delete notes-svc-prod

helm-list:
	helm list

artifact-registry-build:
	docker build --tag $(SVC):$(tag) \
    	--file dockerfiles/$(type).dockerfile .

	docker tag $(SVC):$(tag) \
        $(REGISTRY)/$(SVC):$(tag)

	gcloud auth configure-docker asia-southeast2-docker.pkg.dev

	docker push $(REGISTRY)/$(SVC):$(tag)

deploy_static_svc:
	terraform -chdir=./$(TF) apply -auto-approve
	python3 ./$(TF)/ansiblize.py $(TF) ./ansible/inventory/hosts
	bash -c 'cd ansible && ansible-playbook -i inventory/hosts config.yaml --extra-vars "auto=yes"'
	terraform -chdir=./$(TF) output
