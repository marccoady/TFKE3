# ------ root/outputs.tf

output "cluster_name" {
  description = "The name of the cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Conrol pane endpoint for eks"
  value       = module.eks.cluster_endpoint
}

output "cluster_id" {
  description = "the eks clutter id"
  value       = module.eks.cluster_id
}
