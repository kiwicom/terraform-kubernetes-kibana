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
  default     = "storage"
  description = "Namespace in which service will be deployed"
}

variable "replicas" {
  type        = number
  default     = 1
  description = "Kubernetes replica count for the statefulset (i.e. how many pods)"
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

locals {
  elasticsearch_hosts = var.elasticsearch_hosts != "" ? var.elasticsearch_hosts : "http://${var.cluster_name}-master:9200"
}
