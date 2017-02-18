# DAB Templates
Author: Nathan Gardiner <ngardiner@gmail.com>

## Getting Started

These templates are installed on a Proxmox PVE host. It is also possible to install the DAB package from the Proxmox repository on a non-PVE host.

### Install pre-requisites

On an existing Proxmox host:
```
apt-get install dab git
```

On a non-Proxmox Wheezy host:
```
wget http://download.proxmox.com/debian/dists/wheezy/pvetest/binary-amd64/dab_1.2-7_all.deb
dpkg -i dab_1.2-7_all.deb
```

### Clone GIT repository

```
git clone https://github.com/ngardiner82/dab_templates.git
```

## Create a Template

Customize the Makefile.global file to suit your site

Generate the template image for any of the templates
```
cd dab_templates/jessie_minimal/
make
```

Move the template to the Proxmox container templates directory
```
mv debian-8.0-minimal_8.5-1_amd64.tar.gz /var/lib/vz/template/cache/
```

Clean up the build data
```
make clean
```

## What is DAB?
DAB is the <a href="https://pve.proxmox.com/wiki/Debian_Appliance_Builder">Debian Appliance Builder</a> developed by the <a href="http://www.proxmox.com">Proxmox PVE</a> project to make the creation of Appliance Containers easier.

The purpose of these templates are to add some template-time customizations to the Ubuntu templates so that they can be used as a base to automate the deployment of horizonally-scalable containers for data centre pod deployments on Proxmox VE.

Whilst the Turnkey Linux templates included with Proxmox VE are broad and useful, they contain a lot of generalised bloat which is intended to make management easier, but which does not scale well over a large deployment plane, where better efficiencies can be found with centralised rather than per-container management.

## How do these templates work?
Within each of the template directories is a Makefile and a dab.conf (and potentially other files).
The Makefile will trigger a Debian bootstap of a system based on the parameters in the dab.conf and with additional instructions within the Makefile to install packages, copy files and run commands within the template root.

The Makefile.global file at the root of the repository contails global configuration routines that can be used to perform customization such as adding an rsyslog-relp 

For managability purposes, all of the images created are x86_64/amd64 images. It is possible to target the i386 architecture by changing the Architecture option in the respective dab.conf.

## Customizations
In addition to the installation of packages and configuration files, the Makefile.global file in the root of the repository is used to define some common customizations such as pre-seeding an SSH public key for the root user to allow ansible to perform additional post-deployment customization.

## Package Cache
Packages downloaded will be cached in the cache directory at the root of the repository. This will make subsequent DAB builds much faster.

## Templates
| *Template*      | *Distro*      | *Description*                               |
|-----------------|---------------|---------------------------------------------|
| ansible         | Ubuntu Xenial | Ansible automation platform                 |
| homeassistant   | Ubuntu Xenial | Home Automation System                      |
| jessie_minimal  | Debian Jessie | Minimal Debian Jessie Installation          |
| jessie_standard | Debian Jessie | Standard Debian Jessie Installation         |
| nginx_rproxy    | Ubuntu Xenial | nginx Reverse Proxy (for use as a DMZ host) |
