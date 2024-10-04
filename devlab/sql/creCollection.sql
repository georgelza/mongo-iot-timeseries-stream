# MongoDB - Time Series Collection

# If database does not exist then it's created.
use telemetrics;

# Create tsdb specific collection
db.createCollection("telemetryEvents", {
  timeseries: {
    timeField:    "timestamp",
    metaField:    "metadata",
    granularity:  "seconds"
  },
  expireAfterSeconds: 86400
});





