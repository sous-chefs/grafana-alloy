# grafana_alloy_config

Manages Grafana Alloy configuration and environment files.

## Actions

- `:create`: Creates config and environment files (default)
- `:delete`: Removes config and environment files

## Properties

- `config_path` (`String`, default: `/etc/alloy/config.alloy`): Alloy config path
- `config_content` (`String`, default: logging config): Config file content
- `env_vars` (`Hash`, default: `{}`): Environment key/value pairs; merged with `CONFIG_FILE` unless overridden
- `environment_file` (`String`, default: `nil`): Override environment file path
- `owner` (`String`, default: `root`): Config file owner
- `group` (`String`, default: `root`): Config file group
- `mode` (`String`, default: `0644`): Config file mode
- `validate_config` (`Boolean`, default: `false`): Run a validation command
- `validation_command` (`String`, default: `nil`): Validation command to run

## Examples

```ruby
grafana_alloy_config 'default' do
  config_content <<~ALLOY
    logging {
      level = "info"
    }
  ALLOY
  env_vars 'CUSTOM_ARGS' => '--server.http.listen-addr=127.0.0.1:12345'
end
```
