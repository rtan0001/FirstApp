require 'spec_helper'
describe 'awslogs' do
  let(:title) { 'awslogs' }
  let(:node) { 'ugm' }
  let(:facts) { {} }

  context 'when using defaults' do

    it { should compile.with_all_deps }
    it { should contain_class('awslogs') }
    it { should contain_exec('install-awslogs').with_command(
      "python /tmp/awslogs-agent-setup.py -n -r ap-southeast-2 -c /tmp/awslogs.conf") }
    it { should contain_archive('/tmp/awslogs-agent-setup.py').with(:ensure => 'present') }
    it { should contain_file('/tmp/awslogs.conf') }
    it { should contain_file('/var/awslogs/etc/config/base.conf') }
    it { should contain_file('/var/awslogs/etc/config/ugm.conf') }
    it { should contain_service('awslogs') }

  end

end
