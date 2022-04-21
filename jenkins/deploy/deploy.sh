#!/bin/bash

echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

scp -i /opt/prod /tmp/.auth prod@192.168.1.22:/tmp/.auth
scp -i /opt/prod ./jenkins/deploy/publish.sh prod@192.168.1.22:/tmp/publish.sh
ssh -i /opt/prod prod@192.168.1.22 "/tmp/publish.sh"
