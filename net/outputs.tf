# ----- net/outputs.tf

output "vpc_id" {
  value = aws_vpc.tkckesproj.id
}

output "aws_public_subnet" {
  value = aws_subnet.pb_tfeks_sn.*.id
}

