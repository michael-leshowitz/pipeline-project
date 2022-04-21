#!/bin/bash

echo "----Resetting target permissions----"
docker exec -u root jenkins chown -R 1000:1000 /var/jenkins_home/workspace/pipeline-docker-maven/java-app/
