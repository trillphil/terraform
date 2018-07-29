# Instance

variable "ami" {
  description = "The AMI id for the instance"
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

# Configuration Variables
variable "mysql_rootpass" {
  description = "The password for the MySQL root user"
}

variable "mysql_apppass" {
  description = "The password for the MySQL hashtopolis user"
}

variable "web_adminpass" {
  description = "The hashtopolis web app admin password"
}

variable "voucher_name" {
  description = "Hashtopolis voucher to register clients to server"
}

# Tagging
variable "name" {
  description = "The name of the instance"
}

# Outputs

output "hashtopolis_privateip" {
  value = "${aws_instance.hashtopolis.private_ip}"
}

output "hashtopolis_eip" {
  value = "${aws_eip.hashtopolis.public_ip}"
}
