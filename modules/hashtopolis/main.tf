data "aws_subnet" "subnet" {
  id = "${var.subnet}"
}

# install mysql, apache, php, etc.
data "template_file" "userdata" {
  template = "${file("${path.module}/user_data.template")}"

  vars {
    mysql_rootpass = "${var.mysql_rootpass}"
  }
}

# configure hashtopolis
data "template_file" "hashtopolis" {
  template = "${file("${path.module}/hashtopolis.template")}"

  vars {
    mysql_rootpass = "${var.mysql_rootpass}"
    mysql_apppass  = "${var.mysql_apppass}"
    web_adminpass  = "${var.web_adminpass}"
    voucher_name   = "${var.voucher_name}"
  }
}

resource "aws_instance" "hashtopolis" {
  subnet_id              = "${data.aws_subnet.subnet.id}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${data.template_file.userdata.rendered}"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name               = "${var.key_name}"

  tags {
    "Name" = "${var.name}"
  }

  provisioner "file" {
    content     = "${data.template_file.hashtopolis.rendered}"
    destination = "/tmp/hashtopolis.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/hashtopolis.sh",
      "/tmp/hashtopolis.sh",
      "rm /tmp/hashtopolis.sh",
    ]
  }

  connection {
    host        = "${aws_instance.hashtopolis.private_ip}"
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name}")}"
  }
}

resource "aws_eip" "hashtopolis" {
  instance = "${aws_instance.hashtopolis.id}"
}
