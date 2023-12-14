FROM geomge/cp-server-connect-s3-sink-custom:cp.7.5.1-s3.10.5.7_1.0
ADD build/install/opensearch-connector-for-apache-kafka /usr/share/java/opensearch-connector-for-apache-kafka
USER 1001