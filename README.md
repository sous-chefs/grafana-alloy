# Grafana Alloy Cookbook

Provides custom resources for installing and managing Grafana Alloy.

## Supported Platforms

* AlmaLinux 9
* Debian 12
* Ubuntu 24.04

## Resources

* `grafana_alloy_repository`
* `grafana_alloy_install`
* `grafana_alloy_config`
* `grafana_alloy_service`

## Basic Usage

```ruby
grafana_alloy_install 'default'

grafana_alloy_config 'default' do
  config_content <<~ALLOY
    logging {
      level = "info"
    }
  ALLOY
  notifies :restart, 'grafana_alloy_service[default]', :delayed
end

grafana_alloy_service 'default' do
  action [:enable, :start]
end
```

## Testing

```bash
cookstyle
chef exec rspec --format documentation
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test default-ubuntu-2404 --destroy=always
```

Additional public API details live in `documentation/*.md`.
