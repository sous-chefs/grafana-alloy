# frozen_string_literal: true

provides :grafana_alloy_service
unified_mode true

property :service_name, String, name_property: true
property :supports, Hash, default: { status: true, restart: true, reload: true }

default_action [:enable, :start]

action :enable do
  service new_resource.service_name do
    supports new_resource.supports
    action :enable
  end
end

action :disable do
  service new_resource.service_name do
    supports new_resource.supports
    action :disable
  end
end

action :start do
  service new_resource.service_name do
    supports new_resource.supports
    action :start
  end
end

action :stop do
  service new_resource.service_name do
    supports new_resource.supports
    action :stop
  end
end

action :restart do
  service new_resource.service_name do
    supports new_resource.supports
    action :restart
  end
end

action :reload do
  service new_resource.service_name do
    supports new_resource.supports
    action :reload
  end
end
