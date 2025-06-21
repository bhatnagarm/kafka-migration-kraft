resource "null_resource" "kafka_a_topic" {
  provisioner "local-exec" {
    command = <<EOT
      docker exec kafka-a kafka-topics --create --if-not-exists --topic ${var.topic_name} --bootstrap-server kafka-a:9092 --partitions 1 --replication-factor 1

      for i in $(seq 1 1000); do
        echo "hello-world-$i"
      done | docker exec -i kafka-a kafka-console-producer --bootstrap-server kafka-a:9092 --topic ${var.topic_name}
    EOT
    interpreter = ["bash", "-c"]
  }
}