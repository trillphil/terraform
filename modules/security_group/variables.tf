## TAGGING
variable "name" {
  description = "The name of the security group"
}

## GENERAL
variable "vpc_id" {
  description = "The ID of the VPC to add the security group to"
}

## INGRESS RULE
variable "infrom_port" {
  description = "The ingress starting port"
}

variable "into_port" {
  description = "The ingress ending port"
}

variable "inprotocol" {
  description = "The ingress protocol"
}

variable "incidr" {
  type        = "list"
  description = "A list of ingress CIDR blocks"
  default     = []
}

variable "insecurity_groups" {
  type        = "list"
  description = "A list of ingress security groups"
  default     = []
}

## EGRESS RULE
variable "outfrom_port" {
  description = "The egress starting port"
  default     = 0
}

variable "outto_port" {
  description = "The egress ending port"
  default     = 0
}

variable "outprotocol" {
  description = "The egress protocol"
  default     = "-1"
}

variable "outcidr" {
  type        = "list"
  description = "A list of egress CIDR blocks"
  default     = ["0.0.0.0/0"]
}

variable "outsecurity_groups" {
  type        = "list"
  description = "A list of egress security groups"
  default     = []
}

## OUTPUTS
output "group_id" {
  value = "${aws_security_group.group.id}"
}
