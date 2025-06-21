module "kafka_a" {
  source     = "./modules/kafka-a"
  topic_name = var.topic_name
}

module "kafka_b" {
  source = "./modules/kafka-b"
}

module "mirror_maker" {
  source     = "./modules/mirror-maker"
  depends_on = [module.kafka_a, module.kafka_b]
}
