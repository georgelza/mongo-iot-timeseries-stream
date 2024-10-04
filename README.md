# Working with MongoDB Timeseries Collections

Timeseres Data is a common requirement for IoT and Industrial IoT applications.
It does introduce a concept that needs to be consider, every record is primarily comprised out of 3 components.

    - timestamp of the event
    - metadata about the event
        this can be a array of key/value pairs.
    - measurement/value of the event

This does as such then imply that a timeseries record can not store 2 values.
If multiple values need to be stored they will be seperate records with different metadata tags describing the different measurement being recorded.

Our data flow will be:

 - Data generated via Shadowtraffic application.
 - Shadowtraffic posting payloads onto a Kafka topic
 - From Kafka we will use the connector framework to sinked the measurements into a MongoDB Timeseries specific Collection.

## Payload

```		
{
    "timestamp" : "2024-10-02T00:00:00.869Z",
    "metadata" : {
        "siteId" : 1009,
        "deviceId" : 1042,
        "sensorId" : 10180,
        "unit" : "Psi"
    },
    "measurement" : 1013.3997
}
```

To keep things simple we will host the shadowtraffic application and the Kafka stack locally, this will then be pointed to MongoDB Atlas instance in the cloud.

To visualise the timeseries data I opened a free Grafana account which I then connected via a datasource connector to the MongoDB timeseires collection.

Everything that runs locally is deployed using a docker-compose.yaml file.


- [MongoDB Timeseries Collection](https://www.mongodb.com/docs/manual/core/timeseries-collections/)


## Grafana

As per above, we will deploy Grafana Dashboards to visualize the data.

Note: As the data is stored in a MongoDB Timeseries collection you will require a trial license for Grafana Enterprise.

A non production, single user, test/development license is available for Grafana Enterprise. (A free tier Grafana Cloud account, will allow you to use 1 Enterprise Connector for as long as you want. There's no time limit. ) 

See:

- [Grafana Cloud](https://grafana.com/products/cloud/)


## Shadowtraffic.

So I have a larger project MongoCreator where in I use a custom Golang application to create 2 sets of documents posted onto Kafka Topics. well it's over a 1000 lines... Learned allot writing it..., no regrets, but decided for this project I don't want to create a custom data generator so in comes Shadowtraffic by [Michael Drogalis](https://www.linkedin.com/in/michael-drogalis/)

Shadowtraffic will allow me to accomplish a similar fake data generation capability by simply providing it with a json based configuration file specifying how we want the output data to be structured and where to post it, simplying things allot!

See:

- [Shadowtraffic](https://shadowtraffic.io)

- [ChatGPT Interface to help configure your config.json file](https://chatgpt.com/share/34e8a7e8-9646-48d3-b67e-b08e45b42016)

- [Great Overview by Michael the creator](https://www.youtube.com/playlist?list=PLB8as4ufg7p9xii07ZM0sfPsLfq1j-vLe)


###  Run Locally during development.

    docker run  --rm \
        --name shadow \
        -p 9400:9400 \
        --network timeseries \
        -v $(pwd)/conf:/workspace \
         --env-file $(pwd)/conf/license.env \
        --env-file $(pwd)/conf/params.env \
        shadowtraffic/shadowtraffic:0.7.16 \
        --config /workspace/config.json \
        --watch --seed 341248291 --sample 10 --stdout 


###  Studio Access, if enabled.

Navigate to http://localhost:9876


### Watch...

```watch 'docker exec shadowtraffic curl -s localhost:9400/metrics |grep events_sent'```
