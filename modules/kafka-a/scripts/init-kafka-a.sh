#!/bin/bash
set -e

echo "[Kafka A] Creating topic..."
docker exec kafka-a kafka-topics --create \
  --topic my-topic \
  --bootstrap-server kafka-a:9092 \
  --partitions 1 \
  --replication-factor 1

echo "hello from Kafka A" | docker exec -i kafka-a kafka-console-producer \
  --bootstrap-server kafka-a:9092 \
  --topic my-topic

echo "[Kafka A] Topic created and message sent."
