# AGENTS.md

## Cookbook Purpose

This cookbook manages Grafana Alloy repository setup, package installation, configuration, and service state through custom resources.

## Agent Findings

* Grafana publishes a Chef snippet in Alloy documentation, but this cookbook exposes reusable custom resources instead of a recipe-only install flow.
* The package owns the systemd unit. `grafana_alloy_service` intentionally uses Chef's `service` resource rather than replacing the upstream unit.
* Config validation is opt-in through an explicit `validation_command` because Alloy validation commands may vary by release and deployment mode.

## Package Availability

### APT (Debian/Ubuntu)

* Grafana's documented repository is `https://apt.grafana.com stable main`.
* The documented key is `https://apt.grafana.com/gpg-full.key`.
* The package name is `alloy`.

### DNF/YUM (RHEL family)

* Grafana's documented repository is `https://rpm.grafana.com`.
* The documented key is `https://rpm.grafana.com/gpg.key`.
* The package name is `alloy`.

### Zypper (SUSE)

* Grafana documents a zypper repository, but this initial cookbook does not include SUSE in the verified Kitchen matrix.

## Architecture Limitations

* The cookbook follows Grafana's package repositories and does not currently model architecture-specific availability.

## Source/Compiled Installation

Source installation is out of scope. Use the Grafana repositories or a caller-supplied package source.

## Known Issues

* The package's default config at `/etc/alloy/config.alloy` does not send telemetry. The test cookbook writes a local no-op config suitable for service startup.

## Test and CI Notes

* Dokken is appropriate for repository/package/config/service testing.
* The supported local and CI platform set is Ubuntu 24.04, Debian 12, and AlmaLinux 9.
