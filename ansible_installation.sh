#!/bin/bash
 
# Exit on error
set -e
 
echo "Checking for Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Installing Python3..."
    sudo apt update
    sudo apt install -y python3 python3-pip
else
    echo "Python3 is already installed: $(python3 --version)"
fi
 
echo "Checking for Ansible installation..."
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Proceeding with installation..."
    echo "Updating package list..."
    sudo apt update
    echo "Installing dependencies..."
    sudo apt install -y software-properties-common
    echo "Adding Ansible PPA repository..."
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    echo "Installing Ansible..."
    sudo apt install -y ansible
    echo "Ansible installation complete!"
else
    echo "Ansible is already installed: $(ansible --version)"
fi