# DAB Templates
Nathan Gardiner <ngardiner@gmail.com>

## What is DAB?
DAB is the <a href="https://pve.proxmox.com/wiki/Debian_Appliance_Builder">Debian Appliance Builder</a> developed by the Proxmox PVE project to make the creation of Appliance Containers easier.

## How do these templates work?
Within each of the template directories is a Makefile and a dab.conf (and potentially other files).
The Makefile will trigger a Debian bootstap of a system based on the parameters in the dab.conf and with additional instructions within the Makefile

Packages downloaded will be cached in the cache directory at the root of the repository. This will make subsequent DAB builds much faster.

