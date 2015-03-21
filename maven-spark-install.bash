#!/bin/bash
# Purpose: this script will automatically compile and install
# the newest version of maven and Apache Spark via the github sources
# Minimum RAM requirements for this script: 2 Gigabytes of RAM 
# Please make sure to close any web browser windows and any other 
# memory hogging applications before running this memory intensive bash script.
# First uninstall any conflicting binary packages of maven and maven2:
cd
sudo apt-get update
# Install tools required to build maven and Apache Spark:
sudo apt-get install maven maven2 git build-essential ant unp python2.7
sudo apt-get purge maven maven2
# Also remove any previously installed versions of Apache Spark:
sudo rm -rf spark*
sudo rm -rf /usr/local/spark*
# install newest version of maven
rm -rf maven*
git clone https://github.com/apache/maven.git
cd maven
ant -Dmaven.home="$HOME/apps/maven/apache-maven-SNAPSHOT"
cd ~/maven/apache-maven/target
unp apache-maven-*-bin.tar.gz
sudo ln -s ~/maven/apache-maven/target/apache-maven-*/bin/mvn  /usr/bin/mvn
mvn -v
# example of Terminal output:
#Apache Maven 3.3.2-SNAPSHOT
#Maven home: $HOME/maven/apache-maven/target/apache-maven-3.3.2-SNAPSHOT
#Java version: 1.7.0_76, vendor: Oracle Corporation
#Java home: /usr/lib/jvm/java-7-oracle/jre
#Default locale: en_US, platform encoding: UTF-8
#OS name: "linux", version: "4.0.0-040000rc3-lowlatency", arch: "amd64", family: "unix"

# install newest version of Apache Spark:
cd
git clone git://github.com/apache/spark.git
cd spark
# increase MaxPermSize to avoid out-of-memory errors during compile process:
# source: https://spark.apache.org/docs/1.1.0/building-with-maven.html
export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
mvn -DskipTests clean package
# End result of mvn compilation process should look something like this (without any memory errors):
# [INFO] ------------------------------------------------------------------------
# [INFO] Reactor Summary:
# [INFO] 
# [INFO] Spark Project Parent POM ........................... SUCCESS [  9.048 s]
# [INFO] Spark Launcher Project ............................. SUCCESS [ 19.509 s]
# [INFO] Spark Project Networking ........................... SUCCESS [ 14.113 s]
# [INFO] Spark Project Shuffle Streaming Service ............ SUCCESS [  7.626 s]
# [INFO] Spark Project Core ................................. SUCCESS [05:46 min]
# [INFO] Spark Project Bagel ................................ SUCCESS [ 33.517 s]
# [INFO] Spark Project GraphX ............................... SUCCESS [01:45 min]
# [INFO] Spark Project Streaming ............................ SUCCESS [02:35 min]
# [INFO] Spark Project Catalyst ............................. SUCCESS [02:38 min]
# [INFO] Spark Project SQL .................................. SUCCESS [03:40 min]
# [INFO] Spark Project ML Library ........................... SUCCESS [03:46 min]
# [INFO] Spark Project Tools ................................ SUCCESS [ 19.095 s]
# [INFO] Spark Project Hive ................................. SUCCESS [03:00 min]
# [INFO] Spark Project REPL ................................. SUCCESS [01:07 min]
# [INFO] Spark Project Assembly ............................. SUCCESS [02:12 min]
# [INFO] Spark Project External Twitter ..................... SUCCESS [ 26.990 s]
# [INFO] Spark Project External Flume Sink .................. SUCCESS [ 41.008 s]
# [INFO] Spark Project External Flume ....................... SUCCESS [ 42.961 s]
# [INFO] Spark Project External MQTT ........................ SUCCESS [ 41.138 s]
# [INFO] Spark Project External ZeroMQ ...................... SUCCESS [ 27.237 s]
# [INFO] Spark Project External Kafka ....................... SUCCESS [01:04 min]
# [INFO] Spark Project Examples ............................. SUCCESS [03:53 min]
# [INFO] Spark Project External Kafka Assembly .............. SUCCESS [ 41.333 s]
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time: 36:57 min
# [INFO] Finished at: 2015-03-21T02:19:07+01:00
# [INFO] Final Memory: 83M/1292M
# [INFO] ------------------------------------------------------------------------
# Then you can run pyspark using this command:
~/spark/bin/pyspark -v
# Press CTRL-D to end the pyspark session

