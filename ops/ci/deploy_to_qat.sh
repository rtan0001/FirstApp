if [ -z $ARTIFACT_BUILD_NUMBER ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACT_BUILD_NUMBER set"
    exit 1
fi

cd ops/cloudformation

# Fail build on script failure
set -e

export AWS_DEFAULT_REGION=ap-southeast-2
export DEPLOY_ARN=arn:aws:iam::829292609546:role/ugm-deploy-role-ugmAppDeployRole-1M4H7Y0BCJJMN
export ENVIRONMENT=qat

./deploy_changes.sh -b=${ARTIFACT_BUILD_NUMBER} --role=${DEPLOY_ARN} -e=${ENVIRONMENT}
