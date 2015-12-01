#!/bin/bash
# hdp-docker setup

# todo apt-get upate
# todo install docker ???

echo  "*** Get Centos 6.7 Image ***"
docker pull centos:6.7

echo "*** Prepare HDP Base Node ***"
docker build -t ischool/hdpbase:v1 ./hdp-node

echo "*** Setup Hosts File for hdp-docker ***"
txtsrch="# hdp-docker hosts"
txtfind=`grep "$txtsrch" /etc/hosts`
if  [ "$txtsrch" != "$txtfind" ]
then
	echo "    Adding Hosts...."
	cat data/hosts.add >> /etc/hosts
else
	echo "    Hosts alread exist"
fi 
