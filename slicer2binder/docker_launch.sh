#!/bin/sh

docker build -t slicerj .
docker run -p49053:49053 -p49054:49054 -d slicerj /slicer/run.sh
