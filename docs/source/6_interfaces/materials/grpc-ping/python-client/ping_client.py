import sys
import time
from datetime import datetime

import grpc

import ping_pb2
import ping_pb2_grpc

server = "84.201.157.17:12345"
# server = "localhost:12345"


def run(payload) -> None:
    with grpc.insecure_channel(server) as channel:
        stub = ping_pb2_grpc.PingStub(channel)
        start_time = datetime.now()
        response = stub.SendPingReply(ping_pb2.PingRequest(payload=payload))
        rtt = round((datetime.now() - start_time).total_seconds()*1000, 2)
    print(f"Ping response received: {response.message} time={rtt}ms")


if __name__ == "__main__":
    payload = sys.argv[1]

    while True:
        run(payload)
        time.sleep(1)
