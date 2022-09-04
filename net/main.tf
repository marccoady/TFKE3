# ----- net/main.tf

resource "aws_vpc" "tfceksproj" {
  cidr_block       = var.vpc_cidr 
  instance_tenancy = var.inst_ten
  tags = {
    Name = var.labels
  }
}

resource "aws_internet_gateway" "tfceksproj_gw" {
  vpc_id = aws_vpc.tfceksproj.id

  tags = {
    Name = var.labels
  }
}
data "aws_availability_zones" "free" {
}


resource "random_shuffle" "av_zones" {
  input        = data.aws_availability_zones.free.names
  result_count = 2
}

resource "aws_subnet" "pb_tfceks_sn" {
  count                   = var.pb_sn_cnt
  vpc_id                  = aws_vpc.tfceksproj.id
  cidr_block              = var.pb_cidrs[count.index]
  availability_zone       = random_shuffle.av_zones.result[count.index]
  map_public_ip_on_launch = var.pb_ip_on_start
  tags = {
    Name = var.labels
  }
}


resource "aws_default_route_table" "int_tfceksproj_default" {
  default_route_table_id = aws_vpc.tfceksproj.default_route_table_id

  route {
    cidr_block = var.rt_cidr_blk
    gateway_id = aws_internet_gateway.tfceksproj_gw.id
  }
  tags = {
    Name = var.labels
  }
}

resource "aws_route_table_association" "default" {
  count          = var.pb_sn_cnt
  subnet_id      = aws_subnet.pb_tfceks_sn[count.index].id
  route_table_id = aws_default_route_table.int_tfceksproj_default.id
}

