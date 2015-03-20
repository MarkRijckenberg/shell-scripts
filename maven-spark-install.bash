#!/bin/bash
# Please make sure to close any web browser windows and any other 
# memory hogging applications before running this memory intensive bash script.
# Cleanup of previous install of Apache Spark:
sudo apt-get update
sudo apt-get install maven git build-essential ant unp
sudo apt-get purge maven2 spark maven
cd
sudo rm -rf spark*
sudo rm -rf /usr/local/spark*
rm downloads.html
# install newest version of maven
cd
rm -rf maven*
git clone https://github.com/apache/maven.git
cd maven
ant -Dmaven.home="$HOME/apps/maven/apache-maven-SNAPSHOT"
cd ~/maven/apache-maven/target
unp apache-maven-*-bin.tar.gz
sudo ln -s ~/maven/apache-maven/target/apache-maven-*/bin/mvn  /usr/bin/mvn
mvn -v
# example output:
#Apache Maven 3.3.2-SNAPSHOT
#Maven home: $HOME/maven/apache-maven/target/apache-maven-3.3.2-SNAPSHOT
#Java version: 1.7.0_76, vendor: Oracle Corporation
#Java home: /usr/lib/jvm/java-7-oracle/jre
#Default locale: en_US, platform encoding: UTF-8
#OS name: "linux", version: "4.0.0-040000rc3-lowlatency", arch: "amd64", family: "unix"

# install newest version of spark
cd
git clone git://github.com/apache/spark.git
cd spark
# increase MaxPermSize to 1024m to avoid out-of-memory errors during compile process:
MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"
mvn -DskipTests clean package
sudo addgroup spark
sudo useradd -g spark spark
sudo adduser spark sudo
sudo mkdir /home/spark
sudo chown spark:spark /home/spark
sudo chown -R spark:spark /usr/local/spark/
sudo mkdir -p /srv/spark/{logs,work,tmp,pids}
cd /srv/spark/
sudo chown -R spark:spark /srv/spark
sudo chmod 4755 /srv/spark/tmp
cd /usr/local/spark/conf/
sudo cp -p spark-env.sh.template spark-env.sh
