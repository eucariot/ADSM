from scrapli_netconf.driver import NetconfDriver

rpc = """
     <filter>
     <configuration>
       <system>
          <host-name/>
       </system>
     </configuration>
     </filter>
     """

device = {
        "host": "kzn-spine-0.juniper",
        "auth_strict_key": False,
        "port": 22
        }

if __name__ == "__main__":
    with NetconfDriver(**device) as conn:
        response = conn.get_config("running", rpc)

    print(response.result)
