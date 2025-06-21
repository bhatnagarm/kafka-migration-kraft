resource "null_resource" "kafka_b_check" {
  provisioner "local-exec" {
    command = "echo 'Kafka B ready...'"
  }
}
