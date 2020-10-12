variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "key_path" {
  type    = string
  default = "/Users/david/Terraform-projects/deploy_iac_tf_ansible/.ssh/id_rsa.pub"
}

variable "instance-type" {
  type    = string
  default = "t3.micro"
}

variable "webserver-port" {
  type    = number
  default = 80
}

variable "linuxami" {
  type    = string
  default = "ami-0947d2ba12ee1ff75"
}