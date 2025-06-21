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
  --topic A.my-topic \
  --from-beginning \
  --timeout-ms 3000


Useful commands:
List Topics in Kafka A: `docker exec kafka-a kafka-topics --bootstrap-server kafka-a:9092 --list`
List Topics in Kafka B: `docker exec kafka-b kafka-topics --bootstrap-server kafka-b:9092 --list`
List messages in Broker for Kafka A: `docker exec kafka-a kafka-console-consumer --bootstrap-server kafka-a:9092 --topic my-topic --from-beginning --timeout-ms 5000`
List messages in Broker for Kafka B: `docker exec kafka-b kafka-console-consumer   --bootstrap-server kafka-b:9092   --topic A.my-topic   --from-beginning   --timeout-ms 5000`
