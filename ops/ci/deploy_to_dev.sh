if [ -z $ARTIFACT_BUILD_NUMBER ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACT_BUILD_NUMBER set"
    exit 1
fi

cd ops/cloudformation

# Fail build on script failure
set -e

export AWS_DEFAULT_REGION=ap-southeast-2
export DEPLOY_ARN=arn:aws:iam::439149920780:role/ugm-deploy-role-ugmAppDeployRole-1PBHUPTXONG3W
export ENVIRONMENT=dev

./deploy_changes.sh -b=${ARTIFACT_BUILD_NUMBER} --role=${DEPLOY_ARN} -e=${ENVIRONMENT}
