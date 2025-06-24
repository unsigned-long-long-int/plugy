#!/usr/bin/env bash
mkdir -p ~/.local/bin ~/.config/plugy/plugins
wget -O ~/.local/bin/plugy https://raw.githubusercontent.com/unsigned-long-long-int/plugy/refs/heads/main/plugy
chmod +x ~/.local/bin/plugy
echo "Plugy has been installed at ~/.local/bin/plugy. Ensure it is present in \$PATH"
