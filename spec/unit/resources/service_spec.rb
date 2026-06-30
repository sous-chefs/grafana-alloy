# frozen_string_literal: true

require 'spec_helper'

describe 'grafana_alloy_service' do
  step_into :grafana_alloy_service
  platform 'ubuntu', '24.04'

  context 'with default action' do
    recipe do
      grafana_alloy_service 'alloy'
    end

    it { is_expected.to enable_service('alloy') }
    it { is_expected.to start_service('alloy') }
  end

  context 'with restart action' do
    recipe do
      grafana_alloy_service 'alloy' do
        action :restart
      end
    end

    it { is_expected.to restart_service('alloy') }
  end
end
