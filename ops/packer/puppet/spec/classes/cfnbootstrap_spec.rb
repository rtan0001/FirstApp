require 'spec_helper'

describe 'cfnbootstrap' do
    context 'when using defaults' do
        it { should compile.with_all_deps }                # this is the test to check if it compiles.
        it { should contain_class('cfnbootstrap')}
        it { should have_class_count(1) }

        it {
            should contain_archive('/tmp/aws-cfn-bootstrap-latest.tar.gz').with(
              :ensure       => 'present',
              :extract      => true,
              :extract_path => '/tmp',
              :source       => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
              :cleanup      => true
            )
        }

        it {
            should contain_exec('build cfn-bootstrap').with(
                :command => 'python setup.py build',
                :cwd     => '/tmp/aws-cfn-bootstrap-1.4',
                :path    => '/bin'
            )
        }

        it {
            should contain_exec('install cfn-bootstrap').with(
                :command => 'python setup.py install',
                :cwd     => '/tmp/aws-cfn-bootstrap-1.4',
                :path    => '/bin'
            )
        }
    end
end
