#!/bin/bash

# Define the VM hostnames or IP addresses
MASTER_IP="192.168.1.48"
WORKER1_IP="192.168.1.119"
WORKER2_IP="192.168.1.52"
USER="vagrant"  # Replace with the user you use to SSH (e.g., vagrant, root, etc.)
PASSWORD=""  # Leave empty initially, script will prompt for the password

# Step 1: Generate SSH key if not already present
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "No SSH key found, generating one..."
    ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
else
    echo "SSH key already exists, skipping generation."
fi

# Prompt for the SSH password (this will only ask once)
if [ -z "$PASSWORD" ]; then
    echo "Please enter the SSH password for $USER on the VMs:"
    read -s PASSWORD
fi

# Step 2: Function to copy public key using sshpass and auto-accept fingerprint
copy_ssh_key() {
    local target_ip=$1
    local user=$2
    echo "Copying SSH key to $user@$target_ip..."
    
    # Use sshpass to avoid manual password entry, and -o StrictHostKeyChecking=no to auto-accept fingerprints
    sshpass -p "$PASSWORD" ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa.pub "$user@$target_ip"
}

# Copy the SSH key to master, worker1, and worker2
copy_ssh_key $MASTER_IP $USER
copy_ssh_key $WORKER1_IP $USER
copy_ssh_key $WORKER2_IP $USER

# Step 3: Verify SSH connectivity by trying to SSH to each VM (no password required)
echo "Testing SSH connection to master..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -T $USER@$MASTER_IP "echo 'Connected to master!'"

echo "Testing SSH connection to worker1..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -T $USER@$WORKER1_IP "echo 'Connected to worker1!'"

echo "Testing SSH connection to worker2..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -T $USER@$WORKER2_IP "echo 'Connected to worker2!'"

echo "SSH key setup completed successfully!"
