#!/bin/bash
### BEGIN INIT INFO
# Provides:          firstboot
# Required-Start:    $local_fs
# Required-Stop:
# Should-Start:      $network $portmap nfs-common  udev-mtab
# Default-Start:     S
# Default-Stop:
# Short-Description: First-boot system customization routines
# Description:       Provides first-boot system customization for
#                    proxmox container templates.
#                    Removes itself entirely when done.
### END INIT INFO

case "$1" in
  start)

    # Put first boot routines here

    # Create HASS user
    useradd -m hass

    # Upgrade pip
    pip3 install --upgrade pip

    # Install netdiscover
    pip3 install netdisco

    # Enable the Home Assistant service
    /bin/systemctl enable home-assistant@hass

    # Start the Home Assistant service (need to spawn or it will hold up this script)
    /bin/systemctl start home-assistant@hass &

    # Once the script has completed execution, delete ourselves
    update-rc.d firstboot disable
    rm $0
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

