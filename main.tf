data "helm_repository" "elastic" {
  name = "elastic"
  url  = "https://helm.elastic.co"
}

// https://github.com/elastic/helm-charts/tree/master/kibana
resource "helm_release" "kibana" {
  name       = var.cluster_name
  repository = data.helm_repository.elastic.metadata[0].name
  chart      = "kibana"
  namespace  = var.namespace
  timeout    = var.helm_install_timeout

  set {
    name  = "elasticsearchHosts"
    value = local.elasticsearch_hosts
  }

  set {
    name  = "elasticsearchURL"
    value = local.elasticsearch_hosts
  }

  set {
    name  = "replicas"
    value = var.replicas
  }

  set {
    name  = "imageTag"
    value = var.es_version
  }

  set {
    name  = "protocol"
    value = var.protocol
  }

  set {
    name  = "resources.requests.cpu"
    value = var.resources.requests.cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.resources.requests.memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.resources.limits.cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.resources.requests.memory
  }
}
