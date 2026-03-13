#!/bin/bash
# Auto-setup SSH access to VPN server on codespace creation

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copy keys from repo to ~/.ssh
cp /workspaces/vpn2/.ssh/server_vpn2 ~/.ssh/server_vpn2
cp /workspaces/vpn2/.ssh/server_vpn2.pub ~/.ssh/server_vpn2.pub
chmod 600 ~/.ssh/server_vpn2
chmod 644 ~/.ssh/server_vpn2.pub

# Write SSH config (append if not already present)
if ! grep -q "Host server" ~/.ssh/config 2>/dev/null; then
cat >> ~/.ssh/config << 'EOF'

Host server
    HostName 151.241.216.208
    User root
    IdentityFile ~/.ssh/server_vpn2
    StrictHostKeyChecking no

Host vpn2
    HostName 151.241.216.208
    User vpn2
    IdentityFile ~/.ssh/server_vpn2
    StrictHostKeyChecking no
EOF
fi

chmod 600 ~/.ssh/config 2>/dev/null || true
echo "SSH setup complete. Connect with: ssh server"
