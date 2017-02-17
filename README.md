# DAB Templates
Nathan Gardiner <ngardiner@gmail.com>

## What is DAB?
DAB is the <a href="https://pve.proxmox.com/wiki/Debian_Appliance_Builder">Debian Appliance Builder</a> developed by the Proxmox PVE project to make the creation of Appliance Containers easier.

## How do these templates work?
Within each of the template directories is a Makefile and a dab.conf (and potentially other files).
The Makefile will trigger a Debian bootstap of a system based on the parameters in the dab.conf and with additional instructions within the Makefile to install packages, copy files and run commands within the template root.

## Customizations
In addition to the installation of packages and configuration files, the Makefile.global file in the root of the repository is used to define some common customizations such as pre-seeding an SSH public key for the root user to allow ansible to perform additional post-deployment customization.

## Package Cache
Packages downloaded will be cached in the cache directory at the root of the repository. This will make subsequent DAB builds much faster.

