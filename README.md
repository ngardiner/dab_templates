# DAB Templates
Author: Nathan Gardiner <ngardiner@gmail.com>

## What is DAB?
DAB is the <a href="https://pve.proxmox.com/wiki/Debian_Appliance_Builder">Debian Appliance Builder</a> developed by the Proxmox PVE project to make the creation of Appliance Containers easier.

The purpose of these templates are to add some template-time customizations to the Ubuntu templates so that they can be used as a base to automate the deployment of horizonally-scalable containers for data centre pod deployments on Proxmox VE.

Whilst the Turnkey Linux templates included with Proxmox VE are broad and useful, they contain a lot of generalised bloat which is intended to make management easier, but which does not scale well over a large deployment plane, where better efficiencies can be found with centralised rather than per-container management.

## How do these templates work?
Within each of the template directories is a Makefile and a dab.conf (and potentially other files).
The Makefile will trigger a Debian bootstap of a system based on the parameters in the dab.conf and with additional instructions within the Makefile to install packages, copy files and run commands within the template root.

The Makefile.global file at the root of the repository contails global configuration routines that can be used to perform customization such as adding an rsyslog-relp 

## Customizations
In addition to the installation of packages and configuration files, the Makefile.global file in the root of the repository is used to define some common customizations such as pre-seeding an SSH public key for the root user to allow ansible to perform additional post-deployment customization.

## Package Cache
Packages downloaded will be cached in the cache directory at the root of the repository. This will make subsequent DAB builds much faster.

## Templates
| *Template*    | Distro        | Description                 |
|---------------|---------------|-----------------------------|
| ansible       | Ubuntu Xenial | Ansible automation platform |
| homeassistant | Ubuntu Xenial | Home Automation System      |
| nginx_rproxy  | Ubuntu Xenial | nginx Reverse Proxy         |
