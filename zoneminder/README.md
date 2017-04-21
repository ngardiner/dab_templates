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

### Post-Installation

These instructions assume that you have used the template mariadb server for the mysql server, as this template will automatically create the required DB schema.

   * On the MariaDB server, execute the following command:

```mysql -e "GRANT ALL on zm.* to zmuser@'<ZM Server IP>' identified by '<password>'"```

   * On the ZoneMinder server, edit /etc/zm/zm.conf and set ZM_DB_HOST and ZM_DB_PASS

   * On the ZoneMinder server, edit /etc/php/7.0/apache2/php.ini and set timezone to your preferred timezone. Restart apache2:

```service apache2 restart```

   * Visit http://<zoneminder server>/zm. You should see the ZoneMinder UI screen.
