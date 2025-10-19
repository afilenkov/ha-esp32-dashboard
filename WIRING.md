# Wiring Guide for ESP32 Waveshare E-Paper Display

## Table of Contents
- [Standard Wiring](#standard-wiring)
- [Power Considerations](#power-considerations)
- [Alternative Pin Configurations](#alternative-pin-configurations)
- [Battery Operation](#battery-operation)
- [Troubleshooting](#troubleshooting)

## Standard Wiring

### Waveshare E-Paper to ESP32 Connection

```
Waveshare Display          ESP32
==================         =================
VCC (3.3V)        <----->  3.3V
GND               <----->  GND
DIN (MOSI)        <----->  GPIO23 (MOSI)
CLK (SCLK)        <----->  GPIO18 (SCK)
CS (Chip Select)  <----->  GPIO5
DC (Data/Command) <----->  GPIO17
RST (Reset)       <----->  GPIO16
BUSY              <----->  GPIO4
```

### Visual Diagram

```
                    ESP32 DevKit
                   ┌────────────┐
    3.3V  <------> │ 3V3     GND│ <-----> GND
   GPIO23 <------> │ D23     D18│ <-----> CLK
   GPIO5  <------> │ D5      D17│ <-----> DC
   GPIO16 <------> │ D16     D4 │ <-----> BUSY
                   └────────────┘
                   
                   Waveshare Display
                   ┌────────────────┐
     VCC <-------> │  VCC       GND │ <-----> GND
     DIN <-------> │  DIN       CLK │ <-----> CLK
     CS  <-------> │  CS        DC  │ <-----> DC
     RST <-------> │  RST      BUSY │ <-----> BUSY
                   └────────────────┘
```

## Power Considerations

### Power Supply Options

1. **USB Power (Development)**
   - Connect ESP32 to computer via USB cable
   - Provides stable 5V power
   - Best for initial setup and testing

2. **External 5V Supply**
   - Use a quality 5V power adapter
   - ESP32 regulates to 3.3V internally
   - Recommended: 1A or higher capacity

3. **Battery Power (Portable)**
   - Li-Ion battery (3.7V nominal)
   - Use a voltage booster to 5V or battery shield
   - See [Battery Operation](#battery-operation) section

### Power Consumption Notes

- E-paper displays only consume power during refresh
- ESP32 in deep sleep: ~10-150µA
- ESP32 active + display refresh: ~150-300mA
- Battery life with deep sleep: days to weeks depending on update frequency

## Alternative Pin Configurations

You can use different GPIO pins if needed. Update the YAML configuration accordingly:

### Option 1: Different SPI Pins
```yaml
spi:
  clk_pin: GPIO14  # Alternative SCLK
  mosi_pin: GPIO13 # Alternative MOSI

display:
  - platform: waveshare_epaper
    cs_pin: GPIO15
    dc_pin: GPIO2
    busy_pin: GPIO0
    reset_pin: GPIO4
```

### Option 2: Using VSPI (ESP32 has two SPI buses)
```yaml
spi:
  clk_pin: GPIO18  # VSPI SCLK (default)
  mosi_pin: GPIO23 # VSPI MOSI (default)

# Standard VSPI configuration
```

### Option 3: Using HSPI
```yaml
spi:
  clk_pin: GPIO14  # HSPI SCLK
  mosi_pin: GPIO13 # HSPI MOSI

display:
  - platform: waveshare_epaper
    cs_pin: GPIO15
    dc_pin: GPIO33
    busy_pin: GPIO27
    reset_pin: GPIO26
```

### GPIO Pin Restrictions on ESP32

**Safe to use (Input/Output):**
- GPIO0, GPIO2, GPIO4, GPIO5, GPIO12-GPIO19, GPIO21-GPIO23, GPIO25-GPIO27, GPIO32-GPIO39

**Input only (no pull-up resistors):**
- GPIO34-GPIO39

**Avoid using (boot mode/strapping pins):**
- GPIO0: Boot mode (pulled high during normal boot)
- GPIO2: Boot mode on some boards
- GPIO12: Boot voltage selection
- GPIO15: Boot mode

**Reserved/Special:**
- GPIO1 (TX0): Serial TX - avoid if using serial logging
- GPIO3 (RX0): Serial RX - avoid if using serial logging
- GPIO6-GPIO11: Connected to flash (DO NOT USE)

## Battery Operation

### Battery-Powered Setup

1. **Hardware Required:**
   - Li-Ion battery (3.7V, 2000mAh or higher recommended)
   - Battery holder or JST connector
   - Voltage regulator or ESP32 battery shield
   - Optional: voltage divider for battery monitoring

2. **Basic Battery Connection:**
```
Li-Ion Battery (3.7V)
    (+) ---> [Battery Shield] ---> ESP32 VIN/5V
    (-) ---> [Battery Shield] ---> ESP32 GND
```

3. **With Battery Monitoring:**
```
Battery (+) --[100kΩ]--+--[100kΩ]-- GND
                       |
                     GPIO34 (ADC)
```

### Battery Monitoring Circuit

For accurate battery level monitoring, use a voltage divider:

```yaml
sensor:
  - platform: adc
    pin: GPIO34
    name: "Battery Voltage"
    attenuation: 11db
    filters:
      - multiply: 2.0  # Adjust based on divider ratio
```

**Voltage Divider Calculation:**
- For 4.2V max battery and 3.3V ADC max
- Use equal resistors (100kΩ each) for 2:1 division
- Battery voltage = ADC reading × 2

### Deep Sleep Configuration for Battery

```yaml
deep_sleep:
  run_duration: 30s      # Time awake (fetch data + update display)
  sleep_duration: 15min  # Time in deep sleep
```

**Battery Life Estimation:**
- 2000mAh battery
- 15-minute sleep cycle
- ~30s active per cycle
- Expected life: 2-4 weeks

## Troubleshooting

### Display Not Working

1. **Check Power:**
   - Measure voltage at display VCC pin (should be 3.3V)
   - Ensure GND connections are solid

2. **Verify Wiring:**
   - Double-check all pin connections
   - Use multimeter to test continuity
   - Look for loose connections

3. **Check BUSY Pin:**
   - BUSY pin must be connected
   - Display won't update if BUSY is not connected
   - BUSY goes HIGH during refresh

### Partial Update Issues

- Some display models don't support partial updates
- Use full refresh mode
- Increase update interval to reduce wear

### Display Shows Inverted Colors

- Some models use inverted logic
- Try different model variants (e.g., `7.50in` vs `7.50inv2`)
- Check model specifications

### ESP32 Won't Boot

- Check if GPIO0 or GPIO2 are pulled down
- Disconnect display temporarily
- Upload firmware first, then connect display

### High Power Consumption in Deep Sleep

- Ensure all peripherals are powered down
- Check for poor connections causing current leakage
- Use `power_down` mode on display before sleep

## Display Models and Pin Requirements

| Display Size | Model Code | Resolution | Pins Required |
|-------------|------------|------------|---------------|
| 1.54" | 1.54in | 200×200 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |
| 2.13" | 2.13in-ttgo | 250×122 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |
| 2.90" | 2.90in | 296×128 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |
| 4.20" | 4.20in | 400×300 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |
| 7.50" | 7.50in | 640×384 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |
| 7.50" V2 | 7.50inv2 | 800×480 | VCC, GND, DIN, CLK, CS, DC, RST, BUSY |

## Tips for Reliable Operation

1. **Power Quality:**
   - Use decoupling capacitors (100nF ceramic + 10µF electrolytic) near ESP32
   - Stable power supply prevents brownouts during WiFi use

2. **Wire Length:**
   - Keep wires as short as possible
   - Use twisted pairs for SPI signals to reduce interference
   - Maximum recommended length: 15cm (6 inches)

3. **Testing:**
   - Test with USB power first before battery
   - Verify each sensor works independently
   - Test deep sleep with short intervals initially

4. **Mounting:**
   - Ensure display is properly supported
   - Protect ribbon cable from stress
   - Consider using a case to protect connections

## Additional Resources

- [ESPHome Display Documentation](https://esphome.io/components/display/)
- [Waveshare E-Paper Specifications](https://www.waveshare.com/product/displays/e-paper.htm)
- [ESP32 Pinout Reference](https://randomnerdtutorials.com/esp32-pinout-reference-gpios/)
