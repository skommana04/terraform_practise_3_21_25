variable "ami_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_groups" {
  type = list(string)

}
