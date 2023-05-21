resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "packer build -var 'name=${var.Name}' golden_image.json"
  }
}

data "local_file" "manifest" {
  filename = "manifest.json"
}
