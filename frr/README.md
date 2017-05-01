# Free Range Routing

## Introduction

From the developers of quagga comes an integrated Linux based Router project.

The FRR project, which is brand new as of April 2017, takes the existing Quagga codebase and adds support for more routing protocols, an updated CLI and advanced functionality such as MPLS and high availability routing. The following protocls are supported:

- BGP (incl 32-bit ASNs, update groups, next-hop tracking)
- IS-IS
- LDP
- OSPF
- PIM
- RIP
- VRF

You can read more at The Register's article <a href="https://www.theregister.co.uk/2017/04/04/quagga_open_source_routing_resuscitated_as_free_range_routing/">here</a>

- Built from a standard debootstrap install of Ubuntu Xenial
- Clones the latest FRR Git repository, boots an LXC container and compiles the sources.
- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *1043 MB*
- Total compressed image size is *367 MB*

## Build

Build and install the template
```
make
make template
```

### Post-Deployment

After booting, you should:

- Edit ```/etc/frr/daemons``` and enable the daemons you require
- Restart the frr daemons with the ```systemctl restart frr``` command
- Set a password for the ```admin``` user, which is a user we create during build to provide direct cli access to FRR
```
passwd admin
```
- Log in as admin, and start using your router.

## Bugs

There appears to be a bug with the frr vtysh now that will cause vtysh to lose connections to daemons if you change the hostname via the CLI - not recommended currently.
