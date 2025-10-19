# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-19

### Added
- Initial release of ESP32 Waveshare Dashboard
- Main configuration file (`esp32-dashboard.yaml`) with comprehensive display layout
- Support for multiple Waveshare e-paper display models (1.54", 2.13", 2.90", 4.20", 7.50")
- Four example configurations:
  - Basic: Minimal setup for testing
  - Weather: Weather-focused dashboard with icons
  - Small: Optimized for 2.9" and 2.13" displays
  - Battery: Power-efficient configuration with deep sleep
- Comprehensive documentation:
  - README with full setup instructions
  - QUICKSTART guide for 30-minute setup
  - WIRING guide with detailed pin diagrams
  - CONTRIBUTING guidelines
- Home Assistant API integration with encryption
- OTA (Over-The-Air) update support
- WiFi configuration with fallback access point
- Time synchronization from Home Assistant
- Weather sensor integration (temperature, humidity, wind speed)
- Indoor sensor support
- Material Design Icons support
- Customizable fonts (Roboto family)
- Manual display refresh button
- Deep sleep mode for battery operation
- Battery level monitoring (for battery-powered setups)
- WiFi signal strength monitoring
- Status indicators and last update timestamp

### Features
- Auto-refresh every 5 minutes (configurable)
- Responsive display layouts for different screen sizes
- Low power consumption with deep sleep
- Web server for local configuration
- Captive portal for initial WiFi setup
- Multiple sensor types support
- Extensive customization options

### Documentation
- Quick start guide for new users
- Detailed wiring diagrams and pin configurations
- Troubleshooting guides
- Contributing guidelines
- MIT License
- Example configurations for common use cases

### Technical Details
- ESPHome-based firmware
- ESP32 platform support
- SPI communication for e-paper displays
- YAML-based configuration
- Modular sensor architecture
- Secure API encryption

## [Unreleased]

### Planned Features
- Support for additional sensor types
- Pre-built binary firmware
- Web-based configuration tool
- Additional display layouts
- Multi-language support
- Enhanced weather icons and graphics
- Calendar integration
- Energy monitoring displays
- Custom image support
- Touchscreen support for compatible displays

---

## Version History

- **1.0.0** (2025-10-19): Initial release with full dashboard functionality
