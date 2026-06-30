# frozen_string_literal: true

require 'spec_helper'

describe 'grafana_alloy_repository' do
  step_into :grafana_alloy_repository

  context 'on ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      grafana_alloy_repository 'grafana'
    end

    it { is_expected.to create_remote_file('/etc/apt/keyrings/grafana.asc') }
    it { is_expected.to create_file('/etc/apt/sources.list.d/grafana.list') }
  end

  context 'on almalinux' do
    platform 'almalinux', '9'

    recipe do
      grafana_alloy_repository 'grafana'
    end

    it { is_expected.to create_yum_repository('grafana') }
  end
end
