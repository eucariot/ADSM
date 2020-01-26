Методы
======

Как вы уже поняли, для работы с WEB-сервисами HTTP использует методы. То же самое касается и RESTful API.
Возможные сценарии описываются термином **CRUD - Create, Read, Update, Delete**.
Вот список наиболее популярных методов HTTP, реализующих CRUD:

* HTTP GET
* HTTP POST
* HTTP PUT
* HTTP DELETE
* HTTP PATCH

Методы также называются **глаголами**, поскольку указывают на то, какое действие производится.

`Полный список методов <https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods>`_.

Давайте на примере NetBox разберёмся с каждым из них.


HTTP GET
--------

Это метод для получения информации.

Так, например, мы забираем список устройств:

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/" -H "Accept: application/json; indent=4"

Метод GET **безопасный** (**safe**), поскольку не меняет данные, а только запрашивает.
Он **идемпотентный** с той точки зрения, что один и тот же запрос всегда возвращает одинаковый результат (до тех пор, пока сами данные не поменялись).

На GET сервер возвращает сообщение с HTTP-кодом и телом ответа (**response code** и **response body**).
То есть если всё OK, то код ответа - 200 (OK).
Если URL не найден - 404 (NOT FOUND).
Если что-то не так с самим сервером или компонентами, это может быть 500 (SERVER ERROR) или 502 (BAD GATEWAY).
`Все возможные коды ответов <https://en.wikipedia.org/wiki/List_of_HTTP_status_codes>`_.

Тело возвращается в формате JSON или XML.
`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_all_devices.pcapng>`_.


Давайте ещё пару примеров. Теперь мы запросим информацию по конкретному устройству по его имени.
    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0" -H "Accept: application/json; indent=4"

Здесь, чтобы задать условия поиска в URI я ещё указал атритбут объекта (параметр **name** и его значение **mlg-leaf-0**). Как вы можете видеть, перед условием и после слэша идёт знак **"?"**, а имя и значение разделяются знаком **"="**.

Так выглядит запрос.

    .. code-block:: bash
       
       GET /api/dcim/devices/?name=mlg-leaf-0 HTTP/1.1
       Host: netbox.linkmeup.ru:45127
       User-Agent: curl/7.54.0
       Accept: application/json; indent=4

`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_by_name.pcapng>`_.


Если нужно задать пару условий, то запрос будет выглядеть так:

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?role=leaf&site=mlg" -H "Accept: application/json; indent=4"

Здесь мы запросили все устройства с ролью **leaf**, расположенные на сайте **mlg**.
То есть два условия отделяются друг от друга знаком **"&"**.

`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_double_conditions.pcapng>`_.

Из любопытного и приятного - если через "&" задать два условия с одним именем, то между ними будет на самом деле не логическое "И", а логическое "ИЛИ".
То есть вот такой запрос и в самом деле вернёт два объекта: mlg-leaf-0 и mlg-spine-0

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0&name=mlg-spine-0" -H "Accept: application/json; indent=4"

`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_or_operand.pcapng>`_.


Попробуем обратиться к несуществующему URL.

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/IDGAF/" -H "Accept: application/json; indent=4"

`Трамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_not_found.pcapng>`_.


HTTP POST
---------

POST используется для создания нового объекта в наборе объектов. Или более сложным языком: для создания нового подчинённого ресурса.
То есть, если есть набор devices, то POST позволяет создать новый объект device внутри devices. 

Выберем тот же Endpoint и с помощью POST создадим новое устройство.

    .. code-block:: bash

       
       curl -X POST "http://netbox.linkmeup.ru:45127/api/dcim/devices/" \
       -H "accept: application/json"\
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
       -d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3,       \"rack\": 3, \"position\": 5, \"face\": \"front\"}"

Здесь уже появляется заголовок **Authorization**, содержащий токен, который авторизует запрос на запись, а после директивы **-d** расположен JSON с параметрами создаваемого устройства:

    .. code-block:: bash

       
       {
           "name": "just a simple russian girl",
           "device_type": 1,
           "device_role": 1,
           "site": 3,
           "rack": 3,
           "position": 5,
           "face": "front"}

           .. figure:: https://fs.linkmeup.ru/images/adsm/3/post_result.png>`_

    Запрос у вас **не сработает**, потому что токен уже не валиден - не пытайтесь записать в мой NetBox.

В ответ приходит HTTP-ответ с кодом 201 (CREATED) и JSON'ом в теле сообщения, где сервер возвращает все параметры о созданном устройстве.

    .. code-block:: bash

       
       HTTP/1.1 201 Created
       Server: nginx/1.14.0 (Ubuntu)
       Date: Sat, 18 Jan 2020 11:00:22 GMT
       Content-Type: application/json
       Content-Length: 1123
       Connection: keep-alive
   
       JSON

`Дамп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_post_new_device.pcapng>`_.

Теперь новым запросом с методом GET можно его увидеть в выдаче:

    .. code-block:: bash

       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?q=russian" -H "Accept: application/json; indent=4"

    "q" в NetBox'е позволяет найти все объекты, содержащие в своём названии строку, идущую дальше.

POST, очевидно, не является **ни безопасным, ни идемпотентным** - он наверняка меняет данные, и дважды выполненный запрос приведёт или к созданию второго такого же объекта, или к ошибке.

HTTP PUT
--------

Это метод для изменения существующего объекта. Endpoint для PUT выглядит иначе, чем для POST - в нём теперь содержится конкретный объект.
PUT может возвращать коды 201 или 200.

Важный момент с этим методом: нужно передавать все обязательные атрибуты, поскольку PUT замещает собой старый объект.
Поэтому, если например, просто попытаться добавить атрибут asset_tag нашему новому устройству, то получим ошибку:

    .. code-block:: bash
       
              
       curl -X PUT "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
       -d "{ \"asset_tag\": \"12345678\"}"

Вот такую:

    .. code-block:: bash

       {"device_type":["This field is required."],"device_role":["This field is required."],"site":["This field is required."]}

Но если добавить недостающие поля, то всё сработает:

    .. code-block:: bash

       
       curl -X PUT "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
       -d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3,       \"rack\": 3, \"position\": 5, \"face\": \"front\", \"asset_tag\": \"12345678\"}"

`Трап транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_put_asset_tag.pcapng>`_.

Обратите внимание на URL здесь - теперь он включает ID устройства, которое мы хотим менять (**18**).

HTTP PATCH
----------

Этот метод используется для частичного изменения ресурса.
WAT? Спросите вы, а как же PUT?

PUT - изначально существовавший в стандарте метод, предполагающий полную замену изменяемого объекта. Соответственно в методе PUT, как я и писал выше, придётся указать даже те атрибуты объекта, которые не меняются.

А PATCH был добавлен позже и позволяет указать только те атрибуты, которые действительно меняются.

Например:

    .. code-block:: bash
       
       curl -X PATCH "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
       -d "{ \"serial\": \"BREAKINGBAD\"}"

Здесь также в URL указан ID устройства, но для изменения только один атрибут **serial**.

`Труп транзакции <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_patch_serial.pcapng>`_.

HTTP DELETE
-----------

Очевидно, удаляет объект.

Пример.

    .. code-block:: bash
       
       curl -X DELETE "http://netbox.linkmeup.ru:45127/api/dcim/devices/21/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"

Метод DELETE идемпотентен с той точки зрения, что повторно выполненный запрос уже ничего не меняет в списке ресурсов (но вернёт код 404 (NOT FOUND).

    .. code-block:: bash

       curl -X DELETE "http://netbox.linkmeup.ru:45127/api/dcim/devices/21/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"

    .. code-block:: bash

       {"detail":"Not found."}