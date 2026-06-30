# frozen_string_literal: true

control 'grafana-alloy-package-01' do
  impact 1.0
  title 'Alloy package is installed'

  describe package('alloy') do
    it { should be_installed }
  end
end

control 'grafana-alloy-config-01' do
  impact 1.0
  title 'Alloy config is managed'

  describe file('/etc/alloy/config.alloy') do
    it { should exist }
    its('mode') { should cmp '0644' }
    its('content') { should match(/logging/) }
  end
end

control 'grafana-alloy-env-01' do
  impact 1.0
  title 'Alloy environment file is managed'

  env_file = os.family == 'redhat' ? '/etc/sysconfig/alloy' : '/etc/default/alloy'

  describe file(env_file) do
    it { should exist }
    its('content') { should match(/CUSTOM_ARGS/) }
  end
end

control 'grafana-alloy-service-01' do
  impact 1.0
  title 'Alloy service is enabled and running'

  describe systemd_service('alloy') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
