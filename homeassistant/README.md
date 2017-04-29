# Home Assistant

Home Assistant is a home automation platform written in Python. It provides the ability to interface with many different components from different vendors, providing schedule and event based automation control.

## Template
- Creates a Ubuntu Xenial template with Python 3 and Home Assistant home automation system
- NOTE: Currently, this image will require internet access for full functionality due to the software installing some dependancies at runtime.
- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *906 MB*
- Total compressed image size is *321 MB*

### Prerequisites
- Requires the python3-pip and libmysqlclient-dev packages to be installed on the (dab) system used to create the template.

### How to use

- Deploy the Home Assistant template as a Linux Container and wait for it to boot.
- Point your web browser to http://[container ip]:8123/ to view the Web Interface.
- Configure Home Assistant via YAML configuration - config file is /home/hass/.homeassistant/configuration.yaml

### Updating HomeAssistant

Two options exist for updating homeassistant using this template:

- Within the container itself:

```pip3 install --upgrade homeassistant```

- Recreating the container from the most recent release

## Development Notes

- Home Assistant will try to install all unmet dependancies at startup
  - This is an issue for isolated hosts as well as for Python modules which require compilation
  - Every new release will need some work to identify dependancy versions that have changed and new dependancies are added to the template
  - We first try to meet the dependancies with inbuilt Ubuntu packages, followed by the Python packages themselves. All of the core components are able to install, however some add-on functionality may require further packages.
  - It is anticipated that this situation will improve with later templates as the platform matures.
