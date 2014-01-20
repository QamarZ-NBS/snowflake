#!/bin/sh
# assuming:
#  1. "/var/log/snowflake" exists with writeable permission
#  2. "/var/log" writeable access

if [ "$1" == "" ]; then
    echo "--usage: server_port i.e., ./run-server.sh 30405";
    exit;
fi

JAVA_OPTS="-Xmx700m -Xms700m -Xmn500m -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=$1 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -XX:+UseConcMarkSweepGC -verbosegc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseParNewGC -Xloggc:/var/log/snowflake/gc.log -XX:ErrorFile=/var/log/java_error%p.log -server"

CLASSPATH="/root/.m2/repository/commons-codec/commons-codec/1.4/commons-codec-1.4.jar:/root/.m2/repository/org/slf4j/slf4j-api/1.5.8/slf4j-api-1.5.8.jar:/root/.m2/repository/org/slf4j/slf4j-nop/1.5.8/slf4j-nop-1.5.8.jar:/root/.m2/repository/thrift/libthrift/0.5.0/libthrift-0.5.0.jar:/root/.m2/repository/com/twitter/ostrich/8.2.0/ostrich-8.2.0.jar:/root/.m2/repository/com/twitter/scala-json/3.0.0/scala-json-3.0.0.jar:/root/.m2/repository/com/twitter/util-core/5.3.0/util-core-5.3.0.jar:/root/.m2/repository/com/twitter/util-eval/5.3.0/util-eval-5.3.0.jar:/root/.m2/repository/org/scala-lang/scala-compiler/2.9.2/scala-compiler-2.9.2.jar:/root/.m2/repository/com/twitter/util-jvm/5.3.0/util-jvm-5.3.0.jar:/root/.m2/repository/com/twitter/scala-zookeeper-client/3.0.6/scala-zookeeper-client-3.0.6.jar:/root/.m2/repository/org/apache/zookeeper/zookeeper/3.4.3/zookeeper-3.4.3.jar:/root/.m2/repository/org/slf4j/slf4j-log4j12/1.6.1/slf4j-log4j12-1.6.1.jar:/root/.m2/repository/log4j/log4j/1.2.15/log4j-1.2.15.jar:/root/.m2/repository/javax/mail/mail/1.4/mail-1.4.jar:/root/.m2/repository/javax/activation/activation/1.1/activation-1.1.jar:/root/.m2/repository/jline/jline/0.9.94/jline-0.9.94.jar:/root/.m2/repository/org/jboss/netty/netty/3.2.2.Final/netty-3.2.2.Final.jar:/root/.m2/repository/com/twitter/util-logging/5.3.0/util-logging-5.3.0.jar:/root/.m2/repository/com/twitter/util-thrift/5.3.0/util-thrift-5.3.0.jar:/root/.m2/repository/org/codehaus/jackson/jackson-core-asl/1.8.1/jackson-core-asl-1.8.1.jar:/root/.m2/repository/org/codehaus/jackson/jackson-mapper-asl/1.8.1/jackson-mapper-asl-1.8.1.jar:/root/.m2/repository/com/twitter/util-codec/5.3.0/util-codec-5.3.0.jar:/root/.m2/repository/org/scala-tools/testing/specs_2.9.3/1.6.9/specs_2.9.3-1.6.9.jar:/root/.m2/repository/junit/junit/4.5/junit-4.5.jar:/root/.m2/repository/org/scala-lang/scala-library/2.9.2/scala-library-2.9.2.jar"

MAIN_CLASS="com.twitter.service.snowflake.SnowflakeServer"

java ${JAVA_OPTS} -cp "target/*:${CLASSPATH}" ${MAIN_CLASS} -f "config/development.scala"