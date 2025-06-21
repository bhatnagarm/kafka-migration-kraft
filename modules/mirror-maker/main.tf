resource "null_resource" "start_mirror_maker" {
  provisioner "local-exec" {
    command = "docker-compose up -d mirror-maker"
  }
}
