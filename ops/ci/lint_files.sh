set -e

# Install the dependancies
npm install jslint yaml-lint
export PATH=$(npm bin):$PATH

# Lint the config files
jslint ops/config/*.json
yamllint ops/secrets/*.yaml

# Lint the puppet files
puppet-lint --fail-on-warnings --with-filename ops/packer/puppet/roles

cd ops/packer/puppet
gem install bundle
bundle install
bundle exec rake spec
