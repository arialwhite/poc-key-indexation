# POC - Indexation des clefs des messages Kafka

L'objectif est d'indexer les clefs des messages Kafka dans une base de données NoSQL. 
Afin de pouvoir retrouver un message à partir de sa clef dans un dashboard.

**Notes: Projet actuellement en cours de réalisation**

## Vue d'ensemble

### Services

- Kafka
- Zookeeper
- Rest-proxy
- Schema-registry
- Spark
- Cassandra

### Principe

Production messages -> Kafka -> Spark Streaming -> Cassandra -> Lecture messages

## Installation

- Installation docker, docker-compose (https://docs.docker.com/compose/install/)
- Récupération du projet et des sous modules git
```
git clone  --recursive https://github.com/arialwhite/poc-key-indexation.git
```
- Lancement start.sh
```
chmod u+x ./start.sh
sudo ./start.sh
```

## Usage

- Interface web kafka localhost:9000
- Interface web spark localhost:18080
- Liste des messages dans cassandra (JSON) localhost:9300

Envoie messages dans Kafka
```
docker exec indexer_kafka_1 bash -c "echo 'msg_key:msg_value' | kafka-console-producer --broker-list localhost:29092 --topic small_topic --property 'key.separator=:' -property 'parse.key=true'"

```

## Documentation

- http://docs.confluent.io/current/cp-docker-images/docs/quickstart.html#getting-started-with-docker-compose


