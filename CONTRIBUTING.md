# Contributing to ESP32 Waveshare Dashboard

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your hardware setup (ESP32 model, display model)
- ESPHome version
- Relevant logs or error messages

### Suggesting Enhancements

Enhancement suggestions are welcome! Please open an issue with:
- Clear description of the enhancement
- Use case or problem it solves
- Any implementation ideas you have

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes**
4. **Test your changes** with actual hardware if possible
5. **Commit your changes** (`git commit -m 'Add amazing feature'`)
6. **Push to the branch** (`git push origin feature/amazing-feature`)
7. **Open a Pull Request**

## Development Guidelines

### Configuration Files

- Use clear, descriptive variable names
- Add comments for complex sections
- Follow ESPHome YAML formatting conventions
- Test with multiple display sizes when possible

### Documentation

- Update README.md if adding new features
- Include usage examples
- Document any new sensor configurations
- Update WIRING.md for hardware changes

### Examples

- Keep examples simple and focused
- Test examples before submitting
- Include comments explaining key sections
- Ensure examples work with common hardware

### Code Style

- Use 2-space indentation for YAML
- Keep lines under 100 characters when possible
- Use descriptive IDs for components
- Add internal: true for helper sensors

## Testing

Before submitting a PR:
- [ ] Configuration compiles without errors
- [ ] Test with actual hardware if possible
- [ ] Check that existing examples still work
- [ ] Verify documentation is updated
- [ ] Test with ESPHome latest stable version

## Project Structure

```
ha-esp32-dashboard/
├── esp32-dashboard.yaml      # Main configuration
├── secrets.yaml.example      # Example secrets file
├── examples/                 # Example configurations
│   ├── esp32-dashboard-basic.yaml
│   ├── esp32-dashboard-weather.yaml
│   ├── esp32-dashboard-small.yaml
│   └── esp32-dashboard-battery.yaml
├── fonts/                    # Font files (not in repo)
├── README.md                 # Main documentation
├── QUICKSTART.md            # Quick start guide
├── WIRING.md                # Wiring documentation
└── CONTRIBUTING.md          # This file
```

## Adding New Features

### Adding a New Sensor Type

1. Add sensor configuration to appropriate example file
2. Document in README.md with entity ID examples
3. Add display code to lambda function
4. Test with Home Assistant integration

### Adding Support for New Display Model

1. Create new example configuration
2. Document model specifications
3. Update WIRING.md if pin configuration differs
4. Test display refresh and update intervals

### Adding New Display Layouts

1. Create example in `examples/` directory
2. Include comments explaining layout sections
3. Provide screenshots or diagrams if possible
4. Document in examples/README.md

## Community Guidelines

- Be respectful and constructive
- Help others when you can
- Share your implementations
- Credit others' work appropriately

## Questions?

If you have questions about contributing:
- Open a discussion on GitHub
- Check existing issues and PRs
- Review ESPHome documentation

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes (for significant contributions)
- README acknowledgments (for major features)

Thank you for making this project better! 🎉
