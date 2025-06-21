# Kafka KRaft Migration Demo

This project demonstrates migrating messages between two independent Kafka KRaft clusters using MirrorMaker2.

## Design Diagram

![Kafka Migration Diagram](./documentation/images/kafka_migration.jpg)

---

## 1. Start Two Kafka Clusters

The following command will start two **separate Kafka clusters** (`kafka-a` and `kafka-b`) in KRaft mode:

```sh
docker-compose up -d kafka-a kafka-b
```

---

## 2. Wait for Clusters to Stabilize

Wait until both clusters are fully started.  
You can check their logs with:

```sh
docker logs -f kafka-a
docker logs -f kafka-b
```

> **What to look for:**  
> - Both brokers should show logs indicating they are running as controllers and brokers.
> - No errors or repeated restarts.

---


# 3. Run Terraform to create topic and launch MirrorMaker2
This will configure and start MirrorMaker2 to migrate messages from `kafka-a` to `kafka-b`:

```sh
terraform init
terraform plan -out "migration_plan"
terraform apply "migration_plan"
```

---

## 5. Verify Message Replication

Consume messages from the mirrored topic on `kafka-b`:

```sh
docker exec kafka-b kafka-console-consumer \
  --bootstrap-server kafka-b:9092 \
  --topic A.my-topic \
  --from-beginning \
  --timeout-ms 5000
```

---

## Useful Commands

- **List Topics in Kafka A:**  
  `docker exec kafka-a kafka-topics --bootstrap-server kafka-a:9092 --list`

- **List Topics in Kafka B:**  
  `docker exec kafka-b kafka-topics --bootstrap-server kafka-b:9092 --list`

- **Consume Messages in Kafka A:**  
  `docker exec kafka-a kafka-console-consumer --bootstrap-server kafka-a:9092 --topic my-topic --from-beginning --timeout-ms 5000`

- **Consume Messages in Kafka B:**  
  `docker exec kafka-b kafka-console-consumer --bootstrap-server kafka-b:9092 --topic A.my-topic --from-beginning --timeout-ms 5000`

---
