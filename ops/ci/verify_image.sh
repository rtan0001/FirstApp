set -e

if [ -z $ARTIFACT_BUILD_NUMBER ]; then
    echo "ERROR: Cannot verify the artifact without the ARTIFACT_BUILD_NUMBER set"
    exit 1
fi

if [ -z $KITCHEN_SSH_KEY_PEM ]; then
    echo "ERROR: Cannot verify the artifact without the KITCHEN_SSH_KEY_PEM set"
    exit 1
fi

if [ ! -e $KITCHEN_SSH_KEY_PEM ]; then
    echo "ERROR: Cannot verify the artifact without KITCHEN_SSH_KEY_PEM pointing to a valid file"
    exit 1
fi

export AWS_DEFAULT_REGION=ap-southeast-2
export KITCHEN_SSH_KEY_NAME=codeninjas-jenkins

export SERVER_IMAGE_ID=`mondo ami --artifact_id ${ARTIFACT_BUILD_NUMBER}`

echo "KITCHEN_SSH_KEY_NAME  = ${KITCHEN_SSH_KEY_NAME}"
echo "KITCHEN_SSH_KEY_PEM   = ${KITCHEN_SSH_KEY_PEM}"
echo "ARTIFACT_BUILD_NUMBER = ${ARTIFACT_BUILD_NUMBER}"
echo "SERVER_IMAGE_ID       = ${SERVER_IMAGE_ID}"

cd ops/packer/tests

bundle install --deployment
bundle exec kitchen test
