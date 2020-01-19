#!/usr/bin/env python3

import pynetbox

API_TOKEN = "a9aae70d65c928a554f9a038b9d4703a1583594f"
NB_URL = "http://netbox.linkmeup.ru:45127"

nb = pynetbox.api(
        NB_URL,
        token = API_TOKEN
    )

devices = nb.dcim.devices.all()
print(devices)