require 'spec_helper'

describe 'demo' do
    context 'when using defaults' do
        it { should compile.with_all_deps }                # this is the test to check if it compiles.
        it { should contain_class('demo')}
        it { should have_class_count(1) }

        it { should contain_file('/opt/ugm/monash-publishing.css')}
        it { should contain_file('/opt/ugm/start.sh')}
    end
end
