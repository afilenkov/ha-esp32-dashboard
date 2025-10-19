#!/bin/bash
# Font Installation Script for ESP32 Dashboard
# This script downloads the required fonts for the dashboard

set -e

echo "=================================="
echo "ESP32 Dashboard Font Installer"
echo "=================================="
echo ""

# Create fonts directory
echo "Creating fonts directory..."
mkdir -p fonts
cd fonts

# Download Roboto fonts
echo ""
echo "Downloading Roboto fonts..."
if command -v wget &> /dev/null; then
    wget -q --show-progress https://github.com/google/roboto/releases/download/v2.138/roboto-unhinted.zip
elif command -v curl &> /dev/null; then
    curl -L -o roboto-unhinted.zip https://github.com/google/roboto/releases/download/v2.138/roboto-unhinted.zip
else
    echo "Error: Neither wget nor curl is installed. Please install one of them."
    exit 1
fi

# Extract Roboto fonts
echo "Extracting Roboto fonts..."
if command -v unzip &> /dev/null; then
    unzip -q roboto-unhinted.zip
else
    echo "Error: unzip is not installed. Please install it."
    exit 1
fi

# Copy required fonts
echo "Installing Roboto-Regular.ttf..."
cp roboto-unhinted/Roboto-Regular.ttf .

echo "Installing Roboto-Bold.ttf..."
cp roboto-unhinted/Roboto-Bold.ttf .

# Clean up
echo "Cleaning up..."
rm -rf roboto-unhinted roboto-unhinted.zip

# Download Material Design Icons
echo ""
echo "Downloading Material Design Icons..."
if command -v wget &> /dev/null; then
    wget -q --show-progress https://github.com/Templarian/MaterialDesign-Webfont/raw/master/fonts/materialdesignicons-webfont.ttf
elif command -v curl &> /dev/null; then
    curl -L -o materialdesignicons-webfont.ttf https://github.com/Templarian/MaterialDesign-Webfont/raw/master/fonts/materialdesignicons-webfont.ttf
fi

cd ..

echo ""
echo "=================================="
echo "✓ Font installation complete!"
echo "=================================="
echo ""
echo "Installed fonts:"
ls -lh fonts/*.ttf
echo ""
echo "You can now compile your ESP32 dashboard configuration."
