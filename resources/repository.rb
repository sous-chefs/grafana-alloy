# frozen_string_literal: true

provides :grafana_alloy_repository
unified_mode true

property :apt_uri, String, default: 'https://apt.grafana.com'
property :apt_distribution, String, default: 'stable'
property :apt_components, Array, default: ['main']
property :apt_key_url, String, default: 'https://apt.grafana.com/gpg-full.key'
property :apt_key_path, String, default: '/etc/apt/keyrings/grafana.asc'
property :apt_repo_path, String, default: '/etc/apt/sources.list.d/grafana.list'
property :yum_baseurl, String, default: 'https://rpm.grafana.com'
property :yum_gpgkey, String, default: 'https://rpm.grafana.com/gpg.key'

default_action :create

action :create do
  if platform_family?('debian')
    directory ::File.dirname(new_resource.apt_key_path) do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    remote_file new_resource.apt_key_path do
      source new_resource.apt_key_url
      owner 'root'
      group 'root'
      mode '0644'
      notifies :update, 'apt_update[grafana-alloy-package-cache]', :immediately
    end

    file new_resource.apt_repo_path do
      content "deb [signed-by=#{new_resource.apt_key_path}] #{new_resource.apt_uri} #{new_resource.apt_distribution} #{new_resource.apt_components.join(' ')}\n"
      owner 'root'
      group 'root'
      mode '0644'
      notifies :update, 'apt_update[grafana-alloy-package-cache]', :immediately
    end

    apt_update 'grafana-alloy-package-cache' do
      action :nothing
    end
  elsif platform_family?('rhel', 'fedora', 'amazon')
    yum_repository 'grafana' do
      description 'Grafana'
      baseurl new_resource.yum_baseurl
      gpgcheck true
      repo_gpgcheck true
      gpgkey new_resource.yum_gpgkey
      sslverify true
      enabled true
      action :create
    end
  else
    raise "Unsupported platform family #{node['platform_family']} for grafana_alloy_repository"
  end
end

action :delete do
  if platform_family?('debian')
    file new_resource.apt_repo_path do
      action :delete
    end

    file new_resource.apt_key_path do
      action :delete
    end
  elsif platform_family?('rhel', 'fedora', 'amazon')
    yum_repository 'grafana' do
      action :remove
    end
  end
end
