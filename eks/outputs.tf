# ------ eks/outputs.tf


output "cluster_endpoint" {
  value = aws_eks_cluster.tfceksproj.endpoint
}
output "cluster_name" {
  value = aws_eks_cluster.tfceksproj.name
}
output "endpoint" {
  value = aws_eks_cluster.tfceksproj.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tfceksproj.certificate_authority[0].data
}
output "cluster_id" {
  value = aws_eks_cluster.tfceksproj.id
}