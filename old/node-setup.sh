#! /bin/bash
echo "1. Editing /etc/security/limits.conf" 
echo "=====================================" 

rm -rf /tmp/security_limits.conf_2015* 
cp /etc/security/limits.conf /tmp/security_limits.conf_`date +%F_%R` 

var1=`cat /etc/security/limits.conf | grep -i "* soft nofile 10240" | grep -v "#"`;
#echo "$var1";

var2=`cat /etc/security/limits.conf | grep -i "* hard nofile 10240" | grep -v "#"`;
#echo "$var2";

tmp1="* soft nofile 10240"
#echo "$tmp1";

tmp2="* hard nofile 10240"
#echo "$tmp2";

if [ "$var1" == "$tmp1" ] 
then
	echo "Soft limit is already set" 
else
        echo "Putting entries for soft limit in limits.conf file"
	echo -e "* soft nofile 10240" >> /etc/security/limits.conf
fi


if [ "$var2" == "$tmp2" ] 
then
        echo "Hard limit is already set" 
else
        echo "Putting entries for hard limit in limits.conf file"
        echo -e "* hard nofile 10240" >> /etc/security/limits.conf
fi

cat /etc/security/limits.conf 
sleep 3
clear

echo "2. Setting SELINUX=permissive" 
echo "===============================" 
cp /etc/sysconfig/selinux /tmp/selinux_`date +%F_%R` 
tmp=`cat /etc/sysconfig/selinux | grep -i "SELINUX=" | grep -v "#"`;
echo "$tmp";

tmp1=`cat /etc/sysconfig/selinux | grep -i "SELINUX=" | grep -v "#" | cut -d "=" -f2`; 
echo "$tmp1"; 

tmp2="SELINUX=permissive"
echo "$tmp2";

tmp3="SELINUX=$tmp1"
echo "$tmp3";

if [ "$tmp3" == "$tmp2" ] 
then
	echo "SELINUX parameter is already set"; 
else
	echo "Changing SELINUX configuration";
	sed -i.bak "s|$tmp3|$tmp2|g" /etc/sysconfig/selinux
fi

sleep 5
clear

echo "3. Setting Kernel Parameters" 
echo "==============================" 
rm -rf /tmp/grub.conf_2015*
cp /boot/grub/grub.conf /tmp/grub.conf_`date +%F_%R`

temp1=`cat /etc/grub.conf | grep -i "kernel" | grep -v "#" | grep -i "transparent_huge" | wc -l`

if [ $temp1 -gt 0 ] 
then
        echo "Kernel parameter is already set"
        echo "=================================" 
else
        echo "Setting up kernel paramters"
        echo "============================="
        cat /etc/grub.conf | grep -i Kernel | grep -v "#" > /tmp/grub_test
        while read i
        do
                sed -i.bak "s|$i|$i transparent_hugepage=never|g" /etc/grub.conf
        done < /tmp/grub_test
fi

cat /etc/grub.conf 
sleep 5
clear

echo "4. Configuring YUM" 
echo "=====================" 
yum install -y nano ntp git wget openssh-clients 
java-1.7.0-openjdk java-1.7.0-openjdk-devel; 
yum update -y;
clear

echo "5. Turning off iptables" 
echo "=========================" 
chkconfig ip6tables off 
chkconfig iptables off 
echo "Iptables OFF" 
sleep 5
clear

echo "6. Turning on NTP service" 
echo "==========================" 
chkconfig ntpd on 
service ntpd start 
echo "NTP service started" sleep 5
clear

echo "Configuring Ambari repository" 
echo "=================================" 
wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.2/ambari.repo -O /etc/yum.repos.d/ambari.repo;
yum install -y ambari-agent;

clear; 
echo " VERIFICATION" 
echo "=============" 
echo "1. ulimit -n=`ulimit -n`"; 
echo "2. getenforce=`getenforce`"; 
echo "3. `cat /etc/sysconfig/selinux | grep -i "SELINUX=" | grep -v "#"`" 
echo "4. transparent pages=`cat /sys/kernel/mm/redhat_transparent_hugepage/enabled`"; 
echo "5. Hostname=$HOSTNAME" 
service ntpd status 
chkconfig --list | grep -i ip6tables
chkconfig --list | grep -i iptables

sleep 10

echo "Pending" 
echo "========" 
echo "1. Set hostname=SET-TO-HEAD-NODE-FQDN in /etc/ambari-agent/conf/ambari-agent.ini"
echo "2. Reboot the server"


