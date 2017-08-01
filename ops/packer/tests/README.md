# Testing of the assembled AMI

This folder contains the [Test Kitchen](http://kitchen.ci/) and [ServerSpec](http://serverspec.org/) tests that are used to validate the generated application server image meets requirements.

These tests can be run on a pre-built image, with [Test Kitchen](http://kitchen.ci/) taking responsibility for installing and executing the dependancies of the test tools, as well as uploading and executing the test specifications.

## Running the tests in CI

The Jenkins CI process executes the [Test Kitchen](http://kitchen.ci/) phase via the `ops/ci/verify_image.sh` script.

This script expects the following environment variables to be set:

* **KITCHEN_SSH_KEY_PEM** - points at the location of the private key to login to the AWS EC2 server.  The current keypair configured is named `eda-jenkins` and is injected as a secure credential from Jenkins.
* **ARTIFACT_BUILD_NUMBER** - contains the application version number of the image to launch.  eg `UGM-3.5.332`.  The script will perform the AWS AMI lookup and launch the appropriate image before running the test.

**Note:** At the moment the `verify image` step is providing informational feedback on the build ONLY, it will not block the pipeline from proceeding.

## Running the tests locally

You are able to run the tests locally to either:

* Validate a new server image that you are working on.
* Validate new [ServerSpec](http://serverspec.org/) tests perform as expected.

To run [Test Kitchen](http://kitchen.ci/) you need to know the following:

* An existing AMI id that you would like to verify
* Access to an AWS account, probably CORP_DEV.
* An existing AWS EC2 SSH keypair ID and corresponding private key

From this repository run:

```
bundle install

export KITCHEN_SSH_KEY_NAME=<YourAWSSSHKeyPairID>
export SERVER_IMAGE_ID=<YourAWSAMIToVerify>
export KITCHEN_SSH_KEY_PEM=</path/to/sshkeyfile.pem>
```

This should install `kitchen`, `serverspec`, and setup the required environment variables for `kitchen` to use.

You can then run the tests by executing the following
*You will need to be logged into a valid AWS account for the test to succeed.*

```
kitchen test all
```

This will launch an EC2 instance, run the tests and delete the EC2 instance.  If you expect to be running multiple passes of testing against the same image, then to save time you can keep the EC2 instance alive by running.

```
kitchen create all
kitchen converge all

kitchen verify all
```

You can continue to run `kitchen verify all` as you change the spec tests, once you are happy and complete, you will need to remember to delete the EC2 instance by running.

```
kitchen destroy all
```
## What about local development

There is an alternate way to run kitchen locally using a vagrant instance. There is an example file within the repo called `kitchen.local-example.yml`. 
Looking in that file, you will see that there is a vagrant provisioner. If you have vagrant installed, you can use this to validate puppet on a fresh box.

Just move the `kitchen.local-example.yml` to `.kitchen.yml` You will also need to include `kitchen-vagrant` within your Gemfile to get going.


## Future activities

* Align the [Test Kitchen](http://kitchen.ci/) configuration to integrate with the puppet module development cycle
    * Currently [Test Kitchen](http://kitchen.ci/) is configured to run on an already created image
    * Configuring [Test Kitchen](http://kitchen.ci/) to (optionally) use Puppet as its provisioner will allow a more seemless puppet development cycle
