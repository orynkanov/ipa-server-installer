#!/bin/bash

IPETH0=$(ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d '/' -f1)
echo "$IPETH0 $(hostname -f) $(hostname -s)" >> /etc/hosts

ipa-server-install -p '1q2w#E$R' -a '1q2w#E$R' -n 'yo.virt' -r 'YO.VIRT' --hostname="$(hostname -f)" --setup-dns --mkhomedir --no-dns-sshfp --forwarder=8.8.8.8 --forwarder=8.8.4.4

#   Basic options:
#     -p DM_PASSWORD, --ds-password=DM_PASSWORD
#                         Directory Manager password
#     -a ADMIN_PASSWORD, --admin-password=ADMIN_PASSWORD
#                         admin user kerberos password
#     -n DOMAIN_NAME, --domain=DOMAIN_NAME
#                         primary DNS domain of the IPA deployment (not
#                         necessarily related to the current hostname)
#     -r REALM_NAME, --realm=REALM_NAME
#                         Kerberos realm name of the IPA deployment (typically
#                         an upper-cased name of the primary DNS domain)
#     --hostname=HOST_NAME
#                         fully qualified name of this host


#   Server options:
#     --setup-adtrust     configure AD trust capability
#     --setup-kra         configure a dogtag KRA
#     --setup-dns         configure bind with our zone



#   Client options:
#     --mkhomedir         create home directories for users on their first login
#     --no-dns-sshfp      do not automatically create DNS SSHFP records



#   DNS options:
#     --forwarder=FORWARDERS
#                         Add a DNS forwarder. This option can be used multiple
