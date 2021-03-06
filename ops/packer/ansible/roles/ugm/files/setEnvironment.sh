#!/bin/bash
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export JETTY_LOGS=$SCRIPT_DIR/logs
export JETTY_HOME=$SCRIPT_DIR/jetty-distribution-9.2.16.v20160414
export JETTY_USER=unitGuideManager # this is the user that the init.d script will use
export JETTY_PORT=80 # change this to any other port you like
export JETTY_STOP_PORT=9083 # change this to any other port you like
export JETTY_STOP_KEY=sandwiches # change this to any random string
export APP_CONF=$SCRIPT_DIR/appConf
export SHIRO_CONF=$APP_CONF/shiro.ini
export JETTY_CONF=$SCRIPT_DIR/jettyConf/*
export JETTY_RUN=$SCRIPT_DIR
export JETTY_PID=$SCRIPT_DIR/jetty.pid
export WARS=$SCRIPT_DIR/apps
export WEB_XML=$SCRIPT_DIR/apps/*.xml
export WORK_DIR=$SCRIPT_DIR/work
export JETTY_OPTIONS="-Dwarroot=$WARS -DSTOP.PORT=$JETTY_STOP_PORT -DSTOP.KEY=$JETTY_STOP_KEY -Djetty.port="$JETTY_PORT" -Djetty.home=$JETTY_HOME -Djetty.base=$JETTY_HOME -Djetty.logs=$JETTY_LOGS -DJETTY_LOGS=$JETTY_LOGS"
export JETTY_KEYS="jetty.home=$JETTY_HOME jetty.base=$JETTY_HOME jetty.port=$JETTY_PORT STOP.PORT=$JETTY_STOP_PORT STOP.KEY=$JETTY_STOP_KEY jetty.dump.start=true jetty.dump.stop=true --module=logging,requestlog,resources,ssl,https,rewrite "
export JAVA_OPTIONS="$JAVA_OPTS $java_opts $java_options -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -Xms2048m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=512m -Dorg.eclipse.jetty.server.Request.maxFormContentSize=50000000 -Djava.io.tmpdir=$WORK_DIR -DlogbackConfigFile=$SCRIPT_DIR/appConf/logback.xml -DappConfigDirectory=$APP_CONF"