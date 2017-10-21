#!/bin/bash 

function host_info(){
    # local dnsips=$(sed --expression='/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}') # sed -e
    # regex /etc/resolv.conf to retrieve DNS resolver info

    echo "Hostname                              : $(hostname --short)"          # hostname -s
    echo "DNS Domain                            : $(hostname --domain)"         # hostname -d
    echo "Fully-qualified Domain Name (FQDN)    : $(hostname --fqdn)"           # hostname -f
    echo "Network Address (IP)                  : $(hostname --ip-address)"     # hostname -i
    echo "Domain Name Servers (DNS name)        : $(grep --word-regexp 'search' /etc/resolv.conf |sed 's/search //g')"  # grep -w 
    echo "Domain Name Servers (DNS IPs)         : $(grep --word-regexp 'nameserver' /etc/resolv.conf |sed 's/nameserver //g')"  

    # pause
}

host_info
