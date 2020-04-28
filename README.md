# terraform-kubernetes-kibana

Kibana module for Kubernetes based on [elastic Helm charts](https://github.com/elastic/helm-charts/tree/master/kibana).

## Usage

```hcl-terraform
locals {
  cluster_name = "elasticsearch-cluster"
  es_version   = "6.2.3"
}

resource "kubernetes_storage_class" "es_ssd" {
  metadata {
    name = "es-ssd"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  parameters          = {
    type = "pd-ssd"
  }
}

module "elasticsearch_client" {
  source                = "kiwicom/elasticsearch/kubernetes"
  version               = "~> 1.0.0" # version >= 1.0.0 and < 1.1.0, e.g. 1.0.X
  cluster_name          = local.cluster_name
  node_group            = "client"
  es_version            = local.es_version
  namespace             = "storage"
  replicas              = 2
  master_eligible_nodes = 3
  storage_class_name    = kubernetes_storage_class.es_ssd.metadata[0].name
  storage_size          = "1Gi"
}

module "elasticsearch_master" {
  source                = "kiwicom/elasticsearch/kubernetes"
  version               = "~> 1.0.0" # version >= 1.0.0 and < 1.1.0, e.g. 1.0.X
  node_group            = "master"
  cluster_name          = local.cluster_name
  es_version            = local.es_version
  namespace             = "storage"
  replicas              = 3
  master_eligible_nodes = 3
  storage_class_name    = kubernetes_storage_class.es_ssd.metadata[0].name
  storage_size          = "5Gi"
}

module "elasticsearch_data" {
  source                = "kiwicom/elasticsearch/kubernetes"
  version               = "~> 1.0.0" # version >= 1.0.0 and < 1.1.0, e.g. 1.0.X
  node_group            = "data"
  cluster_name          = local.cluster_name
  es_version            = local.es_version
  namespace             = "storage"
  replicas              = 3
  master_eligible_nodes = 3
  storage_class_name    = kubernetes_storage_class.es_ssd.metadata[0].name
  storage_size          = "20Gi"
}

module "elasticsearch_kibana" {
  source       = "kiwicom/kibana/kubernetes"
  version      = "~> 1.0.0" # version >= 1.0.0 and < 1.1.0, e.g. 1.0.X
  cluster_name = local.cluster_name
  es_version   = local.es_version
  namespace    = "storage"
}
```

### Variables

In order to check which variables are customizable, check `variables.tf`.
