#!/usr/bin/env python3

import requests

API_TOKEN = "a9aae70d65c928a554f9a038b9d4703a1583594f"
HEADERS = {'Authorization': f'Token {API_TOKEN}', 'Content-Type': 'application/json', 'Accept': 'application/json'}
NB_URL = "http://netbox.linkmeup.ru:45127"

request_url = f"{NB_URL}/api/dcim/devices/"

device_parameters = {
    "name": "just a simple russian girl", 
    "device_type": 1, 
    "device_role": 1, 
    "site": 3, 
}
new_device = requests.post(request_url, headers = HEADERS, json=device_parameters)
print(new_device.json())