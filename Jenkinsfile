#!groovyâ€‹

def git_url = "ssh://git@bitbucket.apps.monash.edu:7999/uge/deploy.git"
def git_web_url = 'https://bitbucket.apps.monash.edu:8443/projects/UGE/repos/deploy'
def git_credentials = 'smac@bitbucket'

def base_branch = 'master'
def base_jobpath = 'ugm-pipeline-new'
def slack_notify_room = "#ugm-notifications"


stage ('Prepare Version') {

    node ('master') {
        checkout scm

        sh """#!/bin/bash
PATH=\$PATH:/usr/local/bin
ops/ci/prepare_version.sh
"""

        stash includes: '**/*', name: 'workspace'
    }
}

stage ('Build server image') {

    node('base-agent') {
        unstash 'workspace'

        withCredentials([usernamePassword(credentialsId: '297cfd10-0d89-416e-b506-e9bdf9e632c7', passwordVariable: 'ARTIFACTORY_PASSWORD', usernameVariable: 'ARTIFACTORY_USER')]) {
            sh """#!/bin/bash
            echo \$ARTIFACTORY_PASSWORD
            echo \$ARTIFACTORY_USER
ops/ci/build_artifact.sh
"""
        }

    }
}

if (env.BRANCH_NAME == "master") {
    stage('Deploy to DEV') {
        node ('base-agent') {
            unstash 'workspace'

            sh """#!/bin/bash
ops/ci/deploy_to_dev.sh
"""
        }
    }

    stage('Regression test') {
        // parallel(silkTests: {
            node ('base-agent') {
                unstash 'workspace'

                try {
                    sh """#!/bin/bash
ops/ci/regression_test_dev.sh
"""
                } catch (error) {
                   throw error
                } finally {
                    step([$class: 'JUnitResultArchiver', testResults: 'regression-tests/reports/*.xml'])
                }
            }

        // })
    }

    stage ('Approve QAT deploy') {
        timeout() {
            input message: 'Do you want to DEV to QAT?'
        }
    }

    stage('Deploy to QAT') {
        node ('base-agent') {
            unstash 'workspace'

            sh """#!/bin/bash
ops/ci/deploy_to_qat.sh
"""
        }
    }

    stage('Regression test') {
        // parallel(silkTests: {
            node ('base-agent') {
                unstash 'workspace'

                try {
                    sh """#!/bin/bash
    ops/ci/regression_test_qat.sh
    """
                } catch (error) {
                   throw error
                } finally {
                    step([$class: 'JUnitResultArchiver', testResults: 'regression-tests/reports/*.xml'])
                }

            }

        // })
    }

    stage ('Approve Production deploy') {
        timeout() {
            input message: 'Do you want to QAT to Production?'
        }
    }

    stage ('Production deploy') {
        node (){
            echo 'Production server looks to be alive'
            echo "Actually wire in the production deploy in the future"
            echo "Deployed to production"
        }
    }
}
