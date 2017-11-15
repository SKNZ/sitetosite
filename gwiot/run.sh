#!/bin/sh

docker build -t gwiot .
docker rm gwiot
docker run --privileged --net iso --hostname gwiot --name gwiot -it -v cert:/certs gwiot
