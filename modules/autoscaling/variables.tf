variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
#variable "availability_zones" {}
variable "security_groups" {
  type = list(string)
}
variable "private_subnet_ids" {}
