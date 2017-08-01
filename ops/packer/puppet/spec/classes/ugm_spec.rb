require 'spec_helper'

describe 'ugm' do
    context 'when using defaults' do

        let(:facts) do
        {
            :kernel                 => 'Linux',
            # :version                => 'unit-guide-editor-1.2.43',
            # :package_name           => 'EXAMPLE_PACKAGE',
            # :artifactory_user       => 'artifactory_user',
            # :artifactory_password   => 'artifactory_password',
        }
        end

        it { should compile.with_all_deps }                # this is the test to check if it compiles.
        it { should contain_class('ugm')}
        it { should have_class_count(1) }

        it {
            should contain_package('unzip').with(:ensure => 'installed')
        }

        it {
            should contain_file('/opt/ugm').with(
                :ensure => 'directory',
                :recurse => true,
                :source  => "file:///opt/unit-guide-editor-3.4.1-b54",
            )
        }

        it {
            should contain_file('/etc/systemd/system/ugm.service')
        }

        it {
            should contain_file('/opt/ugm/appConf/ugeprops.xml.jinja')
            should contain_file('/opt/ugm/setEnvironment.sh.jinja')
        }

        it {
            should contain_file('/opt/unit-guide-editor-3.4.1-b54').with(
                :ensure  => 'absent',
                :purge   => true,
                :recurse => true,
                :force   => true
            )
        }

        it {
            should contain_service('ugm')
        }

        it {
            should contain_archive('/tmp/unit-guide-editor.zip').with(
              :ensure       => 'present',
              :extract      => true,
              :extract_path => '/opt',
              :source       => "https://monashuni.artifactoryonline.com/monashuni/deploy-apps/ugm/3.4/unit-guide-editor-3.4.1-b54.zip",
              :cleanup      => true,
              :username     => nil,
              :password     => nil
            )
        }

        it {
            should contain_exec('fix permissions').with(
                :command => '/bin/chmod +x start.sh stop.sh',
                :cwd     => '/opt/ugm'
            )
        }
    end

    context 'with alternate details' do

        let(:facts) do
        {
            :kernel                 => 'Linux',
            :artifactory_user       => 'someuser',
            :artifactory_password   => 'apassword',
            :package_name           => 'unit-guide-editor-5.7.7',
        }
        end

        it { should compile.with_all_deps }                # this is the test to check if it compiles.
        it { should contain_class('ugm')}
        it { should have_class_count(1) }

        it {
            should contain_file('/opt/ugm').with(
                :ensure => 'directory',
                :recurse => true,
                :source  => "file:///opt/unit-guide-editor-5.7.7",
            )
        }

        it {
            should contain_file('/opt/unit-guide-editor-5.7.7').with(
                :ensure  => 'absent',
                :purge   => true,
                :recurse => true,
                :force   => true
            )
        }

        it {
            should contain_archive('/tmp/unit-guide-editor.zip').with(
              :ensure       => 'present',
              :extract      => true,
              :extract_path => '/opt',
              :source       => "https://monashuni.artifactoryonline.com/monashuni/deploy-apps/ugm/3.4/unit-guide-editor-5.7.7.zip",
              :cleanup      => true,
              :username     => 'someuser',
              :password     => 'apassword'
            )
        }
    end
end
