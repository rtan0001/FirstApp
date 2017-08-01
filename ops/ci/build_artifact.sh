if [ -z $ARTIFACT_BUILD_NUMBER ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACT_BUILD_NUMBER set"
    exit 1
fi

if [ -z $ARTIFACTORY_USER ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACTORY_USER set"
    exit 1
fi

if [ -z $ARTIFACTORY_PASSWORD ]; then
    echo "ERROR: Cannot build artifact without the ARTIFACTORY_PASSWORD set"
    exit 1
fi

if [ -z $PACKAGE_NAME ]; then
    echo "Cannot build artifact without the PACKAGE_NAME set"
    exit 1
fi

echo "ARTIFACT_BUILD_NUMBER   = ${ARTIFACT_BUILD_NUMBER}"
echo "ARTIFACTORY_USER        = ${ARTIFACTORY_USER}"
echo "PACKAGE_NAME            = ${PACKAGE_NAME}"
# echo "ARTIFACTORY_PASSWORD    = ${ARTIFACTORY_PASSWORD}"

cd ops/packer/puppet
r10k puppetfile install

cd ..
/usr/local/bin/packer build ugm.json
