# OpenSearch® Sink Connector for Kafka®

This repository is based on Aiven's OpenSearch [Apache Kafka® Connector](http://kafka.apache.org/documentation.html#connect) for Apache
Kafka®.

The project originates from Confluent [kafka-connect-elasticsearch](https://github.com/confluentinc/kafka-connect-elasticsearch). The code was forked before the change of the project's license and all classes were renamed.

# Documentation

## How to install
### Build from Source

Execute gradle task to build binaries:

```shell
./gradlew installDist
# or ./gradlew assembleDist to package binaries
```

This produces an output on `build/install` directory with the plugin binaries to add into Connect cluster.

### Add plugin to Connect worker

Place unpacked binaries into a directory on each Connect worker node, e.g. `/kafka-connect-plugins`.

In this case, place `opensearch-connector-for-kafka` into `/kafka-connect-plugins`:

```
/kafka-connect-plugins
└── opensearch-connector-for-apache-kafka
```

Then, on each connect worker configuration make sure to add `/kafka-connect-plugins` to the `plugin.path` configuration:

```properties
plugin.path=/kafka-connect-plugins
```

### Validate Connector plugin installation

Once placed on each worker node, start the workers and check the plugins installed
and check the plugin (with the correct version) is included:

```shell
# Go to connector rest api
curl http://localhost:8083/connector-plugins | jq .
```
```json
[
  ...
  {
    "class": "kafka.connect.opensearch.OpensearchSinkConnector",
    "type": "sink",
    "version": "3.0.0"
  },
  ...
]
```

## Connector Configuration

[OpenSearch® Sink Connector Configuration Options](docs/opensearch-sink-connector-config-options.rst)

## Docker Container

Use the Dockerfile in this project to create a container image which extends a previously created Kafka COnnect image with the binaries for Opensearch Sink connector
(The base image used in this project extends Confluent Kafka Connect image, installs S3 sink connector from Confluent hub, and includes a custom field and time partitioner jar file to the required location)

Sample docker build command

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t geomge/cp-server-connect-s3-and-opensearch-sink:cp.7.5.1-s3.10.5.7_1.0-os.3.2.0 --push .
```
If you have not used a multi-arch / multi-platform build previously using buildx, execute following command to create one

```bash
docker buildx create --name mybuilder --bootstrap --use
```

# License

The project is licensed under the [Apache 2 license](https://www.apache.org/licenses/LICENSE-2.0).
See [LICENSE](LICENSE).

# Trademark

Apache Kafka, Apache Kafka Connect are either registered trademarks or trademarks of the Apache Software Foundation in the United States and/or other countries.

OpenSearch is a trademark and property of its respective owners. All product and service names used in this website are for identification purposes only and do not imply endorsement.
