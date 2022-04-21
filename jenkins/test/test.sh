!#/bin/bash

echo "==================="
echo "testing the code"
echo "=================="

docker run --rm -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"
