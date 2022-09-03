# ----- net/variables.tf


variable "inst_ten" {

}
variable "labels" {

}

variable "vpc_cidr" {}
variable "pb_sn_cnt" {}
variable "pb_cidrs" {
  type = list(any)
}

variable "pb_ip_on_start" {

}
variable "rt_cidr_blk" {

}