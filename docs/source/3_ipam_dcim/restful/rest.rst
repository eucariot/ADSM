REST, RESTful, API
==================


Ниже я дам очень упрощённое описание того, что такое REST. 

Начнём с того, что **RESTful API** - это именно **интерфейс** взаимодействия, основанный на REST, в то время как сам **REST** (**REpresentational State Transfer**) - это набор ограничений, используемых для создания WEB-сервисов.
`тот самый VNGW <https://linkmeup.ru/blog/449.html#EXTERNAL>`_

О каких именно ограничениях идёт речь, можно почитать в `главе 5 диссертации Роя Филдинга Architectural Styles and the Design of Network-based Software Architectures <https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm>`_. Мне же позвольте привести только три наиболее значимых (с моей точки зрения) из них:

* В REST-архитектуре используется модель взаимодействия Клиент-Сервер. 
* Каждый REST-запрос содержит всю информацию, необходимую для его выполнения. То есть сервер не должен помнить ничего о предыдущих запросах клиента, что, как известно, характеризуется словом Stateless - не храним информацию о состоянии. 
* Единый интерфейс. Реализация приложения отделена от сервиса, который оно предоставляет. То есть пользователь знает, что оно делает и как с ним взаимодействовать, но как именно оно это делает не имеет значения. При изменении приложения, интерфейс остаётся прежним, и клиентам не нужно подстраиваться.

| WEB-сервисы, удовлетворяющие всем принципам REST, называются **RESTful WEB-services**.
| А API, который предоставляют RESTful WEB-сервисы, называется RESTful API.


| REST - не протокол, а, так называемый, стиль архитектуры (один из). Развиваемому вместе с HTTP Роем Филдингом, REST'у было предназначено использовать **HTTP 1.1**, в качестве транспорта.
| Адрес назначения (или иным словом - объект, или ещё иным - **endpoint**) - это привычный нам `URI <https://ru.wikipedia.org/wiki/URI>`_.
| Формат передаваемых данных - **XML** или **JSON**.

    | Для этой серии статей на linkmeup развёрнута read-only (для вас, дорогие, читатели) инсталляция NetBox: http://netbox.linkmeup.ru:45127.
    | На чтение права не требуются, но если хочется попробовать читать с токеном, то можно воспользоваться этим: *API Token: 90a22967d0bc4bdcd8ca47ec490bbf0b0cb2d9c8*.


Давайте интереса ради сделаем один запрос:

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/1/" -H "Accept: application/json; indent=4"

То есть утилитой **curl** мы делаем **GET** объекта по адресу **http://netbox.linkmeup.ru:45127/api/dcim/devices/1/** с ответом в формате **JSON** и отступом в **4** пробела.
Или чуть более академически: GET вовзращает типизированный объект **devices**, являющийся параметром объекта **DCIM**.

Этот запрос можете выполнить и вы - просто скопируйте себе в терминал.

    URL, к которому мы обращаемся в запросе, называется **Endpoint**. В некотором смысле это конечный объект, с которым мы будем взаимодействовать.
    Например, в случае netbox'а список всех endpoint'ов можно получить `тут <http://netbox.linkmeup.ru:45127/api/docs/>`_.
    И ещё обратите внимание на знак **/** в конце URL - он **обязателен**.

Вот что мы получим в ответ:

    .. code-block:: bash

       {
       "id": 1,
       "name": "mlg-host-0",
       "display_name": "mlg-host-0",
       "device_type": {
           "id": 4,
           "url": "http://netbox.linkmeup.ru/api/dcim/device-types/4/",
           "manufacturer": {
               "id": 4,
               "url": "http://netbox.linkmeup.ru/api/dcim/manufacturers/4/",
               "name": "Hypermacro",
               "slug": "hypermacro"
           },
           "model": "Server",
           "slug": "server",
           "display_name": "Hypermacro Server"
       },
       "device_role": {
           "id": 1,
           "url": "http://netbox.linkmeup.ru/api/dcim/device-roles/1/",
           "name": "Server",
           "slug": "server"
       },
       "tenant": null,
       "platform": null,
       "serial": "",
       "asset_tag": null,
       "site": {
           "id": 6,
           "url": "http://netbox.linkmeup.ru/api/dcim/sites/6/",
           "name": "Малага",
           "slug": "mlg"
       },
       "rack": {
           "id": 1,
           "url": "http://netbox.linkmeup.ru/api/dcim/racks/1/",
           "name": "A",
           "display_name": "A"
       },
       "position": 41,
       "face": {
           "value": "front",
           "label": "Front",
           "id": 0
       },
       "parent_device": null,
       "status": {
           "value": "active",
           "label": "Active",
           "id": 1
       },
       "primary_ip": null,
       "primary_ip4": null,
       "primary_ip6": null,
       "cluster": null,
       "virtual_chassis": null,
       "vc_position": null,
       "vc_priority": null,
       "comments": "",
       "local_context_data": null,
       "tags": [],
       "custom_fields": {},
       "config_context": {},
       "created": "2020-01-14",
       "last_updated": "2020-01-14T18:39:01.288081Z"
       }


Это JSON (как мы и просили), описывающий device с ID 1: как называется, с какой ролью, какой модели, где стоит итд.

Так будет выглядеть HTTP-запрос:

    .. code-block:: bash

       GET /api/dcim/devices/1/ HTTP/1.1
       Host: netbox.linkmeup.ru:45127
       User-Agent: curl/7.54.0
       Accept: application/json; indent=4

Так будет выглядеть ответ:

    .. code-block:: bash

       HTTP/1.1 200 OK
       Server: nginx/1.14.0 (Ubuntu)
       Date: Tue, 21 Jan 2020 15:14:22 GMT
       Content-Type: application/json
       Content-Length: 1638
       Connection: keep-alive
       
       Data

`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_devices.pcapng>`_.

А теперь разберёмся, что же мы натворили.