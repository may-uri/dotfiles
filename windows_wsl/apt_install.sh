#!/bin/bash


# Update and upgrade
sudo apt update
sudo apt upgrade -y
sudo apt install -y git tmux curl fish ripgrep nodejs jq tar gcc unzip npm

# URL of the latest release tar file
url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"

# Download the tar file
curl -L -o nvim.tar.gz $url

# Extract the contents of the tar file
tar xzf nvim.tar.gz

# Cleanup: Remove the tar file
rm nvim.tar.gz


# LazyGit install
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf $HOME/lazygit lazygit.tar.gz



# Run fish shell commands
# MANNUALLY
#curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
#fisher install jethrokuan/z



# Create necessary directories
cd $HOME/.config/ && mkdir nvim fish && cd
# Clone dotfiles repository
git clone https://github.com/may-uri/dotfiles.git

# Copy fish configuration file
cp -rf $HOME/dotfiles/windows_wsl/fish_windows $HOME/.config/fish/config.fish

# Copy quote.json in home directory 
cp -rf $HOME/dotfiles/windows_wsl/quote.json $HOME/

# Copy neovim configuration files 
echo "Choose an option:"
echo "1. Copy init.vim"
echo "2. Copy nvchad"

read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
  cp -rf $HOME/dotfiles/windows_wsl/init.vim $HOME/.config/nvim
  echo "init.vim copied successfully"
elif [ "$choice" == "2" ]; then
  cp -rf $HOME/dotfiles/windows_wsl/nvchad/* $HOME/.config/nvim
  echo "nvchad files copied successfully"
else
  echo "Invalid choice"
fi

# Make xclip and xsel in Git Bash or WSL read and write to the Microsoft Windows clipboard 
mkdir ~/bin && cd ~/bin
git clone https://github.com/Konfekt/win-bash-xclip-xsel

# Check if WSLENV is defined
if [ -n "${WSLENV+x}" ]; then
  # Export PATH with $HOME/bin/win-bash-xclip-xsel appended
  export PATH="${PATH:+$PATH:}$HOME/bin/win-bash-xclip-xsel"
fi
