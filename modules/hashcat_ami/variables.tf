# Instance

variable "ami" {
  description = "The AMI id for the instance"
}

variable "count" {
  description = "The number of instances to create"
}

variable "instance_type" {
  description = "The size of the instance"
  default     = "t2.micro"
}

variable "subnet" {
  description = "The subnet where the instance will reside"
}

variable "key_name" {
  description = "The name of the SSH private key used to connect to the instance"
}

variable "security_group_ids" {
  type        = "list"
  description = "The IDs of the security groups to be applied to the instance"
}

variable "voucher_name" {
  description = "Hashtopolis voucher to register clients to server"
}

variable "hashtopolis_ip" {
  description = "Private IP address of the hashtopolis server"
}

# Tagging
variable "name" {
  description = "The name of the instance"
}

# Outputs
output "hashcat_private_ips" {
  value = ["${aws_instance.hashcat.*.private_ip}"]
}
