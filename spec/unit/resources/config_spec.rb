# frozen_string_literal: true

require 'spec_helper'

describe 'grafana_alloy_config' do
  step_into :grafana_alloy_config
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      grafana_alloy_config 'default'
    end

    it { is_expected.to create_directory('/etc/alloy') }
    it { is_expected.to create_file('/etc/alloy/config.alloy').with_content(/logging/) }
    it { is_expected.to create_file('/etc/default/alloy').with_content(%r{CONFIG_FILE="/etc/alloy/config.alloy"}) }
  end

  context 'with environment values' do
    recipe do
      grafana_alloy_config 'default' do
        env_vars 'CUSTOM_ARGS' => '--server.http.listen-addr=127.0.0.1:12345'
      end
    end

    it { is_expected.to create_file('/etc/default/alloy').with_content(%r{CONFIG_FILE="/etc/alloy/config.alloy"}) }
    it { is_expected.to create_file('/etc/default/alloy').with_content(/CUSTOM_ARGS="--server.http.listen-addr=127.0.0.1:12345"/) }
  end
end
