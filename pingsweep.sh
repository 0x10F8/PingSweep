#!/bin/bash
#
# Currently only ping sweeps a /24 network
# Takes the network address as the argument (e.g. 192.168.0.0)


NETWORK_ADDR="$1"
WORKING_ADDR=$(echo $NETWORK_ADDR | cut -d'.' -f1 -f2 -f3)

for i in $(seq 0 255); do
    ip="${WORKING_ADDR}.${i}"
    message="Trying ${ip}..."
    clear_message=$(printf %${#message}s | tr ' ' '\b')
    printf "${message}"
    result=$(ping -t 1 -c 1 ${ip} | grep 'packet loss' | awk '{print $7}')
    printf "${clear_message}"
    if [[ "$result" == "0.0%" ]]; then
        echo "[+] IP Address ${ip} is up!"
    fi
done
