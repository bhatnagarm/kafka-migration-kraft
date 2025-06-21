flowchart LR
    subgraph Cluster_A["Kafka Cluster A"]
        KA[Kafka-a Broker/Controller]
    end

    subgraph Cluster_B["Kafka Cluster B"]
        KB[Kafka-b Broker/Controller]
    end

    MM2[MirrorMaker2]

    KA -- "Mirror messages" --> MM2
    MM2 -- "Replicate messages" --> KB

    MM2 -.-> KA
    MM2 -.-> KB
