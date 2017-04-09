# Zoneminder

## Template details

The Zoneminder platform allows centralised management of IP Cameras

- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *844 MB*
- Total compressed image size is *266 MB*

### Dependancies
   * MariaDB - The zoneminder system relies on a MariaDB database which must be deployed separately

## Usage

To create the template archive:

```make```

To copy the template to the Proxmox VE Templates Directory:

```make template```

To clean and return the template directory to original state

```make clean```

## Development Topics

### Testing Results
