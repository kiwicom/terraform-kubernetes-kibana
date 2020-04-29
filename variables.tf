variable "helm_install_timeout" {
  type        = number
  default     = 300
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
}

variable "cluster_name" {
  type        = string
  default     = "elasticsearch-cluster"
  description = "Elasticsearch cluster name and release name. Will be used to compse default hosts name"
}

variable "elasticsearch_hosts" {
  type        = string
  default     = ""
  description = "The URLs used to connect to Elasticsearch"
}

variable "es_version" {
  type        = string
  description = "Elasticsearch version"
}

variable "namespace" {
  type        = string
  description = "Namespace in which service will be deployed"
}

variable "replicas" {
  type        = number
  default     = 1
  description = "Kubernetes replica count for the statefulset (i.e. how many pods)"
}

variable "common_annotations" {
  type        = map(string)
  default     = {}
  description = "Common annotations for all the resources"
}

variable "protocol" {
  type        = string
  default     = "http"
  description = "The protocol that will be used for the readinessProbe. Change this to https if you have server.ssl.enabled: true set"
}

variable "resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits   = object({
      cpu    = string
      memory = string
    })
  })

  default = {
    requests = {
      cpu    = "1000m"
      memory = "2Gi"
    }
    limits   = {
      cpu    = "1000m"
      memory = "2Gi"
    }
  }

  description = "Allows you to set the resources for the statefulset"
}

variable "service" {
  type        = object({
    ports = list(object({
      name        = string
      port        = string
      node_port   = string
      target_port = string
    }))
  })
  default     = {
    ports = [
      {
        name        = "http"
        port        = 5601
        node_port   = ""
        target_port = 5601
      }
    ]
  }
  description = "Configurable service to expose the Kibana service"
}

variable "ingress" {
  type        = object({
    enabled = bool
    hosts   = list(object({
      host = string
      path = string
      port = string
    }))
    annotations = map(string)
  })
  default     = {
    enabled = false
    hosts   = [
      {
        host = ""
        path = "/"
        port = 5601
      }
    ]
    annotations = {}
  }
  description = "Configurable ingress to expose the Kibana service"
}

variable "extra_configs" {
  type        = list(object({
    name   = string
    path   = string
    config = string
  }))
  default     = []
  description = "Additional config maps"
}

variable "extra_volumes" {
  type        = string
  default     = ""
  description = "Templatable string of additional volumes to be passsed to the tpl function"
}

variable "extra_containers" {
  type        = string
  default     = ""
  description = "Templatable string of additional containers to be passed to the tpl function"
}

locals {
  elasticsearch_hosts = var.elasticsearch_hosts != "" ? var.elasticsearch_hosts : "http://${var.cluster_name}-master:9200"
}
