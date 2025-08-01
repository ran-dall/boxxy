#!/usr/bin/env bash

set -eoux pipefail

# Fetch the latest release information from GitHub API
LATEST_RELEASE=$(curl -s https://api.github.com/repos/apple/pkl-vscode/releases/latest)

# Extract the tag name (version) from the JSON response
VERSION=$(echo "$LATEST_RELEASE" | grep '"tag_name":' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')

# Construct the download URL and filename
DOWNLOAD_URL="https://github.com/apple/pkl-vscode/releases/download/${VERSION}/pkl-vscode-${VERSION}.vsix"
FILENAME="pkl-vscode-${VERSION}.vsix"

echo "Downloading pkl-vscode extension version: $VERSION"
wget "$DOWNLOAD_URL" -O "$FILENAME"

mise use java

echo "Installing pkl-vscode extension..."
code --install-extension "$FILENAME"

echo "Cleaning up downloaded file..."
rm "$FILENAME"

echo "pkl-vscode extension $VERSION installed successfully!"
