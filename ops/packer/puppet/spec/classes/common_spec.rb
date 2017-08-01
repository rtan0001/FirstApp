require 'spec_helper'

describe 'common' do
    context 'when using defaults' do
        it { should compile.with_all_deps }                # this is the test to check if it compiles.
        it { should contain_class('common')}
        it { should have_class_count(1) }

        it { should contain_package('python-pip').with(:ensure => 'installed') }
        it { should contain_package('openssl-devel').with(:ensure => 'installed') }
        it { should contain_package('python-devel').with(:ensure => 'installed') }
        it { should contain_package('gcc').with(:ensure => 'installed') }

        it {
            should contain_package('epel-release-7-9').with(
                :ensure => 'installed',
                :provider => 'rpm'
            )
        }

        it {
            should contain_file('/usr/bin/pip-python').with(
                :ensure  => 'link',
                :target  => '/usr/bin/pip'
            )
        }

        it {
            should contain_package('awscli').with(
                :ensure => 'installed',
                :provider=> 'pip'
            )
        }

        it {
            should contain_package('sops').with(
                :ensure => 'installed',
                :provider=> 'pip'
            )
        }

        it {
            should contain_package('jinja2-cli').with(
                :ensure => 'installed',
                :provider=> 'pip'
            )
        }

        it {
            should contain_package('pyyaml').with(
                :ensure => 'installed',
                :provider=> 'pip'
            )
        }
    end
end
