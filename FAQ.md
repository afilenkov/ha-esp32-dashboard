# Frequently Asked Questions (FAQ)

## General Questions

### Q: What is this project?
**A:** This is a Home Assistant dashboard implementation for ESP32 microcontrollers with Waveshare e-paper displays. It allows you to display real-time information from your Home Assistant setup on a low-power e-ink screen.

### Q: Why use an e-paper display?
**A:** E-paper displays:
- Only consume power when refreshing
- Are readable in bright sunlight
- Look like printed paper
- Can retain image without power
- Are perfect for always-on displays

### Q: Do I need programming experience?
**A:** No! The project uses YAML configuration files that are easy to customize. Basic text editing skills are sufficient.

### Q: How much does this cost to build?
**A:** Approximate costs:
- ESP32 board: $5-15
- Waveshare display: $15-50 (depending on size)
- Wires and components: $5-10
- **Total: $25-75**

## Hardware Questions

### Q: Which ESP32 board should I buy?
**A:** Any ESP32 development board works. Popular choices:
- ESP32-DevKitC
- ESP32-WROOM-32
- NodeMCU-32S
- DOIT ESP32 DevKit

Avoid ESP8266 - it's not compatible.

### Q: Which Waveshare display should I choose?
**A:** It depends on your use case:
- **2.9"** - Best for small spaces, battery operation
- **4.2"** - Good balance of size and detail
- **7.5"** - Large dashboard, shows most information
- **1.54"** - Very compact, limited information

### Q: Can I use a different e-paper display brand?
**A:** ESPHome primarily supports Waveshare displays. Other brands may require custom drivers.

### Q: Does this work with ESP8266?
**A:** No, this project requires ESP32. ESP8266 has limited memory and processing power for this application.

### Q: Can I power this with batteries?
**A:** Yes! Use the battery example configuration with deep sleep. A 2000mAh battery can last 2-4 weeks with 15-minute update intervals.

### Q: What battery do I need?
**A:** Recommended:
- Li-Ion 18650 battery (3.7V, 2000-3000mAh)
- Battery holder or shield
- Optional: TP4056 charging module

## Software Questions

### Q: Do I need Home Assistant?
**A:** Yes, this project is designed to display data from Home Assistant. However, you could modify it to work standalone.

### Q: What version of Home Assistant do I need?
**A:** Any recent version (2021.x or later) with ESPHome integration enabled.

### Q: Do I need ESPHome add-on in Home Assistant?
**A:** No, you can run ESPHome from your computer. The add-on is convenient but not required.

### Q: Can I use this without WiFi?
**A:** No, WiFi is required to fetch data from Home Assistant.

### Q: Does it work on 5GHz WiFi?
**A:** No, ESP32 only supports 2.4GHz WiFi networks.

## Configuration Questions

### Q: How do I find my Home Assistant entity IDs?
**A:** 
1. Open Home Assistant
2. Go to Developer Tools → States
3. Search for your sensor
4. Copy the entity ID (e.g., `sensor.living_room_temperature`)

### Q: Can I display images on the screen?
**A:** Yes, but you need to convert them to the appropriate format. ESPHome supports image components.

### Q: How often does the display update?
**A:** Default is every 5 minutes (300 seconds). You can change this in the configuration:
```yaml
update_interval: 300s  # Change to your preference
```

### Q: Can I update the display manually?
**A:** Yes! Use the refresh button in Home Assistant or call the button service.

### Q: How do I change the timezone?
**A:** Edit the timezone in your configuration:
```yaml
time:
  - platform: homeassistant
    id: ha_time
    timezone: "America/New_York"  # Change this
```

Find your timezone from the [TZ database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

### Q: Can I customize the layout?
**A:** Yes! Edit the `lambda:` section in the display configuration. It uses C++ syntax with ESPHome drawing functions.

## Installation Questions

### Q: Where do I upload the firmware?
**A:** Connect your ESP32 via USB and run:
```bash
esphome run esp32-dashboard.yaml
```

### Q: The compilation takes forever. Is this normal?
**A:** Yes, first compilation can take 5-10 minutes. Subsequent compilations are faster (1-2 minutes).

### Q: Do I need to upload via USB every time?
**A:** No! After the first upload, you can use OTA (Over-The-Air) updates:
```bash
esphome run esp32-dashboard.yaml --device esp32-dashboard.local
```

### Q: Where do I get the fonts?
**A:** Download from:
- [Google Fonts - Roboto](https://fonts.google.com/specimen/Roboto)
- [Material Design Icons](https://github.com/Templarian/MaterialDesign-Webfont)

Or use the wget commands in the QUICKSTART guide.

## Troubleshooting Questions

### Q: Display shows nothing / is blank
**A:** Check:
1. Wiring connections (especially BUSY pin)
2. Display model in YAML matches your hardware
3. Power supply is adequate (3.3V stable)
4. Logs for errors: `esphome logs esp32-dashboard.yaml`

### Q: Display shows garbage/random pixels
**A:** Try:
1. Different display model variant (e.g., `7.50in` vs `7.50inv2`)
2. Adjust rotation parameter (0, 90, 180, 270)
3. Power cycle the display
4. Check for loose wiring

### Q: Sensors show "unavailable"
**A:** Verify:
1. Entity IDs match your Home Assistant sensors
2. Home Assistant API is connected (check logs)
3. Sensors exist and have values in Home Assistant

### Q: ESP32 won't connect to WiFi
**A:** Check:
1. SSID and password in `secrets.yaml` are correct
2. WiFi is 2.4GHz (not 5GHz)
3. ESP32 is within range of router
4. Special characters in password are properly escaped

### Q: Compilation fails with "font not found"
**A:** Make sure:
1. Fonts are in the `fonts/` directory
2. Font file names match exactly (case-sensitive)
3. Path in YAML is correct relative to the YAML file

### Q: Display updates but shows old data
**A:** Check:
1. Home Assistant sensors are updating
2. Time is synchronized (check logs)
3. WiFi connection is stable
4. API key is correct

### Q: OTA updates don't work
**A:** Try:
1. Ensure ESP32 is on same network
2. Check firewall settings
3. Upload via USB once to reset OTA
4. Verify OTA password matches

### Q: High power consumption / battery drains fast
**A:** Solutions:
1. Enable deep sleep mode
2. Increase sleep duration
3. Reduce update frequency
4. Check for poor connections causing leakage
5. Use battery-optimized configuration

## Customization Questions

### Q: Can I add more sensors?
**A:** Yes! Add to the sensor section:
```yaml
sensor:
  - platform: homeassistant
    id: my_sensor
    entity_id: sensor.my_entity
    internal: true
```

Then display in the lambda function.

### Q: How do I add weather icons?
**A:** Use Material Design Icons:
1. Find icon code at [materialdesignicons.com](https://materialdesignicons.com/)
2. Add to font glyphs section
3. Use in display lambda

### Q: Can I use multiple displays?
**A:** Yes, but you'll need separate ESP32 boards for each display. Each gets its own configuration file.

### Q: How do I rotate the display?
**A:** Add to display configuration:
```yaml
display:
  rotation: 90  # 0, 90, 180, or 270
```

### Q: Can I add a touchscreen?
**A:** Some Waveshare displays have touchscreen versions. ESPHome supports touch with additional configuration.

## Performance Questions

### Q: How long does a display refresh take?
**A:** Typically 2-15 seconds depending on display size. Larger displays take longer.

### Q: Will frequent updates damage the display?
**A:** E-paper displays have limited refresh cycles (100,000+). Refreshing every 5 minutes should last many years.

### Q: Can I refresh faster than 5 minutes?
**A:** Yes, but it will:
- Reduce display lifespan faster
- Use more power
- May cause ghosting

Recommended minimum: 1 minute

### Q: How much RAM does this use?
**A:** Typical usage: 40-60% of ESP32's RAM. Plenty of headroom for customization.

## Advanced Questions

### Q: Can I use this offline?
**A:** Not really. The display needs Home Assistant for data. You could modify it to show static content or use local sensors.

### Q: Can I integrate with other smart home systems?
**A:** ESPHome is primarily for Home Assistant. For other systems, significant modification would be needed.

### Q: Can I add a motion sensor to wake the display?
**A:** Yes! Add a PIR sensor and use it to trigger display updates or wake from deep sleep.

### Q: Can I log data to SD card?
**A:** ESP32 supports SD cards, but you'll need to add the hardware and configuration. Not included by default.

### Q: Can I use this commercially?
**A:** Yes! The MIT license allows commercial use. Attribution is appreciated but not required.

## Getting Help

### Q: Where can I get more help?
**A:** 
- Check the documentation in this repository
- Open an issue on GitHub
- Visit the [ESPHome Discord](https://discord.gg/KhAMKrd)
- Post on [Home Assistant Community Forum](https://community.home-assistant.io/)

### Q: How do I report bugs?
**A:** Open an issue on GitHub with:
- Description of the problem
- Your hardware setup
- Configuration file (remove secrets!)
- Relevant logs
- Steps to reproduce

### Q: Can I contribute to this project?
**A:** Yes! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Useful Links

- [ESPHome Documentation](https://esphome.io/)
- [Home Assistant](https://www.home-assistant.io/)
- [Waveshare Display Documentation](https://www.waveshare.com/product/displays/e-paper.htm)
- [Material Design Icons](https://materialdesignicons.com/)
- [ESP32 Pinout](https://randomnerdtutorials.com/esp32-pinout-reference-gpios/)

---

**Didn't find your answer?** Open an issue on GitHub!
