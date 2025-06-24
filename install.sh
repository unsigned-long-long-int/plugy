#!/usr/bin/env bash
git clone https://github.com/unsigned-long-long-int/plugy.git
mkdir -p ~/.local/bin ~/.config/plugy/plugins
cp plugy/plugy ~/.local/bin/plugy
chmod +x ~/.local/bin/plugy
echo "Pluggy has been installed at ~/.local/bin/plugy. Ensure it is present in $PATH"
