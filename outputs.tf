output "kibana_endpoint" {
  value = "${var.cluster_name}-kibana.${var.namespace}.svc.cluster.local"
}
