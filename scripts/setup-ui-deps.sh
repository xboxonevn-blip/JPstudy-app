#!/usr/bin/env bash
set -euo pipefail

# Install system libraries required for PySide6 UI on Debian/Ubuntu.
# Usage: bash scripts/setup-ui-deps.sh

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo not found; please run as root: apt-get update && apt-get install -y libgl1 libglib2.0-0 libx11-xcb1 libxcb-render0 libxcb-shape0 libxcb-xfixes0"
  exit 1
fi

echo "Updating apt cache..."
sudo apt-get update -y
echo "Installing PySide6 system deps (libGL/xcb)..."
sudo apt-get install -y \
  libgl1 \
  libglib2.0-0 \
  libx11-xcb1 \
  libxcb-render0 \
  libxcb-shape0 \
  libxcb-xfixes0

echo "Done. If running headless, start the app with:"
echo "  QT_QPA_PLATFORM=offscreen python main.py"
echo "or use xvfb-run for a virtual display:"
echo "  xvfb-run -s \"-screen 0 1280x720x24\" python main.py"
