#!/bin/bash

NEOVIM_REPO='https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz'
NVCHAD_REPO='https://github.com/NvChad/starter'
CONFIG_REPO=i'https://raw.githubusercontent.com/coenraadv/nvim_config/main/nvim'

function error_exit {
    echo "$1" 1>&2
    exit 1
}

echo "Downloading Neovim..."
curl -LO $NEOVIM_REPO || error_exit "Failed to download Neovim."

echo "Removing existing Neovim installation..."
sudo rm -rf /opt/nvim || error_exit "Failed to remove existing Neovim installation."

echo "Extracting Neovim..."
sudo tar -C /opt -xzf nvim-linux64.tar.gz || error_exit "Failed to extract Neovim."

echo "Adding path to bashrc"
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc || error_exit "Failed to add path to bash_rc"

echo "Reloading bashrc"
source ~/.bashrc || error_exit "Failed to reload bashrc"

echo "Cloning NvChad repository..."
sudo rm -r ~/.config/nvim
git clone $NVCHAD_REPO ~/.config/nvim && nvim || error_exit "Failed to clone NvChad repository"

echo "Adding Config to NvChad"
sudo rm -r ~/.config/nvim
curl -o ~/.config/nvim $CONFIG_REPO || error_exit "Failed to add config to NvChad"
