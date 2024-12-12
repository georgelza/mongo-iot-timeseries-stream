#!/bin/bash


#------------------------------------------------------------------------------
#-- Post/Sink to Atlas

. ./.pwdmongoatlas

# above file contains:
#
# ATLAS
# export MONGO_URL=mongodb+srv://username:password@cluster_url

# https://www.mongodb.com/docs/kafka-connector/upcoming/tutorials/migrate-time-series/
#
# https://forum.confluent.io/t/kafka-sink-connector-for-mongo-returns-collection-already-exists-for-that-is-not-a-timeseries-collection-even-though-it-is/10739

curl -X POST \
  -H "Content-Type: application/json" \
  --data '
      { "name": "mongo-atlas-telemetryEvents-sink",
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