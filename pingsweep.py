#!/usr/bin/python3
# Refactored code from my port scanning python script here https://github.com/0x10F8/pscan/blob/master/pscan.py
# sudo python3 pingsweep.py 192.168.0.1
from concurrent.futures import ThreadPoolExecutor
from ping3 import ping
import sys

''' Default timeout for various actions throughout the script '''
DEFAULT_TIMEOUT = 1
''' Default number of worker threads to use when port scanning '''
DEFAULT_WORKER_THREADS = 1000

def is_host_up_icmp(host, timeout=DEFAULT_TIMEOUT):
    if ping(dest_addr=host, timeout=timeout) is None:
        return False, host
    return True, host


network_address = sys.argv[1]
na_oct = network_address.split('.')
working_address = "%s.%s.%s" % (na_oct[0], na_oct[1], na_oct[2])
thread_pool = ThreadPoolExecutor(max_workers=DEFAULT_WORKER_THREADS)
thread_results = []
results = []
for i in range(1,255):
    ip_address = "%s.%s" % (working_address, i)
    thread_results.append(thread_pool.submit(is_host_up_icmp, ip_address))
for future in thread_results:
    results.append(future.result())
thread_pool.shutdown()

[print("[+] IP Address %s is up!" % ip) for result,ip in results if result]