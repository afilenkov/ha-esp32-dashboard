# Configuration Examples

This directory contains example configurations for different use cases and display sizes.

## Available Examples

1. **esp32-dashboard-basic.yaml** - Minimal configuration for getting started
2. **esp32-dashboard-weather.yaml** - Weather-focused dashboard
3. **esp32-dashboard-small.yaml** - Configuration for smaller displays (2.9" or 2.13")
4. **esp32-dashboard-battery.yaml** - Battery-powered configuration with deep sleep

## Usage

Copy the example that best fits your needs and customize it:

```bash
cp examples/esp32-dashboard-basic.yaml my-dashboard.yaml
```

Then edit the file with your specific settings and upload:

```bash
esphome run my-dashboard.yaml
```
