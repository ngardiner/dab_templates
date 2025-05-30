# Cloudflare Tunnel Template

## Overview
This template provides an automated setup for a Cloudflare Tunnel, which allows secure remote access to services without exposing public IP addresses.

## Configuration
Configure the following variables in `vars.sh`:

- `CF_ACCOUNT_ID`: Your Cloudflare Account ID
- `CF_API_TOKEN`: Cloudflare API Token with tunnel creation permissions
- `TUNNEL_NAME`: Name of the Cloudflare Tunnel (default: dab-cloudflare-tunnel)
- `TUNNEL_HOSTNAME`: Hostname to be used for the tunnel
- `TARGET_SERVICE_URL`: URL of the service to be exposed

## Requirements
- Cloudflare Account
- Valid API Token with tunnel creation permissions

## Notes
- Tunnel is created and managed using the official cloudflared package
- Credentials are automatically generated and managed