#!/bin/bash

set +e

for i in "$@"
do
case $i in
    -b=*|--build=*)
    BUILD_TO_DEPLOY="${i#*=}"
    shift # past argument=value
    ;;
    -e=*|--environment=*)
    ENVIRONMENT="${i#*=}"
    shift # past argument=value
    ;;
    -r=*|--role=*)
    DEPLOY_ARN="${i#*=}"
    shift # past argument=value
    ;;
    *)
            # unknown option
    ;;
esac
done
echo "BUILD NUMBER = ${BUILD_TO_DEPLOY}"
echo "DEPLOY ARN   = ${DEPLOY_ARN}"
echo "ENVIRONMENT  = ${ENVIRONMENT}"

if [ ! -f "../config/${ENVIRONMENT}.json" ]; then
    echo "Unable to locate environment configuration file - '../config/${ENVIRONMENT}.json'"
    exit -1
else
    echo "Validated existance of environment configuration '../config/${ENVIRONMENT}.json'"
fi

DEPLOY_AMI=`mondo ami --artifact_id ${BUILD_TO_DEPLOY}`

if [ $? -ne 0 ]; then
    echo $DEPLOY_AMI
    exit -1
fi

echo "DEPLOY_AMI   = ${DEPLOY_AMI}"

# Lookup the AMI from the DEV account to ensure it is available
mondo --role ${DEPLOY_ARN} ami -d --ami_id ${DEPLOY_AMI}

# Initiate the CloudFormation deployment
mondo --role ${DEPLOY_ARN} deploy --stack_name ugm --template application.yaml --scope application --ami_id ${DEPLOY_AMI} --version ${BUILD_TO_DEPLOY} --config_filename ../config/${ENVIRONMENT}.json
