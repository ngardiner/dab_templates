# Logserver

- Installs rsyslogd with the following listeners to recieve logs from clients
   - UDP 514 (Classic UDP Syslog)
   - TCP 514 (TCP Syslog)
   - TCP 20514 (RELP - Reliable Log Protocol)

- Includes Logstash for integration with ELK stack

- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *588 MB*
- Total compressed image size is *193 MB*
