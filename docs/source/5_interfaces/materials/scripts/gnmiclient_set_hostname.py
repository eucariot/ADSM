#!/usr/bin/env python

from pygnmi.client import gNMIclient
import json

host = ("bcn-spine-1.arista", 6030)

set_config = [
(
    "openconfig-system:system",
    {
            "config": {
                "hostname": "bcn-spine-1.barista-karatista"
            }
    }
)
]
if __name__ == "__main__":

    with gNMIclient(target=host, username="sie",
                    password="ausgenutzt", insecure=True) as gc:

        result = gc.set(update=set_config)

    print(json.dumps(result))
