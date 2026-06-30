# frozen_string_literal: true

grafana_alloy_install 'default'

grafana_alloy_config 'default' do
  config_content <<~ALLOY
    logging {
      level = "info"
    }
  ALLOY
  env_vars 'CUSTOM_ARGS' => '--server.http.listen-addr=127.0.0.1:12345'
  notifies :restart, 'grafana_alloy_service[alloy]', :delayed
end

grafana_alloy_service 'alloy' do
  action [:enable, :start]
end
