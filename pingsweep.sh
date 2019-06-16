#!/bin/bash
#
# Currently only ping sweeps a /24 network
# Takes the network address as the argument (e.g. 192.168.0.0)


NETWORK_ADDR="$1"
WORKING_ADDR=$(echo $NETWORK_ADDR | cut -d'.' -f1 -f2 -f3)

for i in $(seq 0 255); do
    addr="${WORKING_ADDR}.${i}"
    ip=$(ping -t 1 -c 1 ${addr} 2>/dev/null | grep ttl | grep -Eo "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}") && [[ "$ip" != "" ]] && echo "[+] ${ip} is up"! &
done
