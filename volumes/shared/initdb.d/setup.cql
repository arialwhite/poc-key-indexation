CREATE KEYSPACE IF NOT EXISTS "kafka_topics"
WITH REPLICATION = {
  'class': 'SimpleStrategy', 'replication_factor': 1
};

CREATE TABLE IF NOT EXISTS "kafka_topics"."small_topic" (
  "key" text,
  "value" text,
  "offset" double,
  "partition" int,
  primary key (key, partition, offset)
);