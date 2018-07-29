# AWS DETAILS
variable "region" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID for the AWS VPC to use"
}

variable "subnet_id" {
  description = "ID of the AWS subnet to use"
}

variable "key_name" {
  description = "SSH key name to use for provisioning"
}

# HASHTOPOLIS DETAILS
variable "voucher_name" {
  description = "Hashtopolis voucher to register clients to server"
}

variable "mysql_rootpass" {
  description = "MySQL root password"
}

variable "mysql_apppass" {
  description = "MySQL password for hashtopolis application user"
}

variable "web_adminpass" {
  description = "Admin password for hashtopolis"
}

# OUTPUTS
output "hashtopolis_ip" {
  value = "${module.hashtopolis01.hashtopolis_eip}"
}
