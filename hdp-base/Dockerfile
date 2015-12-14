FROM centos:6.7
MAINTAINER Michael Fudge <mafudge@syr.edu>
WORKDIR /root
RUN yum update -y && yum install -y  \
	curl \
	git \
	java-1.7.0-openjdk \
	java-1.7.0-openjdk-devel \
	nano \
	openssh-clients \
	openssh-server \
	tar \
	unzip \
	wget 

# Setup Hortonworks Mirrors
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.2/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.2.0/hdp.repo

# Set root password to 'hadoop'
RUN echo "root:hadoop" | chpasswd

# Passwordless SSH
# DOES NOT WORK
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_dsa_key
#RUN mkdir /root/.ssh
#ADD conf/id_rsa /root/.ssh/id_rsa
#ADD conf/id_rsa.pub /root/.ssh/id_rsa.pub
#RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
#	chmod 600 /root/.ssh/authorized_keys
#RUN echo "IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config


# Setup Ambari Agent 
# RUN yum install -y ambari-agent
# TODO - Set the ambari server name 


# Entrypoint is SSHD
ENTRYPOINT service sshd restart && bash
