# grafana_alloy_install

Installs or removes the Grafana Alloy package.

## Actions

- `:install`: Installs Alloy (default)
- `:remove`: Removes Alloy

## Properties

- `package_name` (`String`, default: `alloy`): Package name
- `version` (`String`, default: `nil`): Optional package version
- `manage_repository` (`Boolean`, default: `true`): Manage the Grafana package repository before installing

## Examples

```ruby
grafana_alloy_install 'default'
```
