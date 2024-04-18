# Custom Role For Load Balancing Viewer
resource "google_project_iam_custom_role" "load_balancer_viewer" {
  role_id     = "loadBalancerViewer"
  title       = "Load Balancer Viewer"

  description = <<-EOT
    Role for Load Balancing Viewer.
    
    Made it myself because google cloud doesn't provide this.

    Kocak tapi ya sudahlah, Aowkwkwkwk....
  EOT

  permissions = [
    # certificatemanager.certmaps.*
    "certificatemanager.certmaps.get",
    "certificatemanager.certmaps.list",

    # compute.addresses.*
    "compute.addresses.get",
    "compute.addresses.list",

    # compute.backendBuckets.*
    "compute.backendBuckets.get",
    "compute.backendBuckets.getIamPolicy",
    "compute.backendBuckets.list",
    "compute.backendBuckets.listEffectiveTags",
    "compute.backendBuckets.listTagBindings",

    # compute.backendServices.*
    "compute.backendServices.get",
    "compute.backendServices.getIamPolicy",
    "compute.backendServices.list",
    "compute.backendServices.listEffectiveTags",
    "compute.backendServices.listTagBindings",

    # compute.disks.*
    "compute.disks.listEffectiveTags",
    "compute.disks.listTagBindings",

    # compute.forwardingRules.*
    "compute.forwardingRules.get",
    "compute.forwardingRules.list",
    "compute.forwardingRules.listEffectiveTags",
    "compute.forwardingRules.listTagBindings",

    # compute.globalAddresses.*
    "compute.globalAddresses.get",
    "compute.globalAddresses.list",

    # compute.globalForwardingRules.*
    "compute.globalForwardingRules.get",
    "compute.globalForwardingRules.list",
    "compute.globalForwardingRules.listEffectiveTags",
    "compute.globalForwardingRules.listTagBindings",
    "compute.globalForwardingRules.pscGet",

    # compute.globalNetworkEndpointGroups.*
    "compute.globalNetworkEndpointGroups.attachNetworkEndpoints",
    "compute.globalNetworkEndpointGroups.detachNetworkEndpoints",
    "compute.globalNetworkEndpointGroups.get",
    "compute.globalNetworkEndpointGroups.list",
    "compute.globalNetworkEndpointGroups.listEffectiveTags",
    "compute.globalNetworkEndpointGroups.listTagBindings",

    # compute.healthChecks.*
    "compute.healthChecks.get",
    "compute.healthChecks.list",
    "compute.healthChecks.listEffectiveTags",
    "compute.healthChecks.listTagBindings",

    # compute.httpHealthChecks.*
    "compute.httpHealthChecks.get",
    "compute.httpHealthChecks.list",
    "compute.httpHealthChecks.listEffectiveTags",
    "compute.httpHealthChecks.listTagBindings",

    # compute.httpsHealthChecks.*
    "compute.httpsHealthChecks.get",
    "compute.httpsHealthChecks.list",
    "compute.httpsHealthChecks.listEffectiveTags",
    "compute.httpsHealthChecks.listTagBindings",

    # compute.images.*
    "compute.images.listEffectiveTags",
    "compute.images.listTagBindings",

    # compute.instanceGroups.*
    "compute.instanceGroups.get",
    "compute.instanceGroups.list",

    # compute.instances.*
    "compute.instances.get",
    "compute.instances.list",
    "compute.instances.listEffectiveTags",
    "compute.instances.listTagBindings",

    # compute.networkEndpointGroups.*
    "compute.networkEndpointGroups.attachNetworkEndpoints",
    "compute.networkEndpointGroups.detachNetworkEndpoints",
    "compute.networkEndpointGroups.get",
    "compute.networkEndpointGroups.getIamPolicy",
    "compute.networkEndpointGroups.list",
    "compute.networkEndpointGroups.listEffectiveTags",
    "compute.networkEndpointGroups.listTagBindings",

    # compute.networks.*
    "compute.networks.get",
    "compute.networks.list",
    "compute.networks.listEffectiveTags",
    "compute.networks.listTagBindings",

    # compute.projects.*
    "compute.projects.get",

    # compute.regionBackendServices.*
    "compute.regionBackendServices.get",
    "compute.regionBackendServices.getIamPolicy",
    "compute.regionBackendServices.list",
    "compute.regionBackendServices.listEffectiveTags",
    "compute.regionBackendServices.listTagBindings",

    # compute.regionHealthCheckServices.*
    "compute.regionHealthCheckServices.get",
    "compute.regionHealthCheckServices.list",

    # compute.regionHealthChecks.*
    "compute.regionHealthChecks.get",
    "compute.regionHealthChecks.list",
    "compute.regionHealthChecks.listEffectiveTags",
    "compute.regionHealthChecks.listTagBindings",

    # compute.regionNetworkEndpointGroups.*
    "compute.regionNetworkEndpointGroups.attachNetworkEndpoints",
    "compute.regionNetworkEndpointGroups.detachNetworkEndpoints",
    "compute.regionNetworkEndpointGroups.get",
    "compute.regionNetworkEndpointGroups.list",
    "compute.regionNetworkEndpointGroups.listEffectiveTags",
    "compute.regionNetworkEndpointGroups.listTagBindings",

    # compute.regionNotificationEndpoints.*
    "compute.regionNotificationEndpoints.get",
    "compute.regionNotificationEndpoints.list",

    # compute.regionSecurityPolicies.*
    "compute.regionSecurityPolicies.get",
    "compute.regionSecurityPolicies.list",
    "compute.regionSecurityPolicies.listEffectiveTags",
    "compute.regionSecurityPolicies.listTagBindings",

    # compute.regionSslCertificates.*
    "compute.regionSslCertificates.get",
    "compute.regionSslCertificates.list",
    "compute.regionSslCertificates.listEffectiveTags",
    "compute.regionSslCertificates.listTagBindings",

    # compute.regionSslPolicies.*
    "compute.regionSslPolicies.get",
    "compute.regionSslPolicies.list",
    "compute.regionSslPolicies.listAvailableFeatures",

    # compute.regionTargetHttpProxies.*
    "compute.regionTargetHttpProxies.get",
    "compute.regionTargetHttpProxies.list",
    "compute.regionTargetHttpProxies.listEffectiveTags",
    "compute.regionTargetHttpProxies.listTagBindings",

    # compute.regionTargetHttpsProxies.*
    "compute.regionTargetHttpsProxies.get",
    "compute.regionTargetHttpsProxies.list",
    "compute.regionTargetHttpsProxies.listEffectiveTags",
    "compute.regionTargetHttpsProxies.listTagBindings",

    # compute.regionTargetTcpProxies.*
    "compute.regionTargetTcpProxies.get",
    "compute.regionTargetTcpProxies.list",

    # compute.regionUrlMaps.*
    "compute.regionUrlMaps.get",
    "compute.regionUrlMaps.invalidateCache",
    "compute.regionUrlMaps.list",
    "compute.regionUrlMaps.listEffectiveTags",
    "compute.regionUrlMaps.listTagBindings",
    "compute.regionUrlMaps.validate",

    # compute.securityPolicies.*
    "compute.securityPolicies.get",
    "compute.securityPolicies.list",
    "compute.securityPolicies.listEffectiveTags",
    "compute.securityPolicies.listTagBindings",
		
    # compute.snapshots.*
    "compute.snapshots.listEffectiveTags",
    "compute.snapshots.listTagBindings",

    # compute.sslCertificates.*
    "compute.sslCertificates.get",
    "compute.sslCertificates.list",
    "compute.sslCertificates.listEffectiveTags",
    "compute.sslCertificates.listTagBindings",

    # compute.sslPolicies.*
    "compute.sslPolicies.get",
    "compute.sslPolicies.list",
    "compute.sslPolicies.listAvailableFeatures",
    "compute.sslPolicies.listEffectiveTags",
    "compute.sslPolicies.listTagBindings",

    # compute.subnetworks.*
    "compute.subnetworks.get",
    "compute.subnetworks.list",
    "compute.subnetworks.listEffectiveTags",
    "compute.subnetworks.listTagBindings",

    # compute.targetGrpcProxies.*
    "compute.targetGrpcProxies.get",
    "compute.targetGrpcProxies.list",

    # compute.targetHttpProxies.*
    "compute.targetHttpProxies.get",
    "compute.targetHttpProxies.list",
    "compute.targetHttpProxies.listEffectiveTags",
    "compute.targetHttpProxies.listTagBindings",

    # compute.targetHttpsProxies.*
    "compute.targetHttpsProxies.get",
    "compute.targetHttpsProxies.list",
    "compute.targetHttpsProxies.listEffectiveTags",
    "compute.targetHttpsProxies.listTagBindings",

    # compute.targetInstances.*
    "compute.targetInstances.get",
    "compute.targetInstances.list",
    "compute.targetInstances.listEffectiveTags",
    "compute.targetInstances.listTagBindings",

    # compute.targetPools.*
    "compute.targetPools.get",
    "compute.targetPools.list",
    "compute.targetPools.listEffectiveTags",
    "compute.targetPools.listTagBindings",

    # compute.targetSslProxies.*
    "compute.targetSslProxies.get",
    "compute.targetSslProxies.list",
    "compute.targetSslProxies.listEffectiveTags",
    "compute.targetSslProxies.listTagBindings",

    # compute.targetTcpProxies.*
    "compute.targetTcpProxies.get",
    "compute.targetTcpProxies.list",
    "compute.targetTcpProxies.listEffectiveTags",
    "compute.targetTcpProxies.listTagBindings",

    # compute.urlMaps.*
    "compute.urlMaps.get",
    "compute.urlMaps.invalidateCache",
    "compute.urlMaps.list",
    "compute.urlMaps.listEffectiveTags",
    "compute.urlMaps.listTagBindings",
    "compute.urlMaps.validate",

    # networksecurity.clientTlsPolicies.*
    "networksecurity.clientTlsPolicies.get",
    "networksecurity.clientTlsPolicies.list",
    "networksecurity.clientTlsPolicies.use",

    # networksecurity.serverTlsPolicies.*
    "networksecurity.serverTlsPolicies.get",
    "networksecurity.serverTlsPolicies.list",
    "networksecurity.serverTlsPolicies.use",

    # resourcemanager.projects.*
    "resourcemanager.projects.get",
    # "resourcemanager.projects.list",

    # serviceusage.quotas.*
    "serviceusage.quotas.get",

    # serviceusage.services.*
    "serviceusage.services.get",
    "serviceusage.services.list"
  ]
}
