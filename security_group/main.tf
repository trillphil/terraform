resource "aws_security_group" "group" {
  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = "${var.infrom_port}"
    to_port         = "${var.into_port}"
    protocol        = "${var.inprotocol}"
    cidr_blocks     = ["${var.incidr}"]
    security_groups = ["${var.insecurity_groups}"]
  }

  egress {
    from_port       = "${var.outfrom_port}"
    to_port         = "${var.outto_port}"
    protocol        = "${var.outprotocol}"
    cidr_blocks     = ["${var.outcidr}"]
    security_groups = ["${var.outsecurity_groups}"]
  }

  tags {
    Name = "${var.name}"
  }
}
