# Home Assistant

- Creates a Ubuntu Xenial template with Python 3 and Home Assistant home automation system
- NOTE: Currently, this image will require some internet ac
- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *709 MB*
- Total compressed image size is *259 MB*

## How to use

- Deploy the Home Assistant template as a Linux Container and wait for it to boot
- Point your web browser to http://[container ip]:8123/ to view the Web Interface

## Development Notes

- Home Assistant will try to install all unmet dependancies at startup
  - This is an issue for isolated hosts as well as for Python modules which require compilation
  - Every new release will need some work to identify dependancy versions that have changed and new dependancies are added to the template
  - We first try to meet the dependancies with inbuilt Ubuntu packages, followed by 
