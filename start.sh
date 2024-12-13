#!/bin/bash

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Start Tailscaled
sudo tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 &

# Start Tailscale
sudo tailscale up --ssh --auth-key=${TAILSCALE_AUTHKEY} --hostname=${TAILSCALE_HOSTNAME} --advertise-exit-node ${TAILSCALE_ADDITIONAL_ARGS} || sudo tailscale up --ssh --auth-key=${TAILSCALE_AUTHKEY} --hostname=render-vpn --advertise-exit-node ${TAILSCALE_ADDITIONAL_ARGS}

# Enable SSH
# sudo tailscale up --ssh

# Start a simple HTTP server on port 80 for health check
# The server listens on port 80 and responds with a 200 OK to /health
python3 -m http.server 80 &

# Keep the container running
exec sleep infinity
