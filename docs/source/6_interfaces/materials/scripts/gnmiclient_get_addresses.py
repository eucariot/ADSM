#!/usr/bin/env python

from pygnmi.client import gNMIclient
import json

host = {
        "ip_address": "bcn-spine-1.arista",
        "nos": "arista-eos",
        "port": 6030,
        "username": "werden nur",
        "password": "in Romanen belohnt"
    }

if __name__ == "__main__":
    paths = ['openconfig-interfaces:interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config']
    
    with gNMIclient(target=(host["ip_address"], host["port"]), username=host["username"],
                    password=host["password"], insecure=True) as gc:

        result = gc.get(path=paths, encoding='json')

    print(json.dumps(result))
