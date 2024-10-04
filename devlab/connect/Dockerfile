FROM confluentinc/cp-kafka-connect-base:7.6.1

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

RUN echo "--> Installing Connector Plugins"

# Sink/Source - https://github.com/mongodb/mongo-kafka/blob/master/README.md
RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.12.0

USER appuser
