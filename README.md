# dnsmasq-nftset
Block Domains using nftset Dnsmasq feature.
The aim of this project is to drop access to various destination using DNS instead of IP.
Usually firewalls work at layer 3 and 4 so they're not able to filter DNS destinations without some Hack.
With this approach you won't need any HTTP Proxy.


## Requirements

 - nftables
 - dnsmasq


## How it works

Using the nftset Dnsmasq functionality , everytime a domain configured in the nftset directive is resolved,all the IP addresses
are automatically added in the nftables set.
You can then configure your FW rules to deny access to those destinations.
To let all the stuff work,is mandatory that every host use the same dnsmasq instance to resolve dmains.This is the reason why there's a nft rules tht redirect all the DNS traffic to thelocal DNS port.

## BONUS

the Dnsmasq configuration will also implement the safe search engines enforcement

