#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
source $SCRIPT_DIR/setEnvironment.sh
rm -rf $WORK_DIR/*
cp -rf $JETTY_CONF $JETTY_HOME/etc/
cp $WEB_XML $JETTY_HOME/webapps/web.xml
cp -R $APP_CONF/* $JETTY_HOME/resources/
mkdir $JETTY_HOME/tmp/
mkdir $WORK_DIR
exec java -server -Drun.mode=production $JAVA_OPTIONS $JETTY_OPTIONS -jar $JETTY_HOME/start.jar $JETTY_KEYS &
sleep 30
y | cp $SCRIPT_DIR/monash-publishing.css $WORK_DIR/*/webapp/static/assets/styles/monash-publishing.css
echo "DONE!"