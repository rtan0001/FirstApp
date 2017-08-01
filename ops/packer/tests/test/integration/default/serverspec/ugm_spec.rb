require 'serverspec'

describe 'UGM configuration' do

  describe file ('/opt/ugm/appConf/ugeprops.xml.jinja') do
      it { should exist }
      its(:content) { should match /{{ ugm_db.user_unencrypted }}/ }
      its(:content) { should match /{{ ugm_db.password }}/ }
      its(:content) { should match /{{ ugm_db.endpoint_unencrypted }}/ }
      its(:content) { should match /{{ ugm_db.port_unencrypted }}/ }
  end

  describe file ('/opt/ugm/setEnvironment.sh') do
      it { should exist }
      # It is not executable, should it be?
    #   it { should be_executable }
  end

  describe file ('/opt/ugm/start.sh') do
      it { should exist }
      it { should be_executable }
  end

  describe file ('/opt/ugm/stop.sh') do
      it { should exist }
      it { should be_executable }
  end
end

describe 'UGM Service' do

    describe file('/etc/systemd/system/ugm.service') do
        it { should exist }
        its(:content) { should match /Restart=on-failure/ }
        its(:content) { should match /Type=forking/ }
        its(:content) { should match /KillSignal=SIGINT/ }
    end

end

describe service('ugm') do
  it { should_not be_enabled }
  it { should_not be_running }
end
