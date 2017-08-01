if [ -z $ARTIFACT_BUILD_NUMBER ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACT_BUILD_NUMBER set"
    exit 1
fi

cd ops/cloudformation

# Fail build on script failure
set -e

export AWS_DEFAULT_REGION=ap-southeast-2
export DEPLOY_ARN=arn:aws:iam::750438120855:role/ugm-deploy-role-ugmAppDeployRole-U9DW581NH0EX
export ENVIRONMENT=prd

./deploy_changes.sh -b=${ARTIFACT_BUILD_NUMBER} --role=${DEPLOY_ARN} -e=${ENVIRONMENT}
