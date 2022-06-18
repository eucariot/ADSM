from ncclient import manager
import xmltodict

rpc = """
     <filter>
     <configuration>
       <system>
          <host-name/>
       </system>
     </configuration>
     </filter>
     """

if __name__ == "__main__":
    with manager.connect(
        host="kzn-spine-0.juniper",
        ssh_config=True,
        hostkey_verify=False,
        device_params={"name": "junos"}
    ) as m:
        result = m.get_config("running", rpc).data_xml
    result_dict = xmltodict.parse(result)
    print(f'hostname is {result_dict["rpc-reply"]["data"]["configuration"]["system"]["host-name"]}')

