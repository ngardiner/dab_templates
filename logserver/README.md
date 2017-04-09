# Logserver

## Template Details

- Installs rsyslogd with the following listeners configured to recieve logs from clients
   - UDP 514 (Classic UDP Syslog)
   - TCP 514 (TCP Syslog)
   - TCP 20514 (RELP - Reliable Log Protocol)

- Includes Java 8 + Logstash for integration with ELK stack
   - Note: Logstash does not need to be used to integrate with Elasticsearch. Check the integration section below for more information

- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *588 MB*
- Total compressed image size is *193 MB*

### Usage

To create the template archive:

```make```

#### Make Options

By default, the template will build as a standalone Log Server with listeners for standard UDP/TCP syslog and RELP reception. To enable other functionality, you can use the following options:

- LSIP: Configures
- RSIP: Configures

To copy the template to the Proxmox VE Templates Directory:

```make template```

To clean and return the template directory to original state

```make clean```

## Customization and Integration

### Integration with devices/clients

Nothing additional is required to integrate with your devices. Just point them to UDP/514 or TCP/514 for classic Syslog clients, or use RELP on port 20514 for a RELP-capable client

### Integration with Elasticsearch/ELK

