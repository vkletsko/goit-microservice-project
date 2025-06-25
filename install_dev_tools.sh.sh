#!/bin/bash
set -e

# Check if a command is available
is_installed() {
    command -v "$1" &> /dev/null
}

# Identify the Linux distribution
get_distribution() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="$ID"
    else
        echo "Error: Unable to determine the OS."
        exit 1
    fi
}

# Install required packages based on OS
install_dependencies() {
    case "$OS" in
        ubuntu|debian|linuxmint)
            sudo apt-get update
            is_installed docker || sudo apt-get install -y docker.io
            is_installed docker-compose || sudo apt-get install -y docker-compose
            is_installed python3 || sudo apt-get install -y python3
            is_installed pip3 || sudo apt-get install -y python3-pip
            ;;
        centos|rhel)
            sudo yum -y install yum-utils
            is_installed docker || sudo yum -y install docker
            is_installed docker-compose || sudo yum -y install docker-compose
            is_installed python3 || sudo yum -y install python3
            is_installed pip3 || sudo yum -y install python3-pip
            ;;
        fedora)
            sudo dnf -y install dnf-plugins-core
            is_installed docker || sudo dnf -y install docker
            is_installed docker-compose || sudo dnf -y install docker-compose
            is_installed python3 || sudo dnf -y install python3
            is_installed pip3 || sudo dnf -y install python3-pip
            ;;
        arch|manjaro)
            sudo pacman -Sy --noconfirm
            is_installed docker || sudo pacman -S --noconfirm docker
            is_installed docker-compose || sudo pacman -S --noconfirm docker-compose
            is_installed python || sudo pacman -S --noconfirm python
            is_installed pip || sudo pacman -S --noconfirm python-pip
            ;;
        opensuse*|suse*)
            sudo zypper refresh
            is_installed docker || sudo zypper install -y docker
            is_installed docker-compose || sudo zypper install -y docker-compose
            is_installed python3 || sudo zypper install -y python3
            is_installed pip3 || sudo zypper install -y python3-pip
            ;;
        *)
            echo "Error: OS $OS not supported."
            exit 1
            ;;
    esac
}

# Install Django if it's missing
ensure_django() {
    if ! python3 -m django --version &> /dev/null; then
        echo "Django not found. Installing..."
        pip3 install --user django
    else
        echo "Django is already installed."
    fi
}

# Main function to orchestrate the installation
main() {
    get_distribution
    echo "OS detected: $OS"
    install_dependencies
    ensure_django
    echo "✅ Done! All necessary packages are installed."
}

main
