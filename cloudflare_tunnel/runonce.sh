#!/bin/bash
### BEGIN INIT INFO
# Provides:           firstboot
# Required-Start:     $local_fs
# Required-Stop:
# Should-Start:      $network $portmap nfs-common  udev-mtab
# Default-Start:     S
# Default-Stop:
# Short-Description: First-boot system customization routines
# Description:       Provides first-boot system customization for
#                    Cloudflare Tunnel setup. Removes itself entirely when done.
### END INIT INFO

case "$1" in
  start)
    # Check for required environment variables
    if [ -z "$CF_API_TOKEN" ]; then
      echo "Error: CF_API_TOKEN not set. Cannot configure Cloudflare Tunnel."
      exit 1
    fi

    if [ -z "$TUNNEL_NAME" ]; then
      TUNNEL_NAME="dab-cloudflare-tunnel"
    fi

    # Perform Cloudflare tunnel creation
    mkdir -p /etc/cloudflared
    
    # Login to Cloudflare
    cloudflared login

    # Create tunnel
    cloudflared tunnel create "$TUNNEL_NAME"

    # If TUNNEL_HOSTNAME and TARGET_SERVICE_URL are provided, configure route
    if [ -n "$TUNNEL_HOSTNAME" ] && [ -n "$TARGET_SERVICE_URL" ]; then
      cloudflared tunnel route ip add "$TARGET_SERVICE_URL" "$TUNNEL_NAME"
    fi

    # Find and copy credentials
    CREDENTIALS=$(find /root/.cloudflared -name "*$TUNNEL_NAME*.json")
    if [ -n "$CREDENTIALS" ]; then
      cp "$CREDENTIALS" /etc/cloudflared/
    fi

    # Write configuration
    cat > /etc/cloudflared/config.yml << EOF
tunnel: $TUNNEL_NAME
credentials-file: /etc/cloudflared/$(basename "$CREDENTIALS")
EOF

    # Set up service to start tunnel
    cloudflared service install

    # Once the script has completed execution, delete ourselves
    update-rc.d firstboot disable
    rm "$0"
  ;;
  stop)
    echo "Not Implemented"
  ;;
  status)
    echo "Not Implemented"
  ;;
  restart|force-reload)
    echo "Not Implemented"
  ;;
  *)
    echo "Usage: /etc/init.d/$NAME {start}" >&2
    exit 1
  ;;
esac