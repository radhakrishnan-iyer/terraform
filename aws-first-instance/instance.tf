data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["679593333241"]
  filter {
    name = "name"
    values = ["${var.image_name}"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# creating ec2 instance
resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.instance_type}"
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "first-tf-instance"
  }
  user_data = file("${path.module}/script.sh")

  # 3 types of provisioner - file, local-exec, remote-exec

  connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("${path.module}/id_rsa")
      host = "${self.public_ip}"
  }
 
  provisioner "file" {
    source      = "readme.md"
    destination = "/tmp/readme.md"
  }

  provisioner "file" {
    content      = "this is test content"
    destination = "/tmp/content.md"
  }

  provisioner "file" {
    source      = "test"
    destination = "/tmp/"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mytemp.txt"
  }

  provisioner "local-exec" {
    working_dir = "/tmp/"
    command = "echo ${self.public_ip} > mytemp.txt"
  }

  provisioner "local-exec" {
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('HelloWorld')"
  }
}