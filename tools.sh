#!/bin/bash
set -euo pipefail

# 1. Actualizar sistema
echo "🔄 Actualizando sistema..."
sudo pacman -Syu --noconfirm

# 2. Lista de paquetes (sin duplicados)
packages=(
  net-tools curl wget git gzip thunar-volman gvfs unzip udisks2
  certipy gvfs-mtp gvfs-afc gvfs-gphoto2 ntfs-3g p7zip zip tree jq tmux
  simplescreenrecorder ufw nmap openvpn whois traceroute socat seclists
  gnu-netcat cmake extra-cmake-modules base-devel nodejs npm
  jdk8-openjdk jdk11-openjdk jdk17-openjdk go htop neofetch openssh docker
  netexec metasploit john hashcat sqlmap ffuf responder aircrack-ng hydra
  samba binwalk foremost crackmapexec davtest kerbrute gdb glibc debuginfod
  xorg-xinput bloodhound ruby-csv ruby-syslog ruby-benchmark python
  python-pip python-pipx python-pwntools amass dnsutils pavucontrol
  pipewire-pulse pipewire-audio pipewire-alsa wireplumber pipewire flameshot
  cadaver vlc chisel wireshark-qt dbeaver dnsenum enum4linux-ng ghidra
  gobuster tcpdump freerdp hashid google-chrome openldap ruby-resolv-replace
  ruby-getoptlong whatweb rlwrap smbmap moreutils libfaketime ntp
  nvidia nvidia-utils nvidia-settings opencl-nvidia yay code rustscan
  perl-image-exiftool proxychains-ng spotify dpkg locate
)

# 3. Detectar paquetes faltantes
declare -a to_install=()
for pkg in "${packages[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    to_install+=("$pkg")
  else
    echo "✔ $pkg ya está instalado."
  fi
done

# 4. Instalar paquetes faltantes en bloque
if [ "${#to_install[@]}" -gt 0 ]; then
  echo "📦 Instalando paquetes faltantes: ${to_install[*]}"
  sudo pacman -S --noconfirm "${to_install[@]}"
else
  echo "✅ Todos los paquetes ya estaban instalados."
fi

# 5. Docker Compose
if ! command -v docker-compose &>/dev/null; then
  echo "🐳 Instalando Docker Compose..."
  sudo curl -sSL \
    "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "✔ docker-compose ya está disponible."
fi

# 6. Wireshark (QT) y permisos
if ! pacman -Qi wireshark-qt &>/dev/null; then
  echo "📡 Instalando wireshark-qt..."
  sudo pacman -S --noconfirm wireshark-qt
fi
echo "🔧 Configurando permisos de wireshark para $(whoami)..."
sudo usermod -aG wireshark "$(whoami)" || true
newgrp wireshark &>/dev/null || true

# 7. Gems de Ruby
declare -a gems=(zsteg evil-winrm)
for gempkg in "${gems[@]}"; do
  if ! gem list -i "$gempkg" &>/dev/null; then
    echo "💎 Instalando gem $gempkg..."
    sudo gem install "$gempkg"
  else
    echo "✔ gem $gempkg ya está instalada."
  fi
done

# 8. Herramientas Python con pipx
declare -a pipxtools=(oletools)
for tool in "${pipxtools[@]}"; do
  if ! pipx list | grep -q "$tool"; then
    echo "🐍 Instalando pipx package $tool..."
    pipx install "$tool"
  else
    echo "✔ pipx:$tool ya instalado."
  fi
done

# 9. Google Chrome (AUR)
if ! command -v google-chrome-stable &>/dev/null; then
  echo "🌐 Instalando google-chrome (AUR)..."
  yay -S --noconfirm google-chrome
else
  echo "✔ google-chrome ya está instalado."
fi

echo "🎉 ¡Instalación completada!"
