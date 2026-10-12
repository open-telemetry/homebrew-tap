# Homebrew Tap for OpenTelemetry

A Homebrew tap for [OpenTelemetry](https://opentelemetry.io) tools.

## Scope and goals

This repository distributes OpenTelemetry command-line tools through [Homebrew](https://brew.sh), so they can be installed and upgraded with a single `brew` command.

- **Pre-built binaries only.** Formulas install the official binaries published by the upstream OpenTelemetry projects on their GitHub releases. Nothing is built from source here, and the tools themselves are not developed in this repository.
- **Upstream is the source of truth.** Formulas track upstream releases. Bug reports and feature requests for a tool belong in the tool's own repository; issues in this repo should concern the packaging (formulas, version bumps, install problems).
- **Automated updates.** New upstream releases are picked up by a workflow that opens a pull request bumping the formula version and checksums (see [`tools/upgrade.sh`](tools/upgrade.sh)).
- **Not in scope.** Packaging of the OpenTelemetry Collector distributions, SDKs, or other libraries. Only standalone command-line tools are packaged here.

## Supported platforms

Formulas are supported on both macOS and Linux (via [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)), on both architectures:

| OS    | arm64 | amd64 (x86_64) |
| ----- | :---: | :------------: |
| macOS |  yes  |      yes       |
| Linux |  yes  |      yes       |

Windows is not supported. New formulas are expected to cover the same set of platforms.

## Install

```sh
brew tap open-telemetry/tap
```

Then install any formula, for example:

```sh
brew install ocb
```

## Formulas

| Formula | Description |
| ------- | ----------- |
| [ocb](Formula/ocb.rb) | [OpenTelemetry Collector Builder](https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder) |

## Maintainers

- [Antoine Toulme](https://github.com/atoulme), [Splunk](https://www.splunk.com/)
- [Damien Mathieu](https://github.com/dmathieu), [Elastic](https://www.elastic.co/)
- [Denys Sedchenko](https://github.com/x1unix), [Grafana Labs](https://grafana.com/)
- [Douglas Camata](https://github.com/douglascamata), [Coralogix](https://coralogix.com/)
- [Michele Mancioppi](https://github.com/mmanciop), [Dash0](https://www.dash0.com/)

For more information about the maintainer role, see the [community repository](https://github.com/open-telemetry/community/blob/main/guides/contributor/membership.md#maintainer).

## Approvers

- TODO

For more information about the approver role, see the [community repository](https://github.com/open-telemetry/community/blob/main/guides/contributor/membership.md#approver).
