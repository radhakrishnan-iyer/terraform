module "mywebserver" {
  source = "./modules/webserver"
  # passing the params
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key = file("${path.module}/id_rsa.pub")
  key_name = "${var.key_name}"
}

output "publicIp" {
    value = module.mywebserver.publicIp
}