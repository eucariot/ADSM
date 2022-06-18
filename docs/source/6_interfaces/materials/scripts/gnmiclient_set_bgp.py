#!/usr/bin/env python

from pygnmi.client import gNMIclient
import json

host = ("bcn-spine-1.arista", 6030)

set_config = [
(
    "/network-instances/network-instance[name=default]/protocols/protocol[name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]",
    {
            "config": {
                "peer-as": "4228186112"
            }
    }
)
]


if __name__ == "__main__":
    print(set_config)
    with gNMIclient(target=host, username="Im Leben",
                    password="werden", insecure=True) as gc:

        result = gc.set(update=set_config)

    print(json.dumps(result))
