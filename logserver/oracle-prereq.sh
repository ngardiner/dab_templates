#!/bin/bash

# The following will set the necessary settings to avoid us having to manually
# acknowledge the Oracle Java 8 License Agreement

# Pause for a few seconds to ensure that there's no conflict with the dpkg
# database, as background apt commands will lock it out and cause the script
# to fail
sleep 20

# Pre-seed the configuration for the license acceptance to ensure that the
# installation does not pause
echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# We need to do a bit of trickery to download the package locally, as the
# LXC template container will not have internet access during build.
echo "127.0.0.1 download.oracle.com" >> /etc/hosts

# Stop the range header from working, as this causes issues
mkdir -p /var/www/html/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441
echo "Header set Accept-Ranges none" > /var/www/html/otn-pub/java/jdk/8u121-b13/.htaccess
echo "RequestHeader unset Range" >> /var/www/html/otn-pub/java/jdk/8u121-b13/.htaccess
chmod 655 /var/www/html/otn-pub/java/jdk/8u121-b13/.htaccess

# Set global pointer to the correct version of Java JRE
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment
