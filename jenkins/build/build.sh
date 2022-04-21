!#/bin/bash

#Copy New Jar
cp -f java-app/target/*.jar jenkins/build/

echo "================"
echo "Builing docker image"
echo "================"

cd jenkins/build/ && docker-compose -f docker-compose-build.yml build --no-cache

ls -l /var/jenkins_home/pipeline-docker-maven/java-app/
