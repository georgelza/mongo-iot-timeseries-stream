#!/bin/bash

# Register Schema's on local topics
schema=$(cat ./schema_telemetryEvents.json | sed 's/\"/\\\"/g' | tr -d "\n\r")
SCHEMA="{\"schema\": \"$schema\", \"schemaType\": \"JSON\"}"
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data "$SCHEMA" \
  http://localhost:9081/subjects/telemetryEvents-value/versions
