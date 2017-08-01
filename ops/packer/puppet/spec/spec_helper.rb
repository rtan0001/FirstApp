require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation

    config.mock_with :rspec
    config.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
end

at_exit { RSpec::Puppet::Coverage.report! }
