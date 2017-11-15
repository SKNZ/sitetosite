#!/bin/sh

docker build -t gwcloud .
docker rm gwcloud
docker run --privileged --net iso --hostname gwcloud --name gwcloud -it -v cert:/certs gwcloud
