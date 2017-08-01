# UGM Deploy scripts

This repository contains the scripts and configuration for the [Unit Guide Manager](https://confluence.apps.monash.edu/display/UGM/Unit+Guide+Manager) application.

## Repository structure

The repository has a number of key folders that contain the scripts and configuration required to develop and manage all of the UGM environments.

* `ops/ci` - Contains the `bash` scripts which are called from the [Jenkins Server](https://eda-jenkins.corp-dev.aws.monash.edu/job/ugm-pipeline/view/master-pipeline/) to perform each of the stages.
* `ops/cloudformation` - Contains the `CloudFormation` and `python` scripts that describe the infrastructure and perform the creation/update of the deployed environments. See [README](ops/cloudformation/README.md)
* `ops/config` - Contains the `json` configurations for each of the deployed environments.  **Review required** could be unified with the `ops/secrets` folder. See [README](ops/config/README.md)
* `ops/packer` - Contains the `packer` and `puppet` code that is used to install the UGM application and create the AMI ready for deployment. See [README](ops/packer/README.md)
* `ops/secrets` - Contains the `sops` encrypted environment configuration.  Holds things like username/password in a `KMS` encrypted form. See [README](ops/secrets/README.md)
* `ops/versions` - Contains the version label of the application to be deployed.
* `regression-test` - Contains `python` and `behave` based BDD tests that validate an environment deploy is successful. See [README](ops/regression-test/README.md)

## CI/CD approach

The Unit Guide Manager application is one of the first applications to undergo a transformation towards a fully automated CI/CD strategy.
This repository is one of the key components in this CI/CD approach.


* An introduction to CI/CD pipeline structure can be found here: https://confluence.apps.monash.edu/display/TLA/Delivery+Pipeline+Design
* Details on the Jenkins stages and their purpose: https://confluence.apps.monash.edu/display/TLA/Jenkins+based+Delivery+Pipeline
* The Pipeline as Code repository can be found here: https://bitbucket.apps.monash.edu:8443/projects/APPDEV/repos/ugm-deploy-pipeline/browse
* The Jenkins server currently running the deployment pipeline is here: https://eda-jenkins.corp-dev.aws.monash.edu/job/ugm-pipeline/view/master-pipeline/

## Current environments

* Development - https://ugm.corp-dev.aws.monash.edu/
* QAT - TBC
* Production - TBC

## Technology in use:

* **Jenkins** is used as the `CI/CD` server - https://jenkins.io/
* **CloudFormation** is used to describe the `Infrastructure as code` - https://aws.amazon.com/cloudformation/
* **Packer** is used to orchistrate the `server image build` - https://www.packer.io/
* **Puppet** is used to `install the application` and dependancies - https://puppet.com/
* **bash** and **Python** are used to `drive the deployment` process - https://www.python.org/

## Version management

To track the version of the application, configuration and infrastructure deployed, this repository and resultant artifacts need to be labeled with a consistent version number.  This number needs to be unique and identify a sequence in which the artifacts were created.

This is achieved through the use of the `VERSION` file.

This file contains a version number of 3 parts `major.minor.build`.

For each build of the application, the Jenkins CI/CD platform will automatically increment the `build` section of the version number preparing it for the next release.

Incrementing of the number is done through the use of the `bumpversion` python library, and configured in the `ops/ci/prepare_version.sh` pipeline stage.

**Note:** At this time, auto-incrementing of the `major` and `minor` sections of the VERSION file is a *manual* process, stories have been created to automate the post production release activity.
