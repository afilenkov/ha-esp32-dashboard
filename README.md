# ESP32 Waveshare E-Paper Dashboard for Home Assistant

A Home Assistant dashboard using ESP32 and Waveshare e-paper display powered by ESPHome.

## Features

- 🕐 Real-time clock display
- 🌤️ Weather information (temperature and humidity)
- 🏠 Indoor sensor readings
- 📡 WiFi connectivity status
- 🔄 Auto-refresh display every 5 minutes
- 🌐 Web interface for configuration
- 🔒 Secure API integration with Home Assistant
- 💾 OTA (Over-The-Air) updates

## Hardware Requirements

- ESP32 development board (e.g., ESP32-DevKitC)
- Waveshare e-paper display (7.5" or other supported models)
- Connecting wires

### Supported Waveshare Display Models

This configuration is set up for the 7.5" V2 model, but you can easily change it to support other models:
- 1.54" (1.54in)
- 2.13" (2.13in-ttgo)
- 2.70" (2.70in)
- 2.90" (2.90in)
- 4.20" (4.20in)
- 7.50" (7.50in, 7.50inv2, 7.50inv2b)

## Wiring

Connect your Waveshare e-paper display to ESP32 as follows:

| Waveshare Pin | ESP32 Pin | Description |
|---------------|-----------|-------------|
| VCC | 3.3V | Power supply |
| GND | GND | Ground |
| DIN (MOSI) | GPIO23 | SPI Data |
| CLK | GPIO18 | SPI Clock |
| CS | GPIO5 | Chip Select |
| DC | GPIO17 | Data/Command |
| RST | GPIO16 | Reset |
| BUSY | GPIO4 | Busy signal |

**Note**: You can change these pins in the `esp32-dashboard.yaml` file if needed.

## Software Requirements

- [ESPHome](https://esphome.io/) installed
- [Home Assistant](https://www.home-assistant.io/) running
- Python 3.7 or later

## Installation

### 1. Install ESPHome

```bash
pip3 install esphome
```

### 2. Clone this repository

```bash
git clone https://github.com/afilenkov/ha-esp32-dashboard.git
cd ha-esp32-dashboard
```

### 3. Download Required Fonts

Create a `fonts` directory and download the required fonts:

```bash
mkdir -p fonts
cd fonts

# Download Roboto fonts
wget https://github.com/google/roboto/releases/download/v2.138/roboto-unhinted.zip
unzip roboto-unhinted.zip
mv roboto-unhinted/Roboto-Regular.ttf .
mv roboto-unhinted/Roboto-Bold.ttf .

# Download Material Design Icons font
wget https://github.com/Templarian/MaterialDesign-Webfont/raw/master/fonts/materialdesignicons-webfont.ttf

cd ..
```

### 4. Configure Secrets

Copy the example secrets file and edit it with your credentials:

```bash
cp secrets.yaml.example secrets.yaml
nano secrets.yaml  # or use your preferred editor
```

Fill in the following:
- `wifi_ssid`: Your WiFi network name
- `wifi_password`: Your WiFi password
- `ha_api_key`: Home Assistant API encryption key (will be generated on first connection)
- `ota_password`: Password for OTA updates (choose a secure password)
- `ap_password`: Fallback hotspot password

### 5. Customize the Configuration

Edit `esp32-dashboard.yaml` to match your setup:

1. **Change timezone**: Update the timezone in the `time` section
2. **Update sensor entities**: Replace the example Home Assistant entity IDs with your actual sensors:
   - `weather.home` → your weather entity
   - `sensor.indoor_temperature` → your indoor temperature sensor
   - `sensor.indoor_humidity` → your indoor humidity sensor
3. **Adjust display model**: If you're not using the 7.5" V2 display, change the `model` parameter in the `display` section
4. **Modify pin assignments**: If your wiring is different, update the pin numbers

### 6. Compile and Upload

Connect your ESP32 via USB and run:

```bash
esphome run esp32-dashboard.yaml
```

For initial setup, choose the serial/USB option. After the first upload, you can use OTA updates.

## Configuration Options

### Display Update Interval

By default, the display updates every 5 minutes (300 seconds). You can change this in the `display` section:

```yaml
display:
  - platform: waveshare_epaper
    update_interval: 300s  # Change to your preferred interval
```

### Deep Sleep Mode (Power Saving)

To enable deep sleep mode for battery operation, uncomment the `deep_sleep` section at the end of `esp32-dashboard.yaml`:

```yaml
deep_sleep:
  run_duration: 30s      # Time awake to update display
  sleep_duration: 5min   # Time in deep sleep
  id: deep_sleep_1
```

### Adding More Sensors

To add additional sensors from Home Assistant, add them to the `sensor` section:

```yaml
sensor:
  - platform: homeassistant
    id: my_sensor
    entity_id: sensor.my_entity_id
    internal: true
```

Then display them in the `display` lambda function:

```cpp
if (id(my_sensor).has_state()) {
  it.printf(x, y, id(font_medium), "Value: %.1f", id(my_sensor).state);
}
```

## Integration with Home Assistant

### Add Device to Home Assistant

After uploading the firmware:

1. Go to **Configuration** → **Integrations** in Home Assistant
2. Look for the ESPHome integration notification
3. Click **Configure** and add your device
4. The dashboard will automatically connect

### Manual Refresh Button

You can add a button to your Home Assistant dashboard to manually refresh the display:

```yaml
type: button
tap_action:
  action: call-service
  service: button.press
  target:
    entity_id: button.esp32_dashboard_refresh_display
name: Refresh Display
icon: mdi:refresh
```

## Troubleshooting

### Display Not Updating

1. Check WiFi connection - look at the logs: `esphome logs esp32-dashboard.yaml`
2. Verify Home Assistant API connection
3. Check that sensor entity IDs are correct
4. Ensure the BUSY pin is properly connected

### Compilation Errors

1. Make sure all fonts are downloaded to the `fonts` directory
2. Verify ESPHome is up to date: `pip3 install --upgrade esphome`
3. Check that all required libraries are installed

### Display Shows Garbage/Nothing

1. Verify wiring connections
2. Check if the correct display model is specified
3. Try adjusting the `rotation` parameter (0, 90, 180, or 270)

### OTA Updates Not Working

1. Ensure the ESP32 is on the same network
2. Check that the OTA password matches in secrets.yaml
3. Try uploading via USB first to reset the OTA configuration

## Customization

### Changing Layout

The display layout is controlled by the lambda function in the `display` section. You can modify the coordinates and add/remove elements as needed.

### Adding Weather Icons

To add weather condition icons, expand the font glyphs section with more Material Design Icons:

```yaml
font:
  - file: "fonts/materialdesignicons-webfont.ttf"
    id: font_icons
    size: 48
    glyphs:
      - "\U000F0590" # weather-cloudy
      # Add more icon codes here
```

Find icon codes at [Material Design Icons](https://materialdesignicons.com/).

### Using Different Display Sizes

For different display sizes, adjust the coordinates in the lambda function and update the `model` parameter. Common models:
- 1.54": `model: 1.54in`
- 2.90": `model: 2.90in`
- 4.20": `model: 4.20in`
- 7.50": `model: 7.50in` or `7.50inv2`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Credits

- [ESPHome](https://esphome.io/) - The framework powering this project
- [Home Assistant](https://www.home-assistant.io/) - Home automation platform
- [Waveshare](https://www.waveshare.com/) - E-paper display hardware

## Support

If you encounter any issues or have questions:
1. Check the [ESPHome documentation](https://esphome.io/components/display/waveshare_epaper.html)
2. Review the [troubleshooting section](#troubleshooting) above
3. Open an issue on GitHub

## Examples

### Basic Temperature Display

```yaml
display:
  lambda: |-
    it.printf(0, 0, id(font_large), "%.1f°C", id(temperature).state);
```

### Custom Sensor Display

```yaml
sensor:
  - platform: homeassistant
    id: power_usage
    entity_id: sensor.power_consumption
    
display:
  lambda: |-
    it.printf(10, 100, id(font_medium), "Power: %.0fW", id(power_usage).state);
```

## Updates and Maintenance

To update your ESP32 firmware:

1. Pull the latest changes: `git pull`
2. Update ESPHome: `pip3 install --upgrade esphome`
3. Compile and upload: `esphome run esp32-dashboard.yaml`

For OTA updates (after initial USB upload):

```bash
esphome run esp32-dashboard.yaml --device esp32-dashboard.local
```

---

**Note**: Remember to never commit your `secrets.yaml` file to version control!