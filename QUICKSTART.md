# Quick Start Guide - ESP32 Waveshare Dashboard

Get your ESP32 dashboard up and running in 30 minutes!

## Prerequisites Checklist

- [ ] ESP32 development board
- [ ] Waveshare e-paper display
- [ ] USB cable for ESP32
- [ ] Jumper wires
- [ ] Computer with Python 3.7+
- [ ] Home Assistant instance running

## Step-by-Step Setup

### Step 1: Hardware Assembly (5 minutes)

Connect your display to ESP32 following this simple table:

| Display | → | ESP32 |
|---------|---|-------|
| VCC | → | 3.3V |
| GND | → | GND |
| DIN | → | GPIO23 |
| CLK | → | GPIO18 |
| CS | → | GPIO5 |
| DC | → | GPIO17 |
| RST | → | GPIO16 |
| BUSY | → | GPIO4 |

> 💡 **Tip**: Use colored wires to make debugging easier (Red=VCC, Black=GND)

### Step 2: Install ESPHome (2 minutes)

```bash
# Install ESPHome
pip3 install esphome

# Verify installation
esphome version
```

### Step 3: Get the Project Files (2 minutes)

```bash
# Clone the repository
git clone https://github.com/afilenkov/ha-esp32-dashboard.git
cd ha-esp32-dashboard

# Create fonts directory
mkdir fonts
```

### Step 4: Download Fonts (3 minutes)

```bash
cd fonts

# Download Roboto fonts
wget https://github.com/google/roboto/releases/download/v2.138/roboto-unhinted.zip
unzip roboto-unhinted.zip
cp roboto-unhinted/Roboto-Regular.ttf .
cp roboto-unhinted/Roboto-Bold.ttf .
rm -rf roboto-unhinted roboto-unhinted.zip

# Download Material Design Icons
wget https://github.com/Templarian/MaterialDesign-Webfont/raw/master/fonts/materialdesignicons-webfont.ttf

cd ..
```

**Alternative - Manual Download:**
1. Go to [Google Fonts - Roboto](https://fonts.google.com/specimen/Roboto)
2. Download and extract to `fonts/` folder
3. Download [Material Design Icons](https://github.com/Templarian/MaterialDesign-Webfont/raw/master/fonts/materialdesignicons-webfont.ttf)

### Step 5: Configure Your Settings (5 minutes)

```bash
# Copy the example secrets file
cp secrets.yaml.example secrets.yaml

# Edit with your favorite editor
nano secrets.yaml  # or use: vim, code, etc.
```

Fill in these values:
```yaml
wifi_ssid: "YourWiFiName"
wifi_password: "YourWiFiPassword"
ha_api_key: "will-be-generated-automatically"
ota_password: "choose-a-secure-password"
ap_password: "fallback-hotspot-password"
```

### Step 6: Customize Entity IDs (5 minutes)

Open `esp32-dashboard.yaml` and update these lines:

```yaml
# Line ~100: Weather entity
sensor:
  - platform: homeassistant
    id: outside_temperature
    entity_id: weather.home  # ← Change to YOUR weather entity
    
# Line ~130: Indoor sensors
  - platform: homeassistant
    id: indoor_temperature
    entity_id: sensor.indoor_temperature  # ← Change to YOUR sensor
```

**How to find your entity IDs:**
1. Open Home Assistant
2. Go to Developer Tools → States
3. Search for your sensors
4. Copy the entity ID (e.g., `sensor.living_room_temperature`)

### Step 7: Choose Your Configuration (2 minutes)

Pick the configuration that matches your needs:

**For testing:**
```bash
# Use the basic example (minimal configuration)
cp examples/esp32-dashboard-basic.yaml my-dashboard.yaml
```

**For weather dashboard:**
```bash
# Use the weather example
cp examples/esp32-dashboard-weather.yaml my-dashboard.yaml
```

**For small display (2.9" or 2.13"):**
```bash
# Use the small display example
cp examples/esp32-dashboard-small.yaml my-dashboard.yaml
```

**For battery operation:**
```bash
# Use the battery example
cp examples/esp32-dashboard-battery.yaml my-dashboard.yaml
```

Or use the main `esp32-dashboard.yaml` directly!

### Step 8: First Upload (5 minutes)

Connect your ESP32 via USB and run:

```bash
# Compile and upload
esphome run esp32-dashboard.yaml

# When prompted, select:
# [1] Plug into USB (for first upload)
```

**What happens:**
1. ESPHome compiles the firmware (2-3 minutes)
2. Firmware uploads to ESP32 (1 minute)
3. ESP32 reboots and connects to WiFi
4. Display refreshes with your dashboard!

### Step 9: Add to Home Assistant (2 minutes)

1. Open Home Assistant
2. Go to **Settings** → **Devices & Services**
3. You should see "ESPHome" notification
4. Click **Configure**
5. Enter the encryption key if prompted (from your device logs)
6. Done! Your dashboard is now integrated

### Step 10: Verify Everything Works (5 minutes)

1. **Check the display** - Should show time and sensor data
2. **Check Home Assistant** - Device should appear with all sensors
3. **Test refresh** - Use the refresh button in Home Assistant
4. **Check logs**:
   ```bash
   esphome logs esp32-dashboard.yaml
   ```

## Common First-Time Issues

### Issue: "Can't find fonts"
**Solution**: Make sure fonts are in the `fonts/` directory relative to your YAML file

### Issue: "Sensor shows 'unavailable'"
**Solution**: Update the entity IDs in your YAML file to match your actual Home Assistant sensors

### Issue: "Display shows nothing"
**Solution**: 
- Check wiring connections
- Verify the display model in YAML matches your hardware
- Check logs for errors: `esphome logs esp32-dashboard.yaml`

### Issue: "ESP32 won't connect to WiFi"
**Solution**: 
- Double-check WiFi credentials in `secrets.yaml`
- Ensure WiFi is 2.4GHz (ESP32 doesn't support 5GHz)
- Check if you're too far from router

### Issue: "Compilation failed"
**Solution**: 
- Update ESPHome: `pip3 install --upgrade esphome`
- Check Python version: `python3 --version` (need 3.7+)
- Install dependencies: `pip3 install platformio`

## Next Steps

### Enable OTA Updates
After the first USB upload, you can update wirelessly:

```bash
esphome run esp32-dashboard.yaml --device esp32-dashboard.local
```

### Customize Your Display
Edit the `lambda:` section in your YAML file to:
- Add more sensors
- Change layout
- Add icons
- Adjust fonts and sizes

### Add Manual Refresh Button
Create a button in Home Assistant Lovelace:

```yaml
type: button
tap_action:
  action: call-service
  service: button.press
  target:
    entity_id: button.esp32_dashboard_refresh_display
name: Refresh Dashboard
icon: mdi:refresh
```

### Enable Deep Sleep (Battery Mode)
Uncomment the deep_sleep section or use `esp32-dashboard-battery.yaml` example

### Monitor Performance
Add these to your Home Assistant dashboard:
- WiFi signal strength sensor
- Last update time
- Battery level (if using battery)

## Maintenance

### Update Firmware
```bash
# Pull latest changes
git pull

# Upload new firmware
esphome run esp32-dashboard.yaml
```

### Change Display Update Frequency
In your YAML file:
```yaml
display:
  update_interval: 300s  # Change from 300s (5min) to your preference
```

### Backup Your Configuration
```bash
# Create a backup
cp esp32-dashboard.yaml esp32-dashboard-backup.yaml
cp secrets.yaml secrets-backup.yaml
```

## Getting Help

- 📖 Check the main [README.md](README.md) for detailed documentation
- 🔌 See [WIRING.md](WIRING.md) for wiring diagrams and troubleshooting
- 💬 Open an issue on GitHub
- 🌐 Visit [ESPHome Documentation](https://esphome.io)

## Tips for Success

1. ✅ **Test basic example first** before complex configurations
2. ✅ **Keep wires short** - use 10-15cm maximum
3. ✅ **Use quality power supply** - cheap adapters can cause issues
4. ✅ **Start simple** - add sensors one at a time
5. ✅ **Check logs often** - they tell you what's wrong
6. ✅ **Document your changes** - comment your customizations

## Congratulations! 🎉

You now have a working ESP32 Home Assistant dashboard! 

Share your setup on the Home Assistant community forum and show off your creation!
