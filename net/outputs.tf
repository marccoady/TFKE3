# ----- net/outputs.tf

output "vpc_id" {
  value = aws_vpc.tfceksproj.id
}

output "aws_pb_sn" {
  value = aws_subnet.pb_tfceks_sn.*.id
}

