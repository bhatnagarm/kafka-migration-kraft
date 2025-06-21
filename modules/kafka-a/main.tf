resource "null_resource" "kafka_a_topic" {
  provisioner "local-exec" {
    command = "docker exec kafka-a kafka-topics --create --topic my-topic --bootstrap-server kafka-a:9092 --partitions 1 --replication-factor 1 & echo hello from Kafka A | docker exec -i kafka-a kafka-console-producer --bootstrap-server kafka-a:9092 --topic my-topic"
    interpreter = ["cmd", "/C"]
  }
}
