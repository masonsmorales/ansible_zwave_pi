#!/bin/bash
# in /etc/ddclient.conf:
# postscript=/opt/scripts/update_ipv6.sh

function update_domain() {
  DOMAIN=$1
  USERNAME=$2
  PASSWORD=$3
  SERVER=$4
  #DEVICE="dev eth0"
  URL=https://$SERVER/nic/update
  FORCE_GET="-X GET -G"
  DNS_SERVER=@2606:4700:4700::1111
  VERBOSITY="-s -S"
  LOGGER="logger -t $(basename $0 .sh)"

  ACTUAL_ADDRESS=$(dig $DOMAIN AAAA $DNS_SERVER | \
    grep -v -e "^;" | grep AAAA | awk '{print $5}')
  TARGET_ADDRESS=$(ip -6 -o addr show $DEVICE scope global dynamic | \
    grep -v temporary | head -n 1 | cut -d " " -f 7 | cut -d / -f 1)
  [ "$ACTUAL_ADDRESS" = "$TARGET_ADDRESS" ] || \
    curl $VERBOSITY $FORCE_GET \
      --user $USERNAME:$PASSWORD \
      --data-urlencode hostname=$DOMAIN \
      --data-urlencode myip=$TARGET_ADDRESS $URL | \
    xargs echo updating $DOMAIN from $ACTUAL_ADDRESS to $TARGET_ADDRESS: | \
    $LOGGER
}

update_domain domain user password updateserver
