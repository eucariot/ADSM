from ncclient import manager
import xmltodict

rpc = """
     <config>
       <configuration>
         <interfaces>
           <interface>
             <name>ge-0/0/0</name>
             <description>Mit der Dummheit kämpfen Götter selbst vergebens.</description>
           </interface>
         </interfaces>
       </configuration>
     </config>
     """

if __name__ == "__main__":
    with manager.connect(
        host="kzn-spine-0.juniper",
        ssh_config=True,
        hostkey_verify=False,
        device_params={"name": "junos"}
    ) as m:
        result = m.edit_config(target="candidate", config=rpc).data_xml
        m.commit()
    result_dict = xmltodict.parse(result)
    print(result_dict)
