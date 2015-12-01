#!/bin/bash
# setup
echo  "Get Centos 6.7 Image"
docker pull centos:6.7
echo "Prepare HDP Base Node"
docker build -t ischool/hdpbase:v1 ./hdp-node

