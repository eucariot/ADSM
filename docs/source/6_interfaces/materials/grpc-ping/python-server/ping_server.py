import asyncio
import logging

import grpc

import ping_pb2
import ping_pb2_grpc


class Ping(ping_pb2_grpc.PingServicer):

    async def SendPingReply(self, request,context):
        return ping_pb2.PingReply(message=f"{request.payload}-pong")


async def serve():
    server = grpc.aio.server()
    ping_pb2_grpc.add_PingServicer_to_server(Ping(), server)
    listen_addr = "10.128.0.6:12345"
    server.add_insecure_port(listen_addr)
    logging.info(f"Now listening for ping on {listen_addr}")
    await server.start()
    await server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.run(serve())
