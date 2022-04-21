!#/bin/bash

echo "--------------------"
echo "--Pushing Image-----"
echo "--------------------"

IMAGE="maven-project"

echo "logging in"
docker login -u mleshowitz -p $PASS
echo "--Tagging Image--"
docker tag $IMAGE:$BUILD_TAG mleshowitz/$IMAGE:$BUILD_TAG
echo "----Pushing Image---"
docker push mleshowitz/$IMAGE:$BUILD_TAG

