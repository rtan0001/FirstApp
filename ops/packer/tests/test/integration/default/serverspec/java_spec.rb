require 'serverspec'

set :backend, :exec

describe command('java -version') do
    its(:stderr) { should_not match /openjdk/ }
    its(:stderr) { should match /1.8.0/ }
    its(:exit_status) { should eq 0 }
end
