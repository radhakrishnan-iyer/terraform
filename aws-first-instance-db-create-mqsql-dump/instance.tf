# creating ec2 instance
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
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

  provisioner "local-exec" {
    command = "env>env.txt"
    environment = {
      envname = "envvalue"
    }
  }

  provisioner "local-exec" {
    command = "echo 'at Create'"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo 'at delete'"
  }

  provisioner "remote-exec" {
    inline = [ 
      "ifconfig > /tmp/ifconfig.output",
      "echo 'Hello RK' >/tmp/test.txt"
     ]
  }

  provisioner "remote-exec" {
    script = "/testscript.sh"
  }
}