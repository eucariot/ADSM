gRPC/gNMI
=========

За последние лет семь gRPC уже всем уши прожужжали. И только самые ловкие разработчики могли избежать реализации взаимодействия с какой-нибудь системой по gRPC.

`g в gRPC <https://github.com/grpc/grpc/blob/master/doc/g_stands_for.md>`_, кстати, означает вовсе не *"google"*.

| Реализация фреймворка поверх gRPC в мире сетевой автоматизации получила название **gNMI** - *gRPC Network Management Interface*.
| В основе gNMI лежит gRPC, для моделирования данных использует YANG (но не обязательно), внутри уже определяются конкретные RPC. Кроме того gNMI изначально предоставляет возможность естественным образом реализовать telemetry - потоковую передачу телеметрических данных.

В любом случае я не я, если перед gNMI я не разберу gRPC. Поэтому простите за отступление, но без него статья превратится в бесполезное поверхностное хауту.

gRPC
----

| Без теории - за ней прошу в `пятую часть АДСМ <https://adsm.readthedocs.io/ru/latest/5_history/index.html>`_.
| В любом случае после голой теории вот только такие ощущения:

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/owl.jpeg
           :width: 800
           :align: center

    Есть, правда, и более `последовательная инструкция <https://fs.linkmeup.ru/images/adsm/5/owl-2.jpeg>`_.

Хотя точно стоит сказать о том, что gRPC использует **Protocol Buffers** (или **коротко protobuf**). Термин этот довольно нагруженный:

* это и спецификация, в которой описано, как данные должны выглядеть. Ещё это называется прото-спека.
* это и IDL (Interface Definition Language), позволяющим разным системам друг с другом на одном языке общаться
* это и формат сериализованных данных, в котором информация передаётся между системами
* То есть всего лишь один proto-файл (или их набор), определяет сразу все эти три вещи
* То есть когда вы пишете gRPC-приложение, формирование protobuf - это важнейший шаг.

Пишем ping!
~~~~~~~~~~~

**Спецификация**

Описываем protobuf:

    .. code-block:: go

       service Ping {
         rpc SendPingReply (PingRequest) returns (PingReply) {}
       }

| Сначала определяем сервис - ``Ping``. А в нём есть метод - ``SendPingReply`` - это собственно и есть RPC - та самая процедура, которую мы дёрнем удалённо - процедура отправить ``Ping Reply``.
| В качестве атрибута она принимает параметр `PingRequest`, а вернёт ответ ``PingReply``. 

А что такое эти ``PingRequest`` и ``PingReply``??

    .. code-block:: go

       message PingRequest {
         string payload = 1;
       }


| ``PingRequest``  - это одно из пересылаемых сообщений между клиентом и сервером.
| Так объявляется факт его существования, и его содержимое. В этом случае внутри сообщения передаётся одно поле ``payload`` типа ``string``.
| ``payload`` -  это произвольное имя, которое мы можем выбрать, как хотим. 
| ``string`` - определение типа.
| ``1`` - позиция поля в сообщении - для нас не имеет значения.

    .. code-block:: go

       message PingReply {
         string message = 1;
       }


Всё точно то же самое. Именем поля может быть даже слово message. 

Вот так будет выглядеть полный proto-файл:

    .. code-block:: go

       syntax = "proto3";
       
       option go_package = "go-server/ping";
       
       package ping;

       // The ping service definition.
       service Ping {
         // Sends a ping reply
         rpc SendPingReply (PingRequest) returns (PingReply) {}
       }
       
       // The request message containing the ping payload.
       message PingRequest {
         string payload = 1;
       }
       
       // The response message containing the ping replay
       message PingReply {
         string message = 1;
       }

То есть именно вот так и выглядит спецификация, описывающая схему данных на обеих сторонах. И сервер и клиент будут использовать один и тот же proto-файл и всегда знать, как разобрать то, что отправила другая сторона. Даже если они написаны на разных языках.

| Сохраняем как ``protos/ping.proto`` - он будет один для всех.
| Ну ладно спецификация есть. И что с ней теперь делать?

А теперь мы напишем пинг-клиент на Python, а пинг-сервер на Go.

gRPC Client
~~~~~~~~~~~

**Сгенерированный Код**

| Создадим директорию ``python-client``.
| Далее на основе спецификации сгенерируем код.
| Для этого нужно будет установить ``grpcio-tools``.

    .. code-block:: bash

       pip install grpcio-tools

И используя его уже нагенерить нужные классы:

    .. code-block:: bash

       python3 -m grpc_tools.protoc \
               -I protos \
               --python_out=python-client \
               --grpc_python_out=python-client \
               protos/ping.proto


| Сразу после этого в каталоге, где мы это выполнили, появятся два файла: ``ping_pb2.py`` и ``ping_pb2_grpc.py`` - это сгенерированный код.
| Если вы зяглянете вовнутрь, то обнаружите там кучу классов. Это классы, реализующие сообщения, сервисы для сервера (``PingServicer``) и для клиента (``PingStub``). Там же у класса ``Ping`` есть и метод ``SendPingReply``. И куча других штуковин.
| Эти файлы нам никогда не придётся менять вручную - мы будем их только импортировать и использовать.

| Очевидно, что эти py-файлы это только реализация интерфейса взаимодействия. Ровным счётом ничего тут не говорит, как этот сервис будет работать.
| Бизнес-логика описывается уже отдельно - и вот она делается нами.

Пока структура выглядит так:

    .. code-block:: text

       .
       ├── ping_client.py
       ├── ping_pb2.py
       └── ping_pb2_grpc.py

Давайте писать gRPC-клиент.

Клиент будет совсем бесхитростным.
В цикле он будет пытаться выполнить RPC ``SendPingReply`` на удалённом хосте ``84.201.157.17:12345``. В качестве аргумента передаём payload, который считали из аргументов запуска скрипта.

В функции ``run`` мы устанавливаем соединение к серверу, подключаем ``stub`` и выполняем RPC ``SendPingReply``, которому передаём сообщение ``PingRequest`` с тем самым ``payload``.

    .. code-block:: python

       import sys
       import time
       from datetime import datetime

       import grpc

       import ping_pb2
       import ping_pb2_grpc

       server = "84.201.157.17:12345"


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


Если запустить его сейчас, клиент вернёт ``StatusCode.UNAVAILABLE`` - сервера пока нет, порт 12345 никто не слушает.

Давайте теперь писать

gRPC-сервер
~~~~~~~~~~~

на Go. Я его развернул на облачной виртуалочке, поэтому какое-то время он будет доступен и читателям.

Всё, что делает сервер - получает какую-то строку в ``payload``, добавляет к нему *"-pong"* и возвращает это клиенту.

**Сгенерированный Код**

| Тут нам тоже понадобится дополнительный код, реализующий интерфейс.
| Создаём рабочую директорию `go-server`, внутри которой ещё ``ping`` - для хранения спецификации и кода интерфейса.

    .. code-block:: bash

       protoc --go_out=. --go-grpc_out=.  protos/ping.proto

И получается так:

    .. code-block:: bash

       .
       ├── go.mod
       ├── go.sum
       └── ping
           ├── ping_grpc.pb.go
           ├── ping.pb.go
           └── ping.proto

| Дальше сам код сервера. Я его тоже взял из `примеров для go <https://github.com/grpc/grpc-go/tree/master/examples/helloworld>`_.
| Мы тут опускаем часть про установку go, protoc, потому что это всё есть в `документации grpc.io <https://grpc.io/docs/languages/go/quickstart/>`_.

    .. code-block:: go

       package main

       import (
           "context"
           "flag"
           "fmt"
           "log"
           "net"
       
           "google.golang.org/grpc"
           pb "ping-server/ping"
       )

       var (
           port = flag.Int("port", 12345, "The server port")
       )

       type server struct {
           pb.UnimplementedPingServer
       }

       func (s *server) SendPingReply(ctx context.Context, in *pb.PingRequest) (*pb.PingReply, error) {
           log.Printf("Received: %v", in.GetPayload())
           return &pb.PingReply{Message: in.GetPayload() + "-pong"}, nil
       }

       func main() {
           flag.Parse()
           lis, err := net.Listen("tcp", fmt.Sprintf("10.128.0.6:%d", *port))
           if err != nil {
               log.Fatalf("failed to listen: %v", err)
           }
           s := grpc.NewServer()
           pb.RegisterPingServer(s, &server{})
           log.Printf("server listening at %v", lis.Addr())
           if err := s.Serve(lis); err != nil {
               log.Fatalf("failed to serve: %v", err)
           }
       }


Вся бизнес логика описана в функции ``SendPingReply``, ожидающей ``PingRequest``, а возвращающей ``PingReply``, в котором мы отправляем сообщение ``message``: ``payload`` + *"-pong"* (``GetPayload``). Естественно, там может быть более изощрённая логика.

| Ну, а в ``main`` мы запускаем сервер на адресе ``10.128.0.6``.
| Почему не на ``84.201.157.17``, на который стучится клиент? Тут без хитростей - это внутренний адрес ВМ, на который натируются все запросы к публичному адресу.

Я положу его в 

    .. code-block:: bash

       .
       └── ping-server
           └── main.go

    .. code-block:: bash

       $ go run ping-server/main.go
       2022/01/30 04:26:11 server listening at 10.128.0.6:12345

Всё, сервер готов слушать.

`Пример сервера на питоне <https://github.com/eucariot/ADSM/tree/master/docs/source/5_interfaces/materials/grpc-ping/python-server>`_, если хочется попробовать.

    Используем сразу asyncio, это же сервер, нельзя тут блочиться. 

    Для того, чтобы запустить сервер, нужно доставить пакет grpcio

        .. code-block:: bash

           python -m pip install grpcio

**Запускаем?**

    .. code-block:: bash

       ❯ python ping_client.py piu
       Ping response received: piu-pong time=208.13ms
       Ping response received: piu-pong time=165.62ms
       Ping response received: piu-pong time=162.89ms

У-хууу, ё-моё, grpc-заработал!!!!

А давайте теперь попробуем подампать трафик? Я запустил сервер удалённо и снял трафик.

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/grpcio-dump.png
           :width: 800
           :align: center


| По умолчанию, Wireshark не декодирует HTTP2, давайте научим его?
| `Analyze -> Decode As.`

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/grpcio-dump-http.png
           :width: 800
           :align: center


Вот тут уже видно почти все наши объекты, которые передаются между клиентом и сервером.
`pcap-файл <https://github.com/eucariot/ADSM/blob/master/docs/source/6_interfaces/materials/dumps/grpc.pcap>`_.

Кайф!!

Давайте ещё раз проговорим, что мы сделали.

1. Описали спецификацию сервиса - какие методы доступны, какими сообщениями с какими полями они обмениваются.
2. Сгенерировали из этой спецификации код как для сервера на Go, так и для клиента на Python.
3. Написали логику сервера и клиента
4. Клиент сделал вызов удалённого метода на сервере. Список доступных методов мы знаем из proto-файла.
5. Сервер вернул результат работы процедуры клиенту.

`Весь код в репозитории <https://github.com/eucariot/ADSM/tree/master/docs/source/6_interfaces/materials/grpc-ping>`_.

Итак, разобрались с gRPC. Ну, будем так считать, по крайней мере.

Внутри гугла gRPC удалось адаптировать даже к задачам сети. То есть gRPC стал единым интерфейсом взаимодействия между разными компонентами во всей компании (или одним из - мы не знаем).

gNMI
----

**gNMI** довольно новый протокол. Про него нет страницы на вики, довольно мало материалов и мало кто рассказывает о том, как его использует в своём проде.

Он не является стандартом согласно любым организациям и RFC, но его спецификация `описана на гитхабе <https://github.com/openconfig/reference/blob/master/rpc/gnmi/gnmi-specification.md>`_.

| Что нам важно знать о нём для начала? *gRPC Network Management Interface*.
| Это протокол управления сетевыми устройствами, использующий gRPC как фреймворк: транспорт, режимы взаимодействия (унарный и все виды стриминга), механизмы маршаллинга данных, прото-файлы для описания спецификаций.

В качестве модели данных он может использовать YANG (а может и не использовать - в протобафы можно же засунуть всё, что угодно).

Как того требует gRPC, на сетевом устройстве запускается сервер, на системе управления - клиент. На обеих сторонах должна быть одна спецификация, одна модель данных. 


    .. figure:: https://fs.linkmeup.ru/images/adsm/5/gnmi.png
           :width: 800
           :align: center

Поскольку это конструкт над gRPC, в нём определены `конкретные сервисы и RPC <https://github.com/openconfig/gnmi/blob/master/proto/gnmi/gnmi.proto>`_:

    .. code-block:: go

       servicegNMI{
         rpcCapabilities(CapabilityRequest) returns(CapabilityResponse);
         rpcGet(GetRequest) returns(GetResponse);
         rpcSet(SetRequest) returns(SetResponse);
         rpcSubscribe(streamSubscribeRequest) returns(streamSubscribeResponse);
       }

Более наглядное представление полного прото-файла можно увидеть на `интерактивной карте <https://github.com/hellt/gnmi-map>`_, которую нарисовал Роман Додин:

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/gnmi_0.7.0_map.png
           :width: 1000
           :align: center

    `Картинка побольше <https://fs.linkmeup.ru/images/adsm/5/gnmi_0.7.0_map.pdf>`_

Здесь каждый RPC расписан на сообщения и типы данных, и указаны ссылки на прото-спеки и документацию.
Не могу сказать, что это удобное место для того, чтобы начать знакомиться с gNMI, но вы точно к нему ещё много раз вернётесь, если сядете на gNMI.

Предлагаю попробовать на практике вместо теорий.

| Вообще gNMI, как плоть от плоти gRPC не очень удобен для использования человеком. Прото-файлы пиши, код пиши, исполняй. Нельзя как в REST API просто curl отправить и получить текстовый ответ - это вообще известная боль.
| Но для gNMI напридумывали клиентов.

И тут google в лучших традициях делает прекрасные инфраструктурные вещи и ужасный пользовательский интерфейс. `gNXI <https://github.com/google/gnxi>`_, `OpenConfig gNMI CLI client <https://github.com/openconfig/gnmi>`_.

gNMIc
~~~~~
Нас и тут спасает Роман Додин, поучаствоваший в создании классного клиента gNMI, совместно с Karim Radhouani - `gNMIc <https://gnmic.kmrd.dev/install/>`_.

Устанавливаем по инструкции:

    .. code-block:: bash

       bash -c "$(curl -sL https://get-gnmic.kmrd.dev)"

Теперь надо настроить узел.

    .. code-block:: text

       interface Management1
          ip address 192.168.1.11/24

       username eucariot secret <SUPPASECRET>

       management api gnmi
          transport grpc default

       ip access-list control-plane-acl-with-restconf-and-gnmi
          8 permit tcp any any eq 6030
       …

       control-plane
          ip access-group control-plane-acl-with-restconf-and-gnmi in

Попробуем выяснить capabilities:

    .. code-block:: bash

       gnmic capabilities \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

А в ответ пара экранов текста, полного возможностей:

    .. code-block:: bash

       gNMI version: 0.6.0
       supported models:
         - arista-exp-eos-multicast, Arista Networks <http://arista.com/>,
         - arista-exp-eos, Arista Networks <http://arista.com/>,
         - openconfig-if-ip, OpenConfig working group, 2.3.0
       …
       supported encodings:
         - JSON
         - JSON_IETF
         - ASCII

| Тут видно, что устройство поддерживает три вида кодирования. Нам интересен JSON.
| А так же, несколько десятков моделей данных, как OpenConfig, так и IETF и проприетарные.
| Дальше нет времени объяснять, откуда я это взял, просто пробуем собрать IP-адреса всех интерфейсов:

    .. code-block:: bash

       gnmic get \
             --path "/interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config"\
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure 

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
                      "Path": "interfaces/interface[name=Management1]/subinterfaces/subinterface[index=0]/ipv4/addresses/address[ip=192.168.1.11]/config",
               "values": {
                 "interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config": {
                   "openconfig-if-ip:ip": "192.168.1.11",
                   "openconfig-if-ip:prefix-length": 24
                 }
               }
             },
             {
                      "Path": "interfaces/interface[name=Ethernet3]/subinterfaces/subinterface[index=0]/ipv4/addresses/address[ip=169.254.101.1]/config",
               "values": {
                 "interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config": {
                   "openconfig-if-ip:ip": "169.254.101.1",
                   "openconfig-if-ip:prefix-length": 31
                 }
               }
             },
             {
                      "Path": "interfaces/interface[name=Ethernet2]/subinterfaces/subinterface[index=0]/ipv4/addresses/address[ip=169.254.1.3]/config",
               "values": {
                 "interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config": {
                   "openconfig-if-ip:ip": "169.254.1.3",
                   "openconfig-if-ip:prefix-length": 31
                 }
               }
             }
           ]
         }
       ]

Из ответа видно полный путь к каждому интерфейсу, запрошенный путь и результат в модели OpenConfig.

| Один ультра-полезный аргумент в gNMIc, это ``--path "/"`` -  он вернёт просто всё, что может.
| Полезен он тем, что можно из вывода пореверсинжинирить где что искать.

    .. code-block:: bash

       gnmic get \
             --path "/" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

Ответа будет много.

И оттуда можно понять, что посмотреть конфигурацию BGP-пиров можно, используя путь ``"/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config"``:

    .. code-block:: bash

       gnmic get \
             --path "/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config",
               "values": {
                 "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config": {
                   "openconfig-network-instance:auth-password": "",
                   "openconfig-network-instance:description": "",
                   "openconfig-network-instance:enabled": true,
                   "openconfig-network-instance:local-as": 0,
                   "openconfig-network-instance:neighbor-address": "169.254.1.2",
                   "openconfig-network-instance:peer-as": 4228186112,
                   "openconfig-network-instance:peer-group": "LEAFS",
                   "openconfig-network-instance:route-flap-damping": false,
                   "openconfig-network-instance:send-community": "NONE"
                 }
               }
             },
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.101.0]/config",
               "values": {
                 "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config": {
                   "openconfig-network-instance:auth-password": "",
                   "openconfig-network-instance:description": "",
                   "openconfig-network-instance:enabled": true,
                   "openconfig-network-instance:local-as": 0,
                   "openconfig-network-instance:neighbor-address": "169.254.101.0",
                   "openconfig-network-instance:peer-as": 0,
                   "openconfig-network-instance:peer-group": "EDGES",
                   "openconfig-network-instance:route-flap-damping": false,
                   "openconfig-network-instance:send-community": "NONE"
                 }
               }
             }
           ]
         }
       ]

А такой, чтобы проверить состояние пира: ``"/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/state/session-state"``

    .. code-block:: bash

       gnmic get \
                  --path "/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/state/session-state" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/state/session-state",
               "values": {
                      "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/state/session-state": "ACTIVE"
               }
             },
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.101.0]/state/session-state",
               "values": {
                      "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/state/session-state": "ACTIVE"
               }
             }
           ]
         }
       ]

И получается, вполне очевидное деление на конфигурационные и операционные данные.

Вот данные по конфигурации ветки system:

    .. code-block:: bash

       gnmic get \
             --path "/system/config" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
               "Path": "system/config",
               "values": {
                 "system/config": {
                   "openconfig-system:hostname": "bcn-spine-1",
                   "openconfig-system:login-banner": "",
                   "openconfig-system:motd-banner": ""
                 }
               }
             }
           ]
         }
       ]

А вот по состоянию:

    .. code-block:: bash

       gnmic get \
             --path "/system/state" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
               "Path": "system/state",
               "values": {
                 "system/state": {
                   "openconfig-system:boot-time": "164480684820",
                   "openconfig-system:current-datetime": "2022-02-19T13:24:54Z+00:00",
                   "openconfig-system:hostname": "bcn-spine-1",
                   "openconfig-system:login-banner": "",
                   "openconfig-system:motd-banner": ""
                 }
               }
             }
           ]
         }
       ]

Ну, и последний практический пример в этой секции: настроим чего полезного на железке, ``Set RPC``.

Сначала посмотрим значение AS у одного из BGP-пиров:

    .. code-block:: bash

       gnmic get \
                  --path "/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config/peer-as" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p passowrd \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config/peer-as",
               "values": {
                      "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config/peer-as": 4228186112
               }
             }
           ]
         }
       ]

Теперь поменяем значение:

    .. code-block:: bash

       gnmic set \
                  --update-path "/network-instances/network-instance[name=default]/protocols/protocol[name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config/peer-as" \
             --update-value "4228186113" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p passowrd \
             --insecure

    .. code-block:: json

       {
         "source": "bcn-spine-1.arista:6030",
         "timestamp": 1645281264572566754,
         "time": "2022-02-19T06:34:24.572566754-08:00",
         "results": [
           {
             "operation": "UPDATE",
             "path": "network-instances/network-instance[name=default]/protocols/protocol[name=BGP]/bgp/neighbors/    neighbor[neighbor-address=169.254.1.2]/config/peer-as"      
           }      
         ]
       }

Проверяем ещё раз:

    .. code-block:: bash

       gnmic get \
                  --path "/network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config/peer-as" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

    .. code-block:: json

       [
         {
           "source": "bcn-spine-1.arista:6030",
           "time": "1969-12-31T16:00:00-08:00",
           "updates": [
             {
                      "Path": "network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/neighbors/neighbor[neighbor-address=169.254.1.2]/config/peer-as",
               "values": {
                      "network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/config/peer-as": 4228186113
               }
             }
           ]
         }
       ]

Уиии!
Я чуть не вскочил с места, когда получилось.

А ещё у gNMIc есть `автокомплишн <https://netdevops.me/2020/gnmic-got-better-with-yang-completions/>`_.

| Ну нам бы сейчас полезно было бы посмотреть на примеры работы с кодом?
| Но вместо того, чтобы всё делать руками, воспользуемся готовым инструментом.

Сам gNMIc может быть импортирован как зависимость в Go-программу, поскольку имеет `зрелую подсистему API <https://gnmic.kmrd.dev/user_guide/golang_package/intro/>`_.


pyGNMI
~~~~~~

Эта библиотека `написана Антоном Карнелюком <https://github.com/akarneliuk/pygnmi/commit/80af66e7295ad11ca9009c0059beb61c853ee31d>`_ (и снова русский след). Заметно удобнее всего остального и активно развивается.

Да на неё даже ссылается Arista из своей `Open Management <https://aristanetworks.github.io/openmgmt/examples/pygnmi/>`_.

Соберём capabilities:

    .. code-block:: python

       #!/usr/bin/env python

       from pygnmi.client import gNMIclient
       import json

       host = ("bcn-spine-1.arista", 6030)

       if __name__ == "__main__":
           with gNMIclient(target=host, username="eucariot",
                           password="password", insecure=True) as gc:
       
               result = gc.capabilities()

           print(json.dumps(result))

По-get-аем что-нибудь:

    .. code-block:: python

       #!/usr/bin/env python

       from pygnmi.client import gNMIclient
       import json

       host = ("bcn-spine-1.arista", 6030)

       if __name__ == "__main__":
                  paths = ["openconfig-interfaces:interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config"]

           with gNMIclient(target=host, username="eucariot",
                           password="password", insecure=True) as gc:

               result = gc.get(path=paths, encoding='json')

           print(json.dumps(result))

Ну и осталось теперь что-то поменять, например, тот же hostname:

    .. code-block:: python

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
       
           with gNMIclient(target=host, username="eucariot",
                           password="fpassword", insecure=True) as gc:
       
               result = gc.set(update=set_config)

           print(json.dumps(result))

    .. code-block:: bash

       python gc_set.py | jq
       {
         "timestamp": 1645326686451002000,
         "prefix": null,
         "response": [
           {
             "path": "system",
             "op": "UPDATE"
           }
         ]
       }

В `репе ADSM <https://github.com/eucariot/ADSM/blob/master/docs/source/6_interfaces/materials/scripts/gnmiclient_set_bgp.py>`_ можно найти пример по изменению BGP peer-as.


| gNMIc и pyGNMI - это всего лишь частные инструменты для работы через gNMI. Ничто не мешает вам самим реализовать набор методов удобным образом.
| Важно здесь заметить то, что у gNMI нет концепции Data Stores и как следствие функционала коммитов конфигурации - мы работаем с сервисом.
| gNMI заставляет нас вывернуть привычный взгляд на сеть иголками внутрь. Мы к ней теперь должны относиться как к ещё одному сервису, которым можно легко управлять через единообразный интерфейс. Сам же gNMI обеспечивает транзакционность всех изменений, передаваемых в одном RPC.
| Представьте себе, что вы пишите в базу данных и нужно потом сделать ещё коммит, чтобы эти изменения сохранить - звучит нелогично. Вот так и с сетью - транзакционность есть, коммитов - нет.
| Для инфраструктурной команды сеть - это больше не какой-то свой собственный особенный мир, находящийся где-то там за высокой стеной CLI, окружённый рвами, заполненными проприетарным синтаксисом.

Нам следует разделить сетевое устройство, к которому мы всю жизнь относились как к чему-то в целостному, потому что покупаем сразу всё это в сборе, на следующие части: 

* **железный хост** - коммутаторы и маршрутизаторы, со всеми их медными и оптическими проводочками, куском кремния под вентилятором и трансиверами,
* **операционная система** - софт, который управляет жизнью железа и запускаемыми приложениями,
* **приложения**, реализующие те или иные сервисы или доступ к ним - аутентификация, интерфейсы, BGP, VLAN'ы, или gNMI, дающий доступ к ним ко всем.

Да, влияние проблем на сетевом устройстве имеет больший охват. Да, можно оторвать себе доступ одним неверным движением. Да, поддержка целевого состояния на все 100% - всё ещё сложная задача.

Но чем, в конце концов это отличается от обычного Linux'а, на котором крутится сервис?

То есть сервисный интерфейс (gNMI, gRPC, REST, NETCONF) следует рассматривать как способ управления собственно сервисами, в то время как для обслуживания хоста никуда не девается SSH+CLI - для отладки, обновления, управления приложениями. Впрочем и тут есть Ansible, Salt. Вот только идеально для этого, чтобы сетевая железка стала по-настоящему открытой - с Linux'ом на борту.


Кроме того есть

gNOI
----

| *gRPC Network Operations Interface* от OpenConfig - набор микросервисов, основанных на gRPC, позволяющих выполнять операционные команды на хостах. 
| Если проще, то можно запустить ping, traceroute, почистить разные таблицы, сделать Route Refresh BGP-соседу, скопировать файл - всё то, что относится не к конфигурации, а скорее к отладке и эксплуатации.

На самом деле там на сегодняшний день уже `достаточно внушительный список операций <https://github.com/openconfig/gnoi>`_.

А ещё по аналогии с gNMIc существует и `gNOIc <https://gnoic.kmrd.dev/>`_.

Telemetry
---------

Начнем с того что под словом "телеметрия" каждый вендор может понимать свое. У Huawei своя реализация поверх gRPC (местами даже платная!), у Cisco есть Model-driven Telemetry (например `Cisco Model-Driven Telemetry (MDT) Input Plugin <https://github.com/influxdata/telegraf/tree/master/plugins/inputs/cisco_telemetry_mdt>`_), у Juniper тоже есть своя реализация - `JTI <https://www.juniper.net/documentation/us/en/software/junos/interfaces-telemetry/interfaces-telemetry.pdf>`_. Последние два еще параллельно поддерживают gNMI.

| Отсюда уже возникает некоторая путаница, с которой разберёмся пониже. Главное - суть одна - устройство само рассылает данные тем клиентам, которые оформили подписку на обновления. Таким образом система мониторинга не тратит такты и RTT на опрос (polling), а всего лишь получает данные на свой интерфейс.
| И если частота опроса ограничена единицами-десятками раз в минуту, то стриминг телеметрии вообще нет - устройство может слать хоть по каждому обновлению.
| Тут, конечно, нужно быть аккуратным с машстабированием - в случае опроса мы сами управляем тем, сколько данных нужно обработать системой. Объём работы всегда предсказуемый и линейно зависит от числа опрашиваемых узлов. Видим увеличение нагрузки - добавляем ещё экземпляров попрошаек и шардируем нагрузку.
| И всё иначе в случае стриминга телеметрии - тут узлы сети могу напихать в коллектор столько, что он не в состоянии обработать. Думать про масштабирование и отказоустойчивость тут придётся до усиленного потовыделения.

| Перечисленные выше вендорские телеметрии поддерживают “сжатый формат” протобафов - когда данные представлены в виде структуры, зависимой от вендора, модели и ПО. Для декодирования таких данных нужен специальный вендорский прото-файл. Например, `такой <https://github.com/Juniper/telemetry/blob/master/18.3/18.3R1/protos/port.proto>`_. В gNMI же данные в универсальном виде. Это хорошо с точки зрения discovery, так как для запроса нужно найти только путь подписки, но сильно сказывается на размере данных и отсутствии структуры данных (*теоретически можно вывести из моделей). 
| gNMI чересчур свободен в выборе типа кодирования данных. Можно и Proto и ASCII и даже два вида JSON.
Не предусмотрена “дешевая” отправка. У джуна и у аристы есть отправка протобафов в UDP. Это очень дешево для устройства и коллектора и даже может быть реализовано прям на линейной карте (мониторинг микробёрстов, например). При столь частой отправке обновлений разовые потери UDP не страшны.
| Что сделано классно в gNMI, так это возможность подписаться только на изменения. Рисовать графики только по изменениям так себе идея конечно, но в gNMI можно реализовать такой сценарий: подписываешься на определенные данные, получаешь все значения и записываешь их в свой кеш. Дальше получаешь изменения и опционально периодические полные срезы. Теперь можно периодически отсылать весь кеш в БД и рисовать аккуратные графики.

Если говорить в целом про сбор метрик, то есть смысл использовать то, что поддерживается вендором в первую очередь. SNMP - надежный как швейцарские часы, тонны библиотек для работы с ним, MIBы устоялись и его не стыдно использовать даже в 2022. gNMI крутой, но реализация может подкачать - неизбежны детские болячки типа отсутствия поддержки IPv6 и требования админских прав для получения метрик.