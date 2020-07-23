#!/bin/bash

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

#start check
if [[ ! -f $SCRIPTDIR/vars.cfg ]]; then
    echo "File $SCRIPTDIR/vars.cfg not found"
    exit 1
fi
#finish check

# shellcheck source=/dev/null
source "$SCRIPTDIR"/vars.cfg

IPETH0=$(ip addr show eth0 | grep 'inet ' | awk '{print $2}' | awk -F/ '{print $1}')
echo "$IPETH0 $(hostname -f) $(hostname -s)" >> /etc/hosts

firewall-cmd --add-service=freeipa-4
firewall-cmd --permanent --add-service=freeipa-4

firewall-cmd --add-service=dns
firewall-cmd --permanent --add-service=dns

firewall-cmd --add-service=ntp
firewall-cmd --permanent --add-service=ntp

#REVZONE=$(echo "$IPETH0" | awk -F. '{print $3"." $2"."$1}')'.in-addr.arpa.'
#ipa-server-install -p "$DMPASS" -a "$ADMINPASS" -n "$DOMAIN" -r "${REALM^^}" --hostname="$(hostname -f)" --setup-dns --reverse-zone="$REVZONE" --mkhomedir -N --no-dns-sshfp --forwarder="$DNSFORWARDER1" --forwarder="$DNSFORWARDER2" -U

{
    echo "DMPASS=$DMPASS"
    "ADMINPASS=$ADMINPASS"
    "DOMAIN=$DOMAIN"
    "REALM=${REALM^^}" > /root/ipa-server-installer.txt
}

ipa-server-install -p "$DMPASS" -a "$ADMINPASS" -n "$DOMAIN" -r "${REALM^^}" --hostname="$(hostname -f)" --setup-dns --auto-reverse --mkhomedir -N --no-dns-sshfp --forwarder="$DNSFORWARDER1" --forwarder="$DNSFORWARDER2" -U
