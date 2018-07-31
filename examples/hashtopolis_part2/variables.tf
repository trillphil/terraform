# AWS DETAILS
variable "region" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID for the VPC to use"
}

variable "subnet_id" {
  description = "ID of the subnet to use"
}

variable "key_name" {
  description = "SSH key name to use for provisioning"
}

# HASHCAT DETAILS
variable "hashcat_ami" {
  description = "AMI for hashcat instance"
}

variable "hashcat_instancesize" {
  description = "EC2 instance size for hashcat instance"
  default     = "t2.micro"
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

output "hashcat_ips" {
  value = "${module.hashcat.hashcat_private_ips}"
}
