# grafana_alloy_repository

Manages the Grafana package repository used to install Grafana Alloy.

## Actions

- `:create`: Creates the repository (default)
- `:delete`: Removes the repository

## Properties

- `apt_uri` (`String`, default: `https://apt.grafana.com`): APT repository URI
- `apt_distribution` (`String`, default: `stable`): APT distribution
- `apt_components` (`Array`, default: `['main']`): APT components
- `apt_key_url` (`String`, default: `https://apt.grafana.com/gpg-full.key`): APT key URL
- `apt_key_path` (`String`, default: `/etc/apt/keyrings/grafana.asc`): Local APT key path
- `apt_repo_path` (`String`, default: `/etc/apt/sources.list.d/grafana.list`): Local APT source list path
- `yum_baseurl` (`String`, default: `https://rpm.grafana.com`): Yum repository base URL
- `yum_gpgkey` (`String`, default: `https://rpm.grafana.com/gpg.key`): Yum GPG key URL

## Examples

```ruby
grafana_alloy_repository 'grafana'
```
