# frozen_string_literal: true

provides :grafana_alloy_install
unified_mode true

property :package_name, String, default: 'alloy'
property :version, [String, NilClass]
property :manage_repository, [true, false], default: true

default_action :install

action :install do
  grafana_alloy_repository 'grafana' if new_resource.manage_repository

  package new_resource.package_name do
    version new_resource.version unless new_resource.version.nil?
    action :install
  end
end

action :remove do
  package new_resource.package_name do
    action :remove
  end
end
