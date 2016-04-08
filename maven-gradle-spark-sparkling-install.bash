#!/bin/bash
# Based on: https://spark.apache.org/docs/1.1.0/building-with-maven.html
# Purpose: this script will automatically compile and install
# the newest version of maven and Apache Spark via the github sources
# Software requirements: Ubuntu 14.04 LTS 64-bit, git, build-essential,
# ant, unp, python2.7, java 1.7.0 or higher, openjdk-7-jdk
# Also required dependencies: https://github.com/MarkRijckenberg/shell-scripts/blob/master/cuda-java-truecrack-python-pip-install.bash
# Minimum RAM requirements for this script: 2 Gigabytes of RAM (maybe even more) 
# Minimum free disk space requirements for this script: 1 Gigabyte (maybe even more) 
# Please make sure to close any web browser windows and any other 
# memory hogging applications before running this memory intensive bash script.
# First uninstall any conflicting binary packages of maven and java:
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get purge openjdk-6-jre openjdk-7-jre-headless openjdk-7-jre java-common
sudo DEBIAN_FRONTEND=noninteractive apt-get purge openjdk*
sudo DEBIAN_FRONTEND=noninteractive apt-get purge maven
sudo rm -rf /etc/java-*-openjdk/*
sudo rm -rf .m2/
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/rrutter
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/c2d4u
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:webupd8team/java
sudo DEBIAN_FRONTEND=noninteractive apt-get update
# Install tools required to build maven and Apache Spark with sparkR support:
sudo apt-get build-dep maven
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  r-base-core r-base
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  git build-essential python-protobuf protobuf-compiler
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  ant unp python2.7
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  maven
sudo apt-get --yes --force-yes  install  oracle-java9-installer 
sudo apt-get --yes --force-yes  install  oracle-java9-set-default
# Also remove any previously installed versions of Apache Spark:
sudo rm -rf spark*
sudo rm -rf /usr/local/spark*

#install newest version of gradle (sparkling water depends on gradle during compile process)
cd
sudo rm -rf gradle
git clone https://github.com/gradle/gradle
cd gradle
sudo apt-get build-dep gradle
./gradlew build

# install newest version of maven (Apache Spark depends on maven during compile process)
# sudo rm -rf maven*
# sudo rm -rf ~/apps/maven
# git clone https://github.com/apache/maven.git
# cd ~/maven/apache-maven
#obsolete in 2016: ant -Dmaven.home="$HOME/apps/maven/apache-maven-SNAPSHOT"
# mvn install
# cd ~/maven/apache-maven/target
# unp apache-maven-*-bin.tar.gz
# sudo mv /usr/bin/mvn /usr/bin/mvnBACKUP
# sudo ln -s ~/maven/apache-maven/target/apache-maven-*/bin/mvn  /usr/bin/mvn
# mvn -v
# example of Terminal output:
# Apache Maven 3.4.0-SNAPSHOT (e37117e304d17e5b2defb4b2f7b2c67c0e2a1fe2; 2016-01-27T20:16:00+01:00)
# Maven home: ~/maven/apache-maven/target/apache-maven-3.4.0-SNAPSHOT
# Java version: 1.7.0_95, vendor: Oracle Corporation
# Java home: /usr/lib/jvm/java-7-openjdk-amd64/jre
# Default locale: en_US, platform encoding: UTF-8
# OS name: "linux", version: "4.3.0-6-generic", arch: "amd64", family: "unix"

# install newest version of Apache Spark:
cd
git clone git://github.com/apache/spark.git -b branch-1.5
cd spark
# increase MaxPermSize to avoid out-of-memory errors during compile process:
# export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=512m"
mvn -PsparkR -DskipTests clean package
# End result of Apache Spark build process should look
# something like this (without any memory errors):
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
# Based on: https://github.com/databricks/spark-csv

# install SparkR-pkg
cd
rm -rf SparkR-pkg/
git clone https://github.com/amplab-extras/SparkR-pkg.git
cd SparkR-pkg/
SPARK_VERSION=1.5.0 USE_MAVEN=1 ./install-dev.sh
# ./sparkR examples/pi.R local[2]

# As an example, load cars.csv from github into Apache Spark using pyspark and databricks package
# com.databricks:spark-csv
cd ~/spark

# first clean up any previously downloaded files:
rm cars.csv
rm spark-csv
wget --no-check-certificate https://github.com/databricks/spark-csv/raw/master/src/test/resources/cars.csv
wget --no-check-certificate  https://github.com/databricks/spark-csv
groupId=`grep groupId spark-csv|cut -d":" -f2|cut -d" " -f2|tail -n 1`
artifactId=`grep artifactId spark-csv|cut -d":" -f2|cut -d" " -f2|tail -n 1`
version=`grep version spark-csv|tail -n 1|cut -d":" -f2|cut -d" " -f2`

# Use following command to run pyspark using four CPU cores on the local machine
# while also loading the spark-csv databricks package:
# source: https://spark.apache.org/docs/latest/programming-guide.html
bin/pyspark -v --master local[4]  --packages `echo $groupId`:`echo $artifactId`:`echo $version`

# manually copy-paste following commands into the pyspark Terminal session:
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
df = sqlContext.load(source = "com.databricks.spark.csv", header = "true",path = "cars.csv")
df.select("year", "model").show()
# output of last command should be similar to this:
# year model
# 2012 S    
# 1997 E350
# |2015| Volt|

# Press CTRL-D to end the pyspark session
# useful links:  
# http://ramhiser.com/2015/02/01/configuring-ipython-notebook-support-for-pyspark/
# https://spark.apache.org/docs/1.1.1/api/python/pyspark.rdd.RDD-class.html

# source:https://github.com/h2oai/sparkling-water
# http://www.h2o.ai/download/
# Sparkling Water (=Apache Spark + H2O machine learning algorithms) is also published as a Spark package. 
# REQUIRES: Apache Spark 1.3.0, 1.4.0, 1.5.0 or 1.6.0
# You can use it directly from your Spark distribution.
# For example, if you have Spark version 1.5.0 and would like to use Sparkling Water version 1.5.2 and
# launch example CraigslistJobTitlesStreamingApp, then you can use the following command:
#  ~/sparkling-water/bin/sparkling-shell --packages ai.h2o:sparkling-water-core_2.10:1.5.2,ai.h2o:sparkling-water-examples_2.10:1.5.2 --class org.apache.spark.examples.h2o.CraigslistJobTitlesStreamingApp /dev/null
#  ~/sparkling-water/bin/sparkling-shell --conf "spark.executor.memory=6g"

export SPARK_LOCAL_IP='127.0.0.1'
export MASTER="local-cluster[3,4,2048]"
export SPARK_HOME=~/spark
#PYSPARK_PYTHON="ipython" ~/sparkling-water/bin/pysparkling
#IPYTHON_OPTS="notebook" $SPARK_HOME/bin/pyspark
cd
rm -rf sparkling-water*
git clone https://github.com/h2oai/sparkling-water.git -b rel-1.5
cd sparkling-water
./make-dist.sh
./gradlew build

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
