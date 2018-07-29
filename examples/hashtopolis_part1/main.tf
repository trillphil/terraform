provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

module "hashtopolis01" {
  source        = "github.com/trillphil/terraform/modules//hashtopolis"
  ami           = "ami-759bc50a"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  security_group_ids = [
    "${module.secgroup_hashtopolishttp.group_id}",
    "${module.secgroup_internalssh.group_id}",
  ]

  name           = "hashtopolis01"
  subnet         = "${var.subnet_id}"
  mysql_rootpass = "${var.mysql_rootpass}"
  mysql_apppass  = "${var.mysql_apppass}"
  web_adminpass  = "${var.web_adminpass}"
  voucher_name   = "${var.voucher_name}"
}

# Security group allowing http to hashtopolis
module "secgroup_hashtopolishttp" {
  source      = "github.com/trillphil/terraform/modules//security_group"
  name        = "SG_hashtopolishttp"
  vpc_id      = "${data.aws_vpc.default.id}"
  infrom_port = "80"
  into_port   = "80"
  inprotocol  = "tcp"
  incidr      = ["0.0.0.0/0"]
}

# Security group allowing ssh internally
module "secgroup_internalssh" {
  source      = "github.com/trillphil/terraform/modules//security_group"
  name        = "SG_internalssh"
  vpc_id      = "${data.aws_vpc.default.id}"
  infrom_port = "22"
  into_port   = "22"
  inprotocol  = "tcp"
  incidr      = ["172.31.48.0/20"]
}
