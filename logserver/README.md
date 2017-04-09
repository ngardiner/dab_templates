# Logserver

## Template Details

- Installs rsyslogd with the following listeners configured to recieve logs from clients
   - UDP 514 (Classic UDP Syslog)
   - TCP 514 (TCP Syslog)
   - TCP 20514 (RELP - Reliable Log Protocol)

- Includes a web interface (loganalyzer) for viewing logs from your web browser.

- Includes Java 8 + Logstash for integration with ELK stack
   - Note: Logstash does not need to be used to integrate with Elasticsearch. Check the integration section below for more information
   - See the elk template included in this repository for a template providing elasticsearch and kibana to be used alongside this template for full ELK functionality.

- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *1398 MB*
- Total compressed image size is *652 MB*

### Usage

To create the template archive:

```make```

#### Make Options

By default, the template will build as a standalone Log Server with listeners for standard UDP/TCP syslog and RELP reception. To enable other functionality, you can use the following options:

- LSIP: Configures a Logstash connection to elasticsearch
- RSIP: Configures a native rsyslog connection to elasticsearch

To copy the template to the Proxmox VE Templates Directory:

```make template```

To clean and return the template directory to original state

```make clean```

### After Install

After install, begin sending syslog from your clients to the logserver. You can do this via:

Stadnard Systlog
```test```

rsyslog
```test```

You can view your logs by using the loganalyzer GUI at http://[container IP]/loganalyzer/

## Customization and Integration

### Integration with devices/clients

Nothing additional is required to integrate with your devices. Just point them to UDP/514 or TCP/514 for classic Syslog clients, or use RELP on port 20514 for a RELP-capable client.

### Integration with template containers

The Makefile.global in the root directory of this repository provides a variable RELP_TARGETS which allows one or more RELP capable log servers such as this log server template to send all logs to. Configuring this variable will ensure that all templates created will begin logging to this logserver template out of the box.

### Integration with Elasticsearch/ELK

Elasticsearch, logstash and kibana provide an advanced platform for searching, analysis and visualization of log data.

This logserver template is designed to be able to be connected into an elasticsearch infrastructure for streaming of log data. To do this, you may use the make options listed under the Usage section, or to deploy the configuration you would like via an orchestration platform such as Ansible.
