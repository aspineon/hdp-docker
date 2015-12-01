FROM centos:6.7
MAINTAINER Michael Fudge <mafudge@syr.edu>
WORKDIR /root
RUN yum update -y && yum install -y  \
	git \
	java-1.7.0-openjdk \
	java-1.7.0-openjdk-devel \
	nano \
	openssh-clients \
	wget 
# Setup Ambari Agent 
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.2/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-agent
# TODO - Set the ambari server name 
