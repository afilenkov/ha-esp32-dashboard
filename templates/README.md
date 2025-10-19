# Configuration Templates

This directory contains templates to help you create custom dashboard configurations.

## Available Templates

### custom-template.yaml
A fully commented template with:
- All common configuration sections
- Extensive inline documentation
- Layout tips and drawing function examples
- Sensor configuration examples
- Multiple use case examples

## How to Use

1. **Copy the template:**
   ```bash
   cp templates/custom-template.yaml my-dashboard.yaml
   ```

2. **Edit your copy:**
   - Change device name and friendly name
   - Update timezone
   - Add your Home Assistant sensor entities
   - Customize the display layout

3. **Test your configuration:**
   ```bash
   esphome config my-dashboard.yaml
   ```

4. **Upload to ESP32:**
   ```bash
   esphome run my-dashboard.yaml
   ```

## Template Features

The custom template includes:
- ✅ Complete working configuration
- ✅ Commented sections for easy understanding
- ✅ Examples for common sensor types
- ✅ Drawing function reference
- ✅ Text alignment options
- ✅ Time formatting reference
- ✅ Deep sleep configuration (commented out)
- ✅ Optional features ready to enable

## Quick Customization Guide

### Change Device Name
```yaml
substitutions:
  device_name: "my-custom-name"
  friendly_name: "My Display Name"
```

### Add a Temperature Sensor
```yaml
sensor:
  - platform: homeassistant
    id: my_temperature
    entity_id: sensor.bedroom_temperature  # Your entity
    internal: true

# In display lambda:
if (id(my_temperature).has_state()) {
  it.printf(50, 100, id(font_medium), "Temp: %.1f°C", id(my_temperature).state);
}
```

### Change Display Model
```yaml
display:
  - platform: waveshare_epaper
    model: 2.90in  # Change to your model
```

### Adjust Update Frequency
```yaml
display:
  update_interval: 600s  # 10 minutes instead of 5
```

## Tips

1. **Start Simple:** Begin with the basic example, then add features
2. **Test Often:** Compile frequently to catch errors early
3. **Use Comments:** Document your customizations for future reference
4. **Save Backups:** Keep copies of working configurations

## Need Help?

- Check the [QUICKSTART.md](../QUICKSTART.md) guide
- Review [examples/](../examples/) for working configurations
- Read the [FAQ.md](../FAQ.md) for common questions
- See [README.md](../README.md) for full documentation

## Contributing Templates

Have a useful template configuration? Consider contributing!
See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.
