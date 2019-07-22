#!/bin/bash

[ -d /mnt/d ] && jdk_gz=`find /mnt/d/share -name "jdk-*-linux-x64.tar.gz" | sed  -e '$!d'`
[ -d /d ] && jdk_gz=`find /d/share -name "jdk-*-linux-x64.tar.gz" | sed  -e '$!d'`

jdk_version=`basename ${jdk_gz}` && jdk_version=${jdk_version/-8u/1.8.0_} && jdk_version=${jdk_version%%-*} 
echo version: $jdk_version

# Install jdk

#JAVA
if [ ! -d /usr/lib/jvm ]; then
    mkdir /usr/lib/jvm
fi

tar -zxf ${jdk_gz} -C /usr/lib/jvm/

JAVA_HOME="/usr/lib/jvm/${jdk_version}"


alternatives --install /usr/bin/java java ${JAVA_HOME}/bin/java 1
alternatives --set java ${JAVA_HOME}/bin/java

sed -i '/^#java$/,/^#javaEnd$/ d' /etc/profile
export JAVA_HOME=${JAVA_HOME}
echo '#java' >> /etc/profile
echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JRE_HOME}/lib/rt.jar:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:${JAVA_HOME}/jre/bin:$PATH' >> /etc/profile
echo '#javaEnd' >> /etc/profile

source /etc/profile
echo "JAVA_HOME=$JAVA_HOME"
echo "PATH=$PATH"
echo -n "java version:"
java -version
mkdir -p /usr/java
ln -s ${JAVA_HOME} /usr/java/default
ln -s ${JAVA_HOME} /usr/java/jdk1.8
ln -s ${JAVA_HOME} /usr/lib/jvm/j2sdk1.8-oracle

