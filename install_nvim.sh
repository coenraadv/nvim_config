#!/bin/bash

NEOVIM_REPO='https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz'
NVCHAD_REPO='https://github.com/NvChad/starter'
CONFIG_REPO='https://raw.githubusercontent.com/coenraadv/nvim_config/main/nvim'

function error_exit {
    echo "$1" 1>&2
    exit 1
}

echo "Downloading Neovim..."
curl -LO $NEOVIM_REPO || error_exit "Failed to download Neovim."

if [ -d "/opt/nvim" ]; then
    echo "Removing existing Neovim installation..."
    sudo rm -rf /opt/nvim || error_exit "Failed to remove existing Neovim installation."
fi

echo "Extracting Neovim..."
sudo tar -C /opt -xzf nvim-linux64.tar.gz || error_exit "Failed to extract Neovim."

echo "Adding Neovim to PATH..."
if ! grep -q '/opt/nvim-linux64/bin' ~/.bashrc; then
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc || error_exit "Failed to add Neovim to PATH in .bashrc"
    echo "Reloading bashrc..."
    source ~/.bashrc || error_exit "Failed to reload bashrc"
fi

if [ -d "~/.config/nvim" ]; then
    echo "Removing existing NvChad configuration..."
    sudo rm -rf ~/.config/nvim || error_exit "Failed to remove existing NvChad configuration."
fi

echo "Cloning NvChad repository..."
git clone $NVCHAD_REPO ~/.config/nvim && nvim || error_exit "Failed to clone NvChad repository"

echo "Adding custom config to NvChad..."
sudo rm ~/.config/nvim
curl -o ~/.config/nvim $CONFIG_REPO || error_exit "Failed to add custom config to NvChad"

echo "Neovim installation and configuration complete."
