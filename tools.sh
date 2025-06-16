#!/bin/bash

# 1. Actualizar sistema
echo "🔄 Actualizando sistema..."
sudo pacman -Syu --noconfirm

# List of packages to install
packages=(
  net-tools
  curl
  wget
  wget
  git
  gzip
  thunar-volman
  gvfs
  unzip
  udisks2
  certipy
  gvfs-mtp
  gvfs-afc
  gvfs-gphoto2
  ntfs-3g
  p7zip
  zip
  tree
  jq
  tmux
  simplescreenrecorder
  ufw
  nmap
  openvpn
  whois
  traceroute
  socat
  seclists
  gnu-netcat
  cmake
  extra-cmake-modules
  base-devel
  nodejs
  npm
  jdk8-openjdk
  jdk17-openjdk
  go
  htop
  neofetch
  openssh
  docker
  netexec
  metasploit
  john
  hashcat
  sqlmap
  ffuf
  responder
  aircrack-ng
  hydra
  samba
  binwalk
  foremost
  crackmapexec
  davtest
  kerbrute
  gdb
  glibc
  debuginfod
  nmap
  xorg-xinput
  bloodhound
  ruby-csv
  ruby-syslog
  jdk17-openjdk
  jdk11-openjdk
  jdk8-openjdk
  ruby-benchmark
  bbot
  python
  python-pip
  python-pipx
  python-pwntools
  amass
  dnsutils
  pavucontrol
  pipewire-pulse
  pipewire-audio
  pipewire-alsa
  pipewire-pulse
  wireplumber   
  pipewire
  flameshot
  cadaver
  vlc
  chisel
  wireshark-qt
  davtest
  dbeaver
  dnsenum
  enum4linux-ng
  ghidra
  gobuster
  tcpdump
  freerdp
  hashid
  ldapdomaindump
  openldap
  ruby-resolv-replace
  ruby-getoptlong
  whatweb
  rlwrap
  smbmap
  moreutils
  libfaketime
  ntp
  nvidia-settings
  nvidia
  nvidia-utils
  opencl-nvidia
  yay
  code
  rustscan
  perl-image-exiftool
  proxychains-ng
  spotify
  dpkg

)

# Install all packages with --noconfirm flag
echo "Installing packages..."
for pkg in "${packages[@]}"; do
  sudo pacman -S "$pkg" --noconfirm
done

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Wireshark
sudo pacman -S wireshark-qt
sudo usermod -aG wireshark $(whoami)
newgrp wireshark


gem install zsteg
pipx install oletools
sudo gem install csv syslog benchmark
gem install evil-winrm
yay -S google-chrome
echo "Installation complete."
