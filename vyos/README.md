# Testing VyOS in LXC Container

Experimental - Experimenting if we can compile and use vyos tools and CLI in a container

Current Status: Not operational (first priority is to compile all VyOS code as part of the template creation script, then to implement functionality)

## Introuduction

This is a very ambitious attempt to create a router-oriented LXC template, as searches have shown that no such thing exists. 

It is very unlikely that we will ever reach VyOS level functionality - at the very least due to missing kernel functions and features that LXC cannot provide, but being able to use the vbash shell to configure BGP/OSPF/interfaces/routing would be very useful as a template.

## Development Notes

/usr/local/bin/vbash - vyatta bash
biosdevname - installs in /sbin
busybox - issue
vyatta-cfg - issue, unfixed
vyatta-cfg-quagga - works
vyatta-zone - works, installs perl modules (need to include perl)

To fix busybox issue:
- Fork busybox
- Edit include/libbb.h
Add:
#include <sys/resource.h>
(after mman.h, before socket.h>
