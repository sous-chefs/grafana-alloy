# frozen_string_literal: true

require 'spec_helper'

describe 'grafana_alloy_install' do
  step_into :grafana_alloy_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      grafana_alloy_install 'default'
    end

    it { is_expected.to install_package('alloy') }
    it { is_expected.to create_grafana_alloy_repository('grafana') }
  end

  context 'without repository management' do
    recipe do
      grafana_alloy_install 'default' do
        manage_repository false
      end
    end

    it { is_expected.to install_package('alloy') }
    it { is_expected.not_to create_grafana_alloy_repository('grafana') }
  end
end
