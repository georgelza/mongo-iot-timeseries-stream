#!/bin/bash

# https://www.confluent.io/blog/kafka-connect-deep-dive-converters-serialization-explained/
#------------------------------------------------------------------------------
#-- Post/Sink to Local Mongo container

. ./.pwdmongolocal

# above file contains:
#
# LOCAL
# export MONGO_URL=mongodb://hostname:port/?directConnection=true



curl -X POST \
  -H "Content-Type: application/json" \
  --data '
      { "name": "mongo-local-telemetryEvents-sink",
        "config": {
          "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
          "topics": "telemetryEvents",
          "connection.uri": "'${MONGO_URL}'",
          "database": "MongoCom0",
          "collection": "telemetryEvents",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter": "org.apache.kafka.connect.json.JsonConverter",
          "key.converter.schemas.enable":"false",
          "value.converter.schemas.enable": "false",
          "timeseries.timefield": "timestamp",
          "timeseries.metafield": "metadata",
          "timeseries.timefield.auto.convert": "true"
        }
      }
      ' \
  http://localhost:8083/connectors -w "\n"


curl -X POST \
  -H "Content-Type: application/json" \
  --data '
      { "name": "mongo-local-stocktickerEvents-sink",
        "config": {
          "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
          "topics": "stocktickerEvents",
          "connection.uri": "'${MONGO_URL}'",
          "database": "MongoCom0",
          "collection": "stocktickerEvents",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter": "org.apache.kafka.connect.json.JsonConverter",
          "key.converter.schemas.enable":"false",
          "value.converter.schemas.enable": "false",
          "timeseries.timefield": "timestamp",
          "timeseries.metafield": "metadata",
          "timeseries.timefield.auto.convert": "true"
        }
      }
      ' \
  http://localhost:8083/connectors -w "\n"

