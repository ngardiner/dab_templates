#!/bin/bash

# The following will set the necessary settings to avoid us having to manually
# acknowledge the Oracle Java 8 License Agreement

debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

