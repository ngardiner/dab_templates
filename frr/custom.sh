#!/bin/bash

# Create FRR user/group
groupadd -g 92 frr
groupadd -r -g 85 frrvty
adduser --system --ingroup frr --home /var/run/frr/ --gecos "FRR suite" --shell /sbin/nologin frr
usermod -a -G frrvty frr

# Build sources
cd /usr/src/frr
./bootstrap.sh
./configure \
    --prefix=/usr \
    --enable-exampledir=/usr/share/doc/frr/examples/ \
    --localstatedir=/var/run/frr \
    --sbindir=/usr/lib/frr \
    --sysconfdir=/etc/frr \
    --enable-pimd \
    --enable-watchfrr \
    --enable-ospfclient=yes \
    --enable-ospfapi=yes \
    --enable-multipath=64 \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-rtadv \
    --enable-tcp-zebra \
    --enable-fpm

# Make the binaries
make
make check
make install

# Create empty FRR configuration files
install -m 755 -o frr -g frr -d /var/log/frr
install -m 775 -o frr -g frrvty -d /etc/frr
install -m 640 -o frr -g frr /dev/null /etc/frr/zebra.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/bgpd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ospfd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ospf6d.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/isisd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ripd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ripngd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/pimd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ldpd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/nhrpd.conf    
install -m 640 -o frr -g frrvty /dev/null /etc/frr/vtysh.conf

# Uncomment the next line to enable packet forwarding for IPv4
#net.ipv4.ip_forward=1

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1

# Enable MPLS
cat << EOFA >> /etc/sysctl.conf
# Enable MPLS Label processing on all interfaces
net.mpls.conf.eth0.input=1
net.mpls.conf.eth1.input=1
net.mpls.conf.eth2.input=1
net.mpls.platform_labels=100000
EOFA

# Install and enable the systemd files which control the frr services
install -m 644 tools/frr.service /etc/systemd/system/frr.service  
install -m 644 cumulus/etc/default/frr /etc/default/frr  
install -m 644 cumulus/etc/frr/daemons /etc/frr/daemons  
install -m 644 cumulus/etc/frr/debian.conf /etc/frr/debian.conf  
install -m 644 cumulus/etc/frr/Frr.conf /etc/frr/Frr.conf  
install -m 644 -o frr -g frr cumulus/etc/frr/vtysh.conf /etc/frr/vtysh.conf

# Enable the systemd service configuration
cat <<EOFB > /etc/systemd/system/frr.service
[Unit]
Description=Cumulus Linux FRR
After=syslog.target networking.service

[Service]
Nice=-5
EnvironmentFile=/etc/default/frr
Type=forking
NotifyAccess=all
StartLimitInterval=3m
StartLimitBurst=3
TimeoutSec=1m
WatchdogSec=60s
RestartSec=5
Restart=on-abnormal
LimitNOFILE=1024
ExecStart=/usr/lib/frr/frr start
ExecStop=/usr/lib/frr/frr stop
ExecReload=/usr/lib/frr/frr-reload.py --reload /etc/frr/frr.conf

[Install]
WantedBy=network-online.target
EOFB

cat <<EOFC > /etc/frr/daemons
zebra=yes
bgpd=no
ospfd=no
ospf6d=no
ripd=no
ripngd=no
isisd=no
EOFC

# Remove some of the packages added earlier for compilation
# This will reduce the overall size of the image
dpkg -r autoconf automake bison flex
apt-get -y autoremove

exit 0
