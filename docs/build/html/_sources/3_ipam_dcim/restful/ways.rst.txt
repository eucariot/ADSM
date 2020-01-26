Способы работы с RESTful API
============================

Curl - это, конечно, очень удобно для доблестных воинов CLI, но есть инструменты получше:
* Графическая утилита Postman
* Библиотека requests в Python
* Python SDK для NetBox Pynetbox
* API-фреймворк Swagger


Postman
-------

Postman позволяет в графическом интерфейсе формировать запросы, выбирая методы, заголовки, тело, и отображает результат в удобочитаемом виде. 
Кроме того запросы и URI можно сохранять и возвращаться к ним позже. 

`Скачать Postman на оф.сайте <https://www.getpostman.com/downloads/>`_.

Так мы можем сделать GET:

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_get.png           
           :width: 800
           :align: center

*Здесь указан Token в GET только для примера.*

А так POST:

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_post.png           
           :width: 800
           :align: center

Postman служит только для работы с RESTful API.

    Например, не пытайтесь через него отправить NETCONF XML, как это делал я на заре своей автоматизационной карьеры.

Один из приятных бонусов специфицированного API в том, что вы можете в Postman импортировать все эндпоинты и их методы как коллекцию.
Для этого в окне **Import** (File->Import) выберите **Import From Link** и вставьте в окно URL http://netbox.linkmeup.ru:45127/api/docs/?format=openapi.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_import.png
           :width: 400
           :align: center


Далее, всё, что только можно, вы найдёте в коллекциях.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_collections.png
           :width: 200
           :align: center

Python+requests
---------------

Но даже через Postman вы, скорее всего, не будете управлять своими Production-системами. Наверняка, у вас будут внешние приложения, которые захотят без вашего участия взаимодействовать с ними.
Например, система генерации конфигурации захочет забрать список IP-интерфейсов из NetBox. 
В Python есть чудесная библиотека **requests**, которая реализует работу через HTTP.
Пример запроса списка всех устройств:

    .. code-block:: bash
    
       import requests
       
       HEADERS = {'Content-Type': 'application/json', 'Accept': 'application/json'}
       NB_URL = "http://netbox.linkmeup.ru:45127"
       
       request_url = f"{NB_URL}/api/dcim/devices/"
       devices = requests.get(request_url, headers = HEADERS)
       print(devices.json())

`Код скрипта на github <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_get_devices.py>`_.

Снова добавим новое устройство:

    .. code-block:: bash
    
       import requests

       API_TOKEN = "a9aae70d65c928a554f9a038b9d4703a1583594f"
       HEADERS = {'Authorization': f'Token {API_TOKEN}', 'Content-Type': 'application/json', 'Accept': 'application/json'}
       NB_URL = "http://netbox.linkmeup.ru:45127"

       request_url = f"{NB_URL}/api/dcim/devices/"

       device_parameters = {
           "name": "just a simple REQUESTS girl", 
           "device_type": 1, 
           "device_role": 1, 
           "site": 3, 
       }
       new_device = requests.post(request_url, headers = HEADERS, json=device_parameters)
       print(new_device.json())

`Код скрипта на github <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_post_new_device.py>`_.

Python+NetBox SDK
-----------------

В случае NetBox есть также Python SDK - `Pynetbox <https://github.com/digitalocean/pynetbox>`_, который представляет все Endpoint'ы NetBox в виде объекта и его атрибутов, делая за вас всю грязную работу по формированию URI и парсингу ответа, хотя и не бесплатно, конечно.

Например, сделаем то же, что и выше, использую pynetbox.
Список всех устройств:

    .. code-block:: bash
    
       import pynetbox

       NB_URL = "http://netbox.linkmeup.ru:45127"
       nb = pynetbox.api(NB_URL)

       devices = nb.dcim.devices.all()
       print(devices)

`Кот скрипта на github <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/pynetbox_get_devices.py>`_.

Добавить новое устройство:

    .. code-block:: bash
    
       import pynetbox

       API_TOKEN = "a9aae70d65c928a554f9a038b9d4703a1583594f"
       NB_URL = "http://netbox.linkmeup.ru:45127"
       nb = pynetbox.api(NB_URL, token = API_TOKEN)

       device_parameters = {
           "name": "just a simple PYNETBOX girl", 
           "device_type": 1, 
           "device_role": 1, 
           "site": 3, 
       }
       new_device = nb.dcim.devices.create(**device_parameters)
       print(new_device)

`Скот скрипта на github <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_post_new_device.py>`_.

`Документация по Pynetbox <https://pynetbox.readthedocs.io/en/latest/>`_.


SWAGGER
---------

За что ещё стоит поблагодарить ушедшее десятилетие, так это за спецификации API. Если вы перейдёте по `этому пути <http://netbox.linkmeup.ru:45127/api/docs/>`_, то попадёте в Swagger UI - документацию по API Netbox.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger.png           
           :width: 800
           :align: center

На этой странице перечислены все Endpoint'ы, методы работы с ними, возможные параметры и атрибуты и указано, какие из них обязательны. Кроме того описаны ожидаемые ответы. 

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger_endpoints_and_methods.png           
           :width: 800
           :align: center

На этой же странице можно выполнять интерактивные запросы, кликнув на **Try it out**.

По какой-от причине swagger в качестве Base URL берёт имя сервера без порта, поэтому функция Try it out не работает в моих примерах со Swagger'ом. Но вы можете попробовать это на собственной инсталляции.

При нажатии на **Execute** Swagger UI сформирует строку curl, с помощью которой можно аналогичный запрос сделать из командной строки.

В Swagger UI можно даже создать объект:

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger_post.png           
           :width: 800
           :align: center

Для этого достаточно быть авторизованным пользователем, обладающим нужными правами.

То, что мы видим на этой странице - это Swagger UI - документация, сгенерированная на основе спецификации API.

С трендами на микросервисную архитектуру всё более важным становится иметь стандартизированный API для взаимодействия между компонентами, эндпоинты и методы которого легко определить как человеку, так и приложению, не роясь в исходном коде или PDF-документации.
Поэтому разработчики сегодня всё чаще следуют парадигме `API First <https://medium.com/adobetech/three-principles-of-api-first-design-fa6666d9f694>`_, когда сначала задумываются об API, а уже потом о реализации. 
В этом дизайне сначала специфицируется API, а затем из него **генерируются** документация, клиентское приложение, серверная часть и необходимы тесты.

Swagger - это фреймворк и язык спецификации (который ныне переименован в OpenAPI 2.0), позволяющие реализовать эту задачу.
Углубляться в него я не буду. 
За бо́льшими деталями сюда:
* `Сайт Swagger <https://swagger.io/docs/specification/>`_
* `Пример использования <https://justcodeit.ru/swagger-docs-dlya-api-na-laravel/>`_
* `Wiki про Open API <https://en.wikipedia.org/wiki/OpenAPI_Specification>`_