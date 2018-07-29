data "aws_subnet" "subnet" {
  id = "${var.subnet}"
}

# install dependencies
data "template_file" "userdata" {
  template = "${file("${path.module}/dep_install.template")}"

  vars {
    hostname = "${var.name}"
  }
}

# configure hashcat and hashtopolis client
data "template_file" "hashtopolis" {
  template = "${file("${path.module}/hashtopolis.template")}"

  vars {
    voucher_name   = "${var.voucher_name}"
    hashtopolis_ip = "${var.hashtopolis_ip}"
  }
}

resource "aws_instance" "hashcat" {
  count                  = "${var.count}"
  subnet_id              = "${data.aws_subnet.subnet.id}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${data.template_file.userdata.rendered}"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name               = "${var.key_name}"

  tags {
    "Name" = "${var.name}${format("%02d", count.index + 1)}"
  }

  provisioner "file" {
    content     = "${data.template_file.hashtopolis.rendered}"
    destination = "${var.script}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.name}${format("%02d", count.index + 1)}",
    ]
  }

  # run hashtopolis template
  provisioner "remote-exec" {
    inline = [
      "chmod u+x ${var.script}",
      "~/${var.script}",
      "rm ${var.script}",
    ]
  }

  connection {
    host        = "${self.private_ip}"
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name}")}"
  }
}
