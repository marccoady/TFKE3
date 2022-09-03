# ------ eks/outputs.tf


output "cluster_endpoint" {
  value = aws_eks_cluster.tfckesproj.endpoint
}
output "cluster_name" {
  value = aws_eks_cluster.tfckesproj.name
}
output "endpoint" {
  value = aws_eks_cluster.tfckesproj.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tfckesproj.certificate_authority[0].data
}
output "cluster_id" {
  value = aws_eks_cluster.tfckesproj.id
}