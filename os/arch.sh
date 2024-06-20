#!/bin/bash
# ARCH
# NERD FONTS ARE RECOMMENDED
# Color definitions (optional)
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
reset='\033[0m'

# Function to display the main menu
function main_menu() {
  clear
  echo -e "${yellow}Would You like to install Additional Software: ${reset}"
  echo "---------------"
  echo "1) Yes"
  echo ""
  echo "2) No"
  echo ""
  echo "---------------"
  echo -e "${yellow}Or another option ${reset}"
  echo "---------------"
  echo ""
  echo "3) Exit"
  echo ""
  echo "---------------"
  echo ""
  echo -n "Enter your choice: "
  read choice
  case $choice in
    1) install_software ;;
    2) exit 0 ;;
    3) exit 0 ;;
    *) echo -e "${red}Invalid choice!${reset}"; sleep 3.5; main_menu ;;
  esac
}

# Function for installing Software
function install_software() {
  echo -e "${yellow}Updating Software and Repos...${reset}"
  sudo pacman -Syyu
  echo -e "${yellow}Now installing packages!${reset}"
  sudo pacman -S emacs fish eza doas pcmanfm htop zsh alacritty tmux git steam flatpak mpv unzip rust sxiv rust-analyzer neovim python3 kitty qbittorrent base-devel man-db ttf-font-awesome pyright noto-fonts-emoji hyfetch p7zip || echo -e "${red}This script only supports Arch-based Distros${reset}"; sleep 3.5; exit 1
  echo -e "${green}Done installing software!${reset}"
  echo -e "${yellow}Now cloning dotfiles${reset}"
  git clone https://github.com/redkittty/dotfiles.git || echo -e "${red}GIT CLONE FAILED${reset}"
  echo -r "${green}Cloning complete${reset}"
  echo -e "${yellow}Now installing AUR packages!${reset}"
  git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si && cd ..
  git clone https://aur.archlinux.org/brave-bin.git && cd brave-bin && makepkg -si && cd ..
  git clone https://aur.archlinux.org/nerd-fonts-git.git && cd nerd-fonts-git && makepkg -si && cd ..
  git clone https://aur.archlinux.org/rofi-wifi-menu-git.git && cd rofi-wifi-menu-git && makepkg -si && cd ..
  git clone https://aur.archlinux.org/shell-color-scripts.git && cd shell-color-scripts && makepkg -si && cd ..
  git clone https://github.com/redkittty/st-envixty.git && cd st-envixty && makepkg -si && cd ,,
  echo -e "${green}Done installing AUR Packages!${reset}"
  echo -e "${yellow}Now tweaking the system${reset}"

  # Pacman Setup
  # Chaotic AUR
  pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  mkdir $HOME/etc && sudo mv /etc/pacman.conf $HOME/etc/pacman.conf.bak && sudo cp dotfiles/root/etc/pacman.conf /etc && cd ..


  # DOOM EMACS Setup
  git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs && $HOME/.config/emacs/bin/doom install

  # Fish Setup
  chsh -s /bin/zsh

  # Plugin Setup
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/zsh/plugins/zsh-syntax-highlighting
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $HOME/.config/zsh/plugins/zsh-you-should-use
  git clone https://github.com/zsh-users/zsh-history-substring-search.git $HOME/.config/zsh/plugins/zsh-history-substring-search

  echo -e "${green}Tweaks done, Now tweak based on WM!${reset}"; sleep 3.5; chmod+X archwm.sh; source archwm.sh
}

# Call the main menu only once
main_menu
