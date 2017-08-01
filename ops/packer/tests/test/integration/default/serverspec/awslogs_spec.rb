require 'serverspec'

describe 'awslogs' do

  describe file ('/var/awslogs/etc/aws.conf') do
      it { should exist }
      its(:content) { should match /ap-southeast-2/ }
  end

  describe service('awslogs') do
    it { should be_enabled }
  end

end
