require 'spec_helper'

describe 'test-001.example.org' do

  shared_examples_for 'both services' do
    it 'nova::spicehtml5proxy' do
      is_expected.to contain_class('nova::spicehtml5proxy')
      is_expected.to contain_nova__generic_service('spicehtml5proxy')
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'both services'
    end
  end

end
