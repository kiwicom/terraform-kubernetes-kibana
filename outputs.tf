output "kibana_endpoint" {
  value = "${var.protocol}://${var.cluster_name}-kibana.${var.namespace}.svc.cluster.local:5601"
}
