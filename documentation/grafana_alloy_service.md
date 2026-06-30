# grafana_alloy_service

Manages the package-owned Grafana Alloy service.

## Actions

- `:enable`: Enables the service
- `:disable`: Disables the service
- `:start`: Starts the service
- `:stop`: Stops the service
- `:restart`: Restarts the service
- `:reload`: Reloads the service

## Properties

- `service_name` (`String`, name property): Service name
- `supports` (`Hash`, default: status/restart/reload support): Service support map

## Examples

```ruby
grafana_alloy_service 'alloy' do
  action [:enable, :start]
end
```
