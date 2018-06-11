# HAProxy

<a href="http://www.haproxy.org">HAProxy</a> is a high availability solution for load balancing services. 

This template provides a bootstrapped HAProxy system with the following pre-configured features:

- Builds a HAProxy Server with Certbot for SSL Certificate management
  - Uses the excellent <a href="https://github.com/janeczku/haproxy-acme-validation-plugin">HAProxy ACME Validation Plugin</a> by <a href="https://github.com/janeczku">janeczku</a> to provide zero-downtime Letsencrypt SSL validation and renewal.
  - Works out-of-the-box with a self-signed SSL certificate.
- HAProxy server will provide HTTP and HTTPS, with HTTP redirecting to HTTPS
- HAProxy server will serve a static web page for status.check.localhost which can be used to check the HAProxy status from other platforms such as Amazon Route 53.
- Adds any customizations such as root login enabled or SSH keys from ../Makefile.global
- Total uncompressed image size is *692 MB*
- Total compressed image size is *220 MB*
