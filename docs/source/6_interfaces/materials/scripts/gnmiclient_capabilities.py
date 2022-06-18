#!/usr/bin/env python

from pygnmi.client import gNMIclient
import json

host = {
        "ip_address": "bcn-spine-1.arista",
        "nos": "arista-eos",
        "port": 6030,
        "username": "Bescheidenheit und",
        "password": "Pflichttreue"
    }

if __name__ == "__main__":
    with gNMIclient(target=(host["ip_address"], host["port"]), username=host["username"],
                    password=host["password"], insecure=True) as gc:

        result = gc.capabilities()

    print(json.dumps(result))
