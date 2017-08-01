export GIT_COMMIT=`git rev-parse HEAD`
export BRANCH_NAME=`git branch | grep \* | cut -d ' ' -f2`

set -e

if [ "${BRANCH_NAME}" == "master" ]; then
    export VERSION=`cat VERSION`
    export ARTIFACT_BUILD_NUMBER=UGM-${VERSION}

    bumpversion --current-version $VERSION patch VERSION --allow-dirty
    export NEW_VERSION=`cat VERSION`

    git add VERSION
    git commit -m "Preparing build for next version ${NEW_VERSION}"
else
    export ARTIFACT_BUILD_NUMBER=UGM-${BRANCH_NAME}-${GIT_COMMIT}
fi

printenv > build.properties
