#!/bin/env bash

set -eou

BL_FILE="ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/blacklists.tar.gz"
TMP_FILE="$(basename ${BL_FILE})"
CATEGORIES="publicite adult dating fakenews doh drogue redirector vpn stalkerware social_networks shopping remote-control phishing hacking games gambling forums filehosting chat bank bitcoin"
WORKING_PATH="/etc/dnsmasq.d"

function block {
for bl in ${CATEGORIES}
do
tar -C ${WORKING_PATH}/ -xf ${WORKING_PATH}/${TMP_FILE} blacklists/${bl}/domains
mv ${WORKING_PATH}/blacklists/${bl}/domains ${WORKING_PATH}/${bl}.conf
sed -E -i 's/(.*\S)/nftset=\/\1\/inet\#filter\#BlockedDNS/g' ${WORKING_PATH}/${bl}.conf
done
chown dnsmasq:root -R ${WORKING_PATH}/*.conf
chmod 640 ${WORKING_PATH}/*.conf
rm -rf ${WORKING_PATH}/${TMP_FILE}
rm -rf ${WORKING_PATH}/blacklists
systemctl restart dnsmasq
}

block
