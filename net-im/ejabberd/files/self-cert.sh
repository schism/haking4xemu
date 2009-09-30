#!/bin/bash

######
#
# Generate a certificate and key with no passphrase.
#
######

OPENSSL=/usr/bin/openssl

## This generates the cert and key
$OPENSSL req -new -x509 -newkey rsa:1024 -keyout /tmp/privkey.pem -out /etc/ejabberd/ssl.pem
## This will remove the passphrase
$OPENSSL rsa -in /tmp/privkey.pem -out /tmp/privkey.pem
## Put it all together
cat /tmp/privkey.pem >> /etc/ejabberd/ssl.pem
## Cleanup
rm /tmp/privkey.pem
echo ""
echo "Your new key is /etc/ejabberd/ssl.pem"
echo ""
