#!/usr/bin/env python
from pygnmi.client import gNMIclient
from oc_interfaces import openconfig_interfaces as oc_if
import json

host = ("bcn-spine-1.arista", 6030)


model = oc_if()
a = model.get()
a = model.interfaces.interface.add("GigabitEthernet2")
a.config.name = "GigabitEthernet2"
print(json.dumps(a.get()['config']))


set_config = [
(
    "openconfig-interfaces:interfaces",
    {
            "config": a.get()['config']
    }
)
]
if __name__ == "__main__":

    with gNMIclient(target=host, username="und dann",
                    password="beiseite geschoben", insecure=True) as gc:

        result = gc.set(update=set_config)

    print(json.dumps(result))

