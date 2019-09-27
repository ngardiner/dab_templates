# DAB Templates
Author: Nathan Gardiner <ngardiner@gmail.com>

## Getting Started

These templates are installed on a Proxmox PVE host. It is also possible to install the DAB package from the Proxmox repository on a non-PVE host.

### Install pre-requisites

On an existing Proxmox host:
```
apt-get install dab git make
```

On a non-Proxmox Wheezy host:
```
wget http://download.proxmox.com/debian/dists/wheezy/pvetest/binary-amd64/dab_1.2-7_all.deb
dpkg -i dab_1.2-7_all.deb
```

### Clone GIT repository

```
git clone https://github.com/ngardiner/dab_templates.git
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
make template
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

The Makefile.global file at the root of the repository contains global configuration routines that can be used to perform customization such as adding an rsyslog-relp log server, customising prompts or setting authentication keys.

For managability purposes, all of the images created are x86_64/amd64 images. It is possible to target the i386 architecture by changing the Architecture option in the respective dab.conf.

### Authentication and Security
By default, images created from these templating scripts will not allow root login. This means that one of the following must be true to be able to log in remotely via SSH. Console access will allow login using the specifed password:
- You must specify one SSH public key via the Proxmox container creation process, or
- You must specify one or more SSH public keys via the Makefile.generic, or
- You must specify that root login via SSH using Password authentication is permitted, or
- You must log in via the console and manually configure another authentication mechanism

## Customizations

The primary benefit of the structure provided by this repository in managing DAB templates is that common customizations can be standardized and embedded within the template images, rather than requiring significant reconfiguration after instantiation.

### Makefile.global
In addition to the installation of packages and configuration files, the Makefile.global file in the root of the repository is used to define some common customizations such as pre-seeding an SSH public key for the root user to allow ansible to perform additional post-deployment customization.

None of the configuration within the Makefile.global file is mandatory, and commenting out lines that are not required will disable the associated customization.

### Custom and Runonce Scripts

Each template directory contains two files to aid with customization of the template build process:
- custom.sh which will execute the commands contained within the script inside of the template container environment during build
- runonce.sh which will trigger on the first boot of a host created from that template, and then remove itself.

### Package Cache
Packages downloaded will be cached in the cache directory at the root of the repository. This will make subsequent DAB builds much faster.

## Templates
| *Template*                                     | *Distro*      | *Description*                               |
|------------------------------------------------|---------------|---------------------------------------------|
| <a href="ansible/">ansible</a>                 | Ubuntu Bionic | Ansible automation platform                 |
| <a href="bionic_minimal/">bionic_minimal</a>   | Ubuntu Bionic | Minimal Ubuntu Bionic Installation          |
| <a href="bionic_standard/">bionic_standard</a> | Ubuntu Bionic | Standard Ubuntu Bionic Installation         |
| <a href="buster_minimal/">buster_minimal</a>   | Debian Buster | Minimal Debian Buster Installation          |
| <a href="buster_standard/">buster_standard</a> | Debian Buster | Standard Debian Buster Installation         |
| <a href="disco_minimal/">disco_minimal</a>     | Ubuntu Disco  | Minimal Ubuntu Disco Installation           |
| <a href="disco_standard/">disco_standard</a>   | Ubuntu Disco  | Standard Ubuntu Disco Installation          |
| <a href="frr/">frr</a>                         | Ubuntu Xenial | Free Range Routing Advanced Routing Engine  |
| <a href="haproxy/">haproxy</a>                 | Ubuntu Bionic | HAProxy                                     |
| <a href="homeassistant/">homeassistant</a>     | Ubuntu Bionic | Home Automation System                      |
| <a href="jessie_minimal/">jessie_minimal</a>   | Debian Jessie | Minimal Debian Jessie Installation          |
| <a href="jessie_standard/">jessie_standard</a> | Debian Jessie | Standard Debian Jessie Installation         |
| <a href="lms/">lms</a>                         | Ubuntu Xenial | Logitech Media Server - Whole House Audio   |
| <a href="logserver/">logserver</a>             | Ubuntu Xenial | rsyslog remote reception, logstash, webui   |
| <a href="mariadb/">mariadb</a>                 | Ubuntu Xenial | MariaDB Database Server                     |
| <a href="nginx_rproxy/">nginx_rproxy</a>       | Ubuntu Xenial | nginx Reverse Proxy (for use as a DMZ host) |
| <a href="stretch_minimal/">stretch_minimal</a>   | Debian Stretch | Minimal Debian Jessie Installation          |
| <a href="stretch_standard/">stretch_standard</a> | Debian Stretch | Standard Debian Jessie Installation         |
| <a href="vyos/">vyos</a>                       | Ubuntu Xenial | EXPERIMENTAL attempt to run vyos CLI in LXC |
| <a href="xenial_minimal/">xenial_minimal</a>   | Ubuntu Xenial | Minimal Ubuntu Xenial Installation          |
| <a href="xenial_standard/">xenial_standard</a> | Ubuntu Xenial | Standard Ubuntu Xenial Installation         |
| <a href="zoneminder/">zoneminder</a>           | Ubuntu Xenial | IP Camera Manager used for security         |
