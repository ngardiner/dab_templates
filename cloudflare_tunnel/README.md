# Cloudflare Tunnel Template

## Overview
This template provides an automated setup for a Cloudflare Tunnel, which allows secure remote access to services without exposing public IP addresses.

## Configuration
Configure the following environment variables in your deployment:

- `CF_ACCOUNT_ID`: Your Cloudflare Account ID
- `CF_API_TOKEN`: Cloudflare API Token with necessary permissions
- `TUNNEL_NAME`: Name of the Cloudflare Tunnel
- `TUNNEL_HOSTNAME`: Hostname to be used for the tunnel
- `TARGET_SERVICE_URL`: URL of the service to be exposed (e.g., `http://local-service:8080`)

## Requirements
- Docker
- Cloudflare Account
- Valid API Token with tunnel creation permissions

## Ports
No external ports are exposed as the tunnel is managed by Cloudflare.