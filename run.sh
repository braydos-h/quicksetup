#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root" >&2
    exit 1
fi

set -e
set -o pipefail

echo "Updating and upgrading system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing useful tools: btop, htop, curl, git, unzip..."
sudo apt-get install -y btop htop curl git unzip gnupg

echo "Installing Thunderbird (email client)..."
sudo apt-get install -y thunderbird

echo "Installing Tor Browser via torbrowser-launcher..."
sudo apt-get install -y torbrowser-launcher
echo "Running Tor Browser Launcher setup..."
torbrowser-launcher --install

echo "Downloading and installing Mullvad VPN..."
MULLVAD_DEB_URL="https://mullvad.net/en/download/app/deb/latest"
MULLVAD_DEB="mullvad-latest.deb"
curl -L "$MULLVAD_DEB_URL" -o "$MULLVAD_DEB"
sudo dpkg -i "$MULLVAD_DEB" || sudo apt-get --fix-broken install -y

echo "Cleaning up..."
rm -f "$MULLVAD_DEB"

echo "All done. Reboot may be needed for Mullvad VPN to fully integrate."
