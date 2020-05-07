// original chart -> https://github.com/elastic/helm-charts/tree/master/kibana
resource "helm_release" "kibana" {
  name      = local.full_name_override
  chart     = "${path.module}/chart"
  namespace = var.namespace
  timeout   = var.helm_install_timeout

  set {
    name  = "fullnameOverride"
    value = local.full_name_override
  }

  set {
    name  = "elasticsearchHosts"
    value = var.elasticsearch_hosts
  }

  set {
    name  = "elasticsearchURL"
    value = var.elasticsearch_hosts
  }

  set {
    name  = "httpPort"
    value = var.http_port
  }

  set {
    name  = "replicas"
    value = var.replicas
  }

  set {
    name  = "imageTag"
    value = var.es_version
  }

  dynamic "set" {
    for_each = var.common_annotations

    content {
      name  = "commonAnnotations.\"${set.key}\""
      value = var.common_annotations[set.key]
    }
  }

  set {
    name  = "protocol"
    value = var.protocol
  }

  dynamic "set" {
    for_each = var.kibana_config

    content {
      type  = "string"
      name  = "kibanaConfig.${set.key}"
      value = var.kibana_config[set.key]
    }
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

  dynamic "set" {
    for_each = var.service.ports

    content {
      name  = "service.ports[${set.key}].name"
      value = var.service.ports[set.key].name
    }
  }

  dynamic "set" {
    for_each = var.service.ports

    content {
      name  = "service.ports[${set.key}].port"
      value = var.service.ports[set.key].port
    }
  }

  dynamic "set" {
    for_each = var.service.ports

    content {
      name  = "service.ports[${set.key}].nodePort"
      value = var.service.ports[set.key].node_port
    }
  }

  dynamic "set" {
    for_each = var.service.ports

    content {
      name  = "service.ports[${set.key}].targetPort"
      value = var.service.ports[set.key].target_port
    }
  }

  set {
    name  = "ingress.enabled"
    value = var.ingress.enabled
  }

  dynamic "set" {
    for_each = var.ingress.hosts

    content {
      name  = "ingress.hosts[${set.key}].host"
      value = var.ingress.hosts[set.key].host
    }
  }

  dynamic "set" {
    for_each = var.ingress.hosts

    content {
      name  = "ingress.hosts[${set.key}].path"
      value = var.ingress.hosts[set.key].path
    }
  }

  dynamic "set" {
    for_each = var.ingress.hosts

    content {
      name  = "ingress.hosts[${set.key}].port"
      value = var.ingress.hosts[set.key].port
    }
  }

  dynamic "set" {
    for_each = var.ingress.annotations

    content {
      name  = "ingress.annotations.\"${set.key}\""
      value = var.ingress.annotations[set.key]
    }
  }

  dynamic "set" {
    for_each = var.extra_configs

    content {
      name  = "extraConfigs[${set.key}].name"
      value = var.extra_configs[set.key].name
    }
  }

  dynamic "set" {
    for_each = var.extra_configs

    content {
      name  = "extraConfigs[${set.key}].path"
      value = var.extra_configs[set.key].path
    }
  }

  dynamic "set" {
    for_each = var.extra_configs

    content {
      name  = "extraConfigs[${set.key}].config"
      value = var.extra_configs[set.key].config
    }
  }

  set {
    name  = "extraVolumes"
    value = var.extra_volumes
  }

  set {
    name  = "extraContainers"
    value = var.extra_containers
  }
}
