docker-compose up -d

echo "Waiting for Kafka to launch on 9092..."
while ! nc -z kafka 9092; do   
  sleep 1.0
  echo "Kafka not yet ready..."
done 

kafka-topics --bootstrap-server kafka:9092 \
    --topic vehicle-positions \
    --create \
    --partitions 6 \
    --replication-factor 1

docker container run -d \
    --name producer \
    --net explore_confluent \
    cnfltraining/vp-producer:1.0