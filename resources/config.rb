# frozen_string_literal: true

provides :grafana_alloy_config
unified_mode true

property :config_path, String, default: '/etc/alloy/config.alloy'
property :config_content, String, default: "logging {\n  level = \"info\"\n}\n"
property :env_vars, Hash, default: {}
property :environment_file, [String, NilClass]
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :mode, String, default: '0644'
property :validate_config, [true, false], default: false
property :validation_command, [String, NilClass]

default_action :create

action_class do
  def resolved_environment_file
    return new_resource.environment_file if new_resource.environment_file

    platform_family?('debian') ? '/etc/default/alloy' : '/etc/sysconfig/alloy'
  end

  def environment_content
    env_vars = { 'CONFIG_FILE' => new_resource.config_path }
               .merge(new_resource.env_vars.transform_keys(&:to_s))

    env_vars.sort.map { |key, value| "#{key}=#{value.inspect}" }.join("\n") + "\n"
  end
end

action :create do
  directory ::File.dirname(new_resource.config_path) do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end

  file new_resource.config_path do
    content new_resource.config_content
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  file resolved_environment_file do
    content environment_content
    owner 'root'
    group 'root'
    mode '0644'
  end

  execute "validate #{new_resource.config_path}" do
    command new_resource.validation_command
    action :run
    only_if { new_resource.validate_config && new_resource.validation_command }
  end
end

action :delete do
  file new_resource.config_path do
    action :delete
  end

  file resolved_environment_file do
    action :delete
  end
end
