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

    # Create self-signed fallback ssl key
    mkdir -p /etc/ssl/haproxy
    mkdir -p /etc/ssl/haproxy/pem
    echo "AU" >> /etc/ssl/haproxy/haproxy.ans
    echo "VIC" >> /etc/ssl/haproxy/haproxy.ans
    echo "Melbourne" >> /etc/ssl/haproxy/haproxy.ans
    echo "Load Balancer" >> /etc/ssl/haproxy/haproxy.ans
    echo "Load Balancer" >> /etc/ssl/haproxy/haproxy.ans
    echo "*.localhost" >> /etc/ssl/haproxy/haproxy.ans
    echo "loadbalancer@localhost" >> /etc/ssl/haproxy/haproxy.ans
    echo >> /etc/ssl/haproxy/haproxy.ans
    echo >> /etc/ssl/haproxy/haproxy.ans
    openssl genrsa -out /etc/ssl/haproxy/haproxy.key 2048
    cat /etc/ssl/haproxy/haproxy.ans |  openssl req -new -key /etc/ssl/haproxy/haproxy.key -out /etc/ssl/haproxy/haproxy.csr
    openssl x509 -req -days 3650 -in /etc/ssl/haproxy/haproxy.csr \
                    -signkey /etc/ssl/haproxy/haproxy.key \
                    -out /etc/ssl/haproxy/haproxy.crt

    # Create integrated PEM file
    cat /etc/ssl/haproxy/haproxy.crt /etc/ssl/haproxy/haproxy.key > /etc/ssl/haproxy/pem/haproxy.pem

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
