#!/bin/bash
# Install Hugo
echo "Installing Hugo..."
wget -q https://github.com/gohugoio/hugo/releases/download/v0.146.0/hugo_extended_0.146.0_linux-amd64.tar.gz
tar -xzf hugo_extended_0.146.0_linux-amd64.tar.gz
chmod +x hugo
./hugo version

# Build the site
echo "Building Hugo site..."
./hugo --minify

echo "Build complete!"