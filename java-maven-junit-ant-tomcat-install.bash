# how to compile and install the newest version of tomcat webserver from Github in Ubuntu 14.04 LTS 64-bit using a bash shell script
# install newest Oracle java version (=prerequisite for ant)
cd
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes ppa:webupd8team/java
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install oracle-java8-installer
java -version
# Terminal output should look like this:
# java version "1.8.0_60"
# Java(TM) SE Runtime Environment (build 1.8.0_60-b27)
# Java HotSpot(TM) 64-Bit Server VM (build 25.60-b23, mixed mode)

# install prerequisites for tomcat
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install build-essential checkinstall
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install python-software-properties javahelper  libecj-java
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  lynx-cur  default-jdk unp git
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  purge tomcat6 tomcat7 junit4 junit maven ant ant-optional

# install newest version of maven (=prerequisite for junit)
cd
sudo rm -rf maven*
sudo rm -rf ~/apps/maven
git clone https://github.com/apache/maven.git
cd maven
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install ant ant-optional
ant -Dmaven.home="$HOME/apps/maven/apache-maven-SNAPSHOT"
cd ~/maven/apache-maven/target
unp apache-maven-*-bin.tar.gz
sudo rm /usr/bin/mvn
sudo ln -s ~/maven/apache-maven/target/apache-maven-*/bin/mvn  /usr/bin/mvn
mvn -v
# example of Terminal output:
#Apache Maven 3.3.2-SNAPSHOT
#Maven home: $HOME/maven/apache-maven/target/apache-maven-3.3.2-SNAPSHOT
#Java version: 1.7.0_76, vendor: Oracle Corporation
#Java home: /usr/lib/jvm/java-7-oracle/jre
#Default locale: en_US, platform encoding: UTF-8
#OS name: "linux", version: "4.0.0-040000rc3-lowlatency", arch: "amd64", family: "unix"

# install newest junit version (=prerequisite for ant and tomcat)
cd
sudo rm -rf junit
git clone https://github.com/junit-team/junit.git
cd junit
sudo mvn install

# remove old versions of tomcat and ant
cd
sudo rm -rf tomcat*
sudo rm -rf /opt/apache-tomcat*
sudo rm -rf /opt/apache-ant*
sudo rm -rf ant
sudo rm -rf apache-ant*
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  purge ant ant-optional

#set JAVA_HOME
cd
export JAVA_HOME=/usr/lib/jvm/java-8-oracle 
source ~/.bashrc

# install ant (ant version >= 1.9.5 is prerequisite for compiling tomcat)
cd
git clone https://github.com/apache/ant.git
cd ant
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
./build.sh
sudo mv /usr/bin/ant /usr/bin/antBACKUP
sudo ln -s ~/ant/dist/bin/ant  /usr/bin/ant
ant -version
# output should look like this:
# Apache Ant(TM) version 1.9.7alpha compiled on October 16 2015

# install tomcat
cd
git clone https://github.com/apache/tomcat.git
cd tomcat
# sudo chown -R `whoami`:`whoami` ~/.wine
sudo ant release
mkdir ~/tomcat/bin
sudo cp -R ~/tomcat/output/dist/bin/* ~/tomcat/bin
mkdir ~/tomcat/lib
sudo cp -R ~/tomcat/output/dist/lib/* ~/tomcat/lib
mkdir ~/tomcat/logs/
touch ~/tomcat/logs/catalina.out
mkdir ~/tomcat/temp/
sudo chown -R  `whoami`:`whoami` ~/tomcat

# test tomcat configuration (part 1)
# !!! WARNING: The following command sudo ant test can take a long time to complete. This is normal !!!!
# the following test took 50 minutes 20 seconds to complete on my computer:
sudo ant test
# check for errors from previous test using this command:
grep ERR ~/tomcat/output/build/logs/*

# test tomcat configuration (part 2)
bash ~/tomcat/bin/version.sh
# output of previous version command should look like this:
# Using CATALINA_BASE:   ~/tomcat
# Using CATALINA_HOME:   ~/tomcat
# Using CATALINA_TMPDIR: ~/tomcat/temp
# Using JRE_HOME:        /usr/lib/jvm/java-8-oracle
# Using CLASSPATH:       ~/tomcat/bin/bootstrap.jar:~/tomcat/bin/tomcat-juli.jar
# Server version: Apache Tomcat/9.0.0-dev
# Server built:   Oct 16 2015 12:37:41 UTC
# Server number:  9.0.0.0
# OS Name:        Linux
# OS Version:     4.3.0-040300rc5-lowlatency
# Architecture:   amd64
# JVM Version:    1.8.0_60-b27
# JVM Vendor:     Oracle Corporation
bash ~/tomcat/bin/configtest.sh

# start tomcat server
bash ~/tomcat/bin/catalina.sh start

# test tomcat server using console based webbrowser:
lynx http://localhost:8080
# press q key twice to exit lynx browser session
