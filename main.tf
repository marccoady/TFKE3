# -----root/main.tf

module "eks" {
  source          = "./eks"
  aws_pb_sn       = module.vpc.aws_pb_sn
  vpc_id          = module.vpc.vpc_id
  cluster_name    = "tfcloud-eks-${random_string.suffix.result}"
  endnt_pb_acc    = true
  endpnt_pvt_acc  = false
  pb_cidrs        = ["0.0.0.0/0"]
  node_group_name = "tfcloud"
  desired_size    = 1
  max_size        = 1
  min_size        = 1
  instance        = ["t2.micro"]
  key_pair        = "August2022"
}

module "net" {
  source              = "./net"
  labels                = "TFCEksProj"
  inst_ten            = "default"
  vpc_cidr            = "10.0.0.0/16"
# access_ip           = "0.0.0.0/0"
  pb_sn_cnt           = 2
  pb_cidrs            = ["10.0.3.0/24", "10.0.4.0/24"]
  pb_ip_on_start      = true
  rt_cidr_blk = "0.0.0.0/0"

}

