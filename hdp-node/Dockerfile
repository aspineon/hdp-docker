FROM centos:6.7
MAINTAINER Michael Fudge <mafudge@syr.edu>
WORKDIR /root
RUN yum update -y && yum install -y  \
	git \
	java-1.7.0-openjdk \
	java-1.7.0-openjdk-devel \
	nano \
	ntp \
	openssh-clients \
	wget 
RUN chkconfig ntpd on
RUN wget http://gw.ischool.syr.edu/node-setup.sh
RUN source /root/node-setup.sh

	
