# Start Kafka A & B in KRaft mode
docker-compose up -d kafka-a kafka-b

# Wait a bit for brokers to stabilise
sleep 15

# Run Terraform to create topic and launch MirrorMaker2
terraform init
terraform plan -out "migration_plan"
terraform apply "migration_plan"

# Test if the message got replicated to Kafka B
docker exec kafka-b kafka-console-consumer \
  --bootstrap-server kafka-b:9092 \
  --topic my-topic \
  --from-beginning \
  --timeout-ms 3000
