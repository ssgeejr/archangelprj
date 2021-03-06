# #This can be used if you KNOW you have access to the epel-release repo file 
# #otherwise, use the wget and direct install
#yum install -y epel-release


adduser devops
cd /home/devops
mkdir .ssh

cat << EOF > /home/devops/.ssh/config
Host *
    StrictHostKeyChecking no
EOF

cat << EOF >> /home/devops/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDl1Gf4uxDM0asx8IVTCBM9MRVBiwnmeRdzIJWJkkH3i+E1pQgz5jNFt71XRVlB2U8aAuaxYivhr6ISwlBPaAFTHbJ7pJcjY0MzaR8wIrmRGC/Lgn9ggN8LncxPBxqLQX2JJm87pyxwjP2+ZGKq1RHpv1mguRyyIz5XifHmjIOpDw== devops@sku.sprint.com
EOF

chown -R devops.devops /home/devops/.ssh
chmod 600 /home/devops/.ssh/*
chmod 700 /home/devops/.ssh

echo "%devops ALL=(ALL) NOPASSWD: LOG_INPUT: ALL"  > /etc/sudoers.d/scm-devops

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y epel-release-latest-7.noarch.rpm
rm -f epel-release-latest-7.noarch.rpm
yum install -y ftp://bo.mirror.garr.it/1/slc/centos/7.1.1503/extras/x86_64/Packages/container-selinux-2.21-1.el7.noarch.rpm

yum install -y wget curl ansible git tmux python-pip python-dev build-essential lynx elinks tree

curl -fsSL https://get.docker.com/ | sh

pip install -U pip
pip install --ignore-installed docker-compose

systemctl start docker
systemctl enable docker

cd /opt
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz -O jdk-8u171-linux-x64.tar.gz
tar -zxf jdk-8u171-linux-x64.tar.gz
rm -rf jdk-8*
update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_181/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_181/bin/javac 1
update-alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_181/bin/jar 1


wget http://www-us.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
tar -zxvf apache-maven-3.5.3-bin.tar.gz
rm -f apache-maven-3.5.3-bin.tar.gz
mv apache-maven-3.5.3 maven-3.5.3
update-alternatives --install /usr/bin/mvn maven /opt/maven-3.5.3/bin/mvn 1


echo "JAVA_HOME=/opt/jdk1.8.0_181 " >> /etc/profile
echo "M2_HOME=/opt/maven-3.5.3" >> /etc/profile
echo "export JAVA_HOME M2_HOME" >> /etc/profile

. /etc/profile


usermod -aG docker devops


# Stopping here ... this should have everything configured and ready to go for remote administration
# the commands that come next will be in a new script and should install all of the docker images requried