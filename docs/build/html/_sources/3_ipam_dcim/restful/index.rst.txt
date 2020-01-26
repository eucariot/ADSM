Часть 3. RESTful API
====================

Эта статья - одна из обещанных коротких заметок по ходу <a href="https://linkmeup.ru/adsm/">АДСМ</a>.
Поскольку основным способом взаимодействия с NetBox будет RESTful API, я решил рассказать о нём отдельно. 

Воздаю хвалы архитекторам современного мира - у нас есть стандартизированные интерфейсы. Да их много - это минус, но они есть - это плюс.

Эти интерфейсы взаимодействия обрели имя **API - Application Programming Interface**.

Одним из таких интерфейсов является RESTful API, который мы будем использовать для работы с нашей IPAM/DCIM-системой в будущем.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/kdpv_rest.svg           
           :width: 800
           :align: center

Если очень просто, то API даёт клиенту набор инструментов, через которые тот может управлять сервером. А клиентом может выступать по сути что угодно: веб-браузер, командная консоль, разработанное производителем приложение, или вообще любое другое приложение, у которого есть доступ к API.

Например, в случае NetBox, добавить новое устройство в него можно следующими способами: через веб-браузер, отправив <a href="#CURL">curl'ом</a> запрос в консоли, использовать <a href="#POSTMAN">Postman</a>, обратиться к <a href="#REQUESTS">библиотеке requests</a> в питоне, воспользоваться <a href="#PYNETBOX">SDK pynetbox</a> или перейти в <a href="#SWAGGER">Swagger</a>.

Таким образом, один раз написав единый интерфейс, производитель навсегда освобождает себя от необходимости с каждым новым клиентом договариваться как его подключать (хотя, это самую малость лукавство).


.. toctree::
   :maxdepth: 2
   :caption: Дизайн сети:

   rest.rst
   messages.rst
   methods.rst
   ways.rst
   other.rst





Структура сообщений HTTP</h1>
HTTP-сообщение состоит из трёх частей, только первая из которых является обязательной. 
<ul>
    <li><a href="#REQUEST_LINE">Стартовая строка</a></li>
    <li><a href="#HEADERS">Заголовки</a></li>
    <li><a href="#BODY">Тело сообщения</a></li>
</ul>


Стартовая строка</h2>
Стартовые строки HTTP-запроса и ответа выглядят по-разному.

HTTP-Запрос</h4>
<code>METHOD URI HTTP_VERSION</code>
<blockquote>
    **Метод** определяет, какое действие клиент хочет совершить: получить данные, создать объект, обновить его, удалить.
    **URI** - идентификатор ресурса, куда клиент обращается или иными словами путь к ресурсу/документу.
    **HTTP_VERSION** - соответственно версия HTTP. На сегодняшний день для REST это всегда 1.1.
</blockquote>

Пример:
<code>GET /api/dcim/devices/1/ HTTP/1.1</code>

HTTP-Ответ</h4>
<code>HTTP_VERSION STATUS_CODE REASON_PHRASE</code>
<blockquote>
    **HTTP_VERSION** - версия HTTP (1.1).
    **STATUS_CODE** - три цифры кода состояния (200, 404, 502 итд)
    **REASON_PHRASE** - Пояснение (OK, NOT FOUND, BAD GATEWAY итд)
</blockquote>

Пример:
<code>HTTP/1.1 200 OK</code>



Заголовки</h2>
В заголовках передаются параметры данной HTTP-транзакции. 

Например, в примере выше в  HTTP-запросе это были:
<code>
    Host: netbox.linkmeup.ru:45127
    User-Agent: curl/7.54.0
    Accept: application/json; indent=4</code>

В них указано, что
<ol>
    <li>Обращаемся к хосту **netbox.linkmeup.ru:45127**,</li>
    <li>Запрос был сгенерирован в **curl**,</li>
    <li>А принимаем данные в формате **JSON** с отступом **4**.</li>
</ol>

А вот какие заголовки были в HTTP-ответе:
<code>
    Server: nginx/1.14.0 (Ubuntu)
    Date: Tue, 21 Jan 2020 15:14:22 GMT
    Content-Type: application/json
    Content-Length: 1638
    Connection: keep-alive</code>

В них указано, что
<ol>
    <li>Тип сервера: **nginx на Ubuntu**,</li>
    <li>Время формирования ответа,</li>
    <li>Формат данных в ответе: **JSON**</li>
    <li>Длина данных в ответе: **1638 байтов**</li>
    <li>Соединение не нужно закрывать - ещё будут данные.</li>
</ol>

Заголовки, как вы уже заметили, выглядят как пары имя:значение, разделённые знаком ":".

<a href="https://en.wikipedia.org/wiki/List_of_HTTP_header_fields" target="_blank">Полный список возможных заголовков</a>.


Тело HTTP-сообщения</h2>
Тело используется для передачи собственно данных.
В HTTP-ответе это может быть HTML-страничка, или в нашем случае JSON-объект.

Между заголовками и телом должна быть как минимум одна пустая строка.

При использовании метода GET в HTTP-запросе обычно никакого тела нет, потому что передавать нечего. Но тело есть в HTTP-ответе.
А вот например, при POST уже и в запросе будет тело. Давайте о методах и поговорим теперь.

Методы</h1>
Как вы уже поняли, для работы с WEB-сервисами HTTP использует методы. То же самое касается и RESTful API.
Возможные сценарии описываются термином **CRUD - Create, Read, Update, Delete**.
Вот список наиболее популярных методов HTTP, реализующих CRUD:

<ul>
    <li><a href="#GET">HTTP GET</a></li>
    <li><a href="#POST">HTTP POST</a></li>
    <li><a href="#PUT">HTTP PUT</a></li>
    <li><a href="#DELETE">HTTP DELETE</a></li>
    <li><a href="#PATCH">HTTP PATCH</a></li>
</ul>

Методы также называются **глаголами**, поскольку указывают на то, какое действие производится.

<a href="https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods" target="_blank">Полный список методов</a>.

Давайте на примере NetBox разберёмся с каждым из них.


HTTP GET</h2>
Это метод для получения информации.

Так, например, мы забираем список устройств:

<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/" -H "Accept: application/json; indent=4"</code>

Метод GET **безопасный** (**safe**), поскольку не меняет данные, а только запрашивает.
Он **идемпотентный** с той точки зрения, что один и тот же запрос всегда возвращает одинаковый результат (до тех пор, пока сами данные не поменялись).

На GET сервер возвращает сообщение с HTTP-кодом и телом ответа (**response code** и **response body**).
То есть если всё OK, то код ответа - 200 (OK).
Если URL не найден - 404 (NOT FOUND).
Если что-то не так с самим сервером или компонентами, это может быть 500 (SERVER ERROR) или 502 (BAD GATEWAY).
<a href="https://en.wikipedia.org/wiki/List_of_HTTP_status_codes" target="_blank">Все возможные коды ответов</a>.

Тело возвращается в формате JSON или XML.
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_all_devices.pcapng" target="_blank">Дамп транзакции</a>.


Давайте ещё пару примеров. Теперь мы запросим информацию по конкретному устройству по его имени.
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0" -H "Accept: application/json; indent=4"</code>
Здесь, чтобы задать условия поиска в URI я ещё указал атритбут объекта (параметр **name** и его значение **mlg-leaf-0**). Как вы можете видеть, перед условием и после слэша идёт знак **"?"**, а имя и значение разделяются знаком **"="**.

Так выглядит запрос.
<code>
    GET /api/dcim/devices/?name=mlg-leaf-0 HTTP/1.1
    Host: netbox.linkmeup.ru:45127
    User-Agent: curl/7.54.0
    Accept: application/json; indent=4</code>

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_by_name.pcapng" target="_blank">Дамп транзакции</a>.


Если нужно задать пару условий, то запрос будет выглядеть так:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?role=leaf&site=mlg" -H "Accept: application/json; indent=4"</code>
Здесь мы запросили все устройства с ролью **leaf**, расположенные на сайте **mlg**.
То есть два условия отделяются друг от друга знаком **"&"**.

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_double_conditions.pcapng" target="_blank">Дамп транзакции</a>.

Из любопытного и приятного - если через "&" задать два условия с одним именем, то между ними будет на самом деле не логическое "И", а логическое "ИЛИ".
То есть вот такой запрос и в самом деле вернёт два объекта: mlg-leaf-0 и mlg-spine-0
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0&name=mlg-spine-0" -H "Accept: application/json; indent=4"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_or_operand.pcapng" target="_blank">Дамп транзакции</a>.


Попробуем обратиться к несуществующему URL.

<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/IDGAF/" -H "Accept: application/json; indent=4"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_not_found.pcapng" target="_blank">Дамп транзакции</a>.


HTTP POST</h2>
POST используется для создания нового объекта в наборе объектов. Или более сложным языком: для создания нового подчинённого ресурса.
То есть, если есть набор devices, то POST позволяет создать новый объект device внутри devices. 

Выберем тот же Endpoint и с помощью POST создадим новое устройство.

<code>
curl -X POST "http://netbox.linkmeup.ru:45127/api/dcim/devices/" \
-H "accept: application/json"\
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3, \"rack\": 3, \"position\": 5, \"face\": \"front\"}"</code>
Здесь уже появляется заголовок **Authorization**, содержащий токен, который авторизует запрос на запись, а после директивы **-d** расположен JSON с параметрами создаваемого устройства:
<code>
{
    "name": "just a simple russian girl",
    "device_type": 1,
    "device_role": 1,
    "site": 3,
    "rack": 3,
    "position": 5,
    "face": "front"}</code>
    .. figure:: https://fs.linkmeup.ru/images/adsm/3/post_result.png" width="400">

<blockquote>
    Запрос у вас **не сработает**, потому что токен уже не валиден - не пытайтесь записать в мой NetBox.
</blockquote>

В ответ приходит HTTP-ответ с кодом 201 (CREATED) и JSON'ом в теле сообщения, где сервер возвращает все параметры о созданном устройстве.
<code>
    HTTP/1.1 201 Created
    Server: nginx/1.14.0 (Ubuntu)
    Date: Sat, 18 Jan 2020 11:00:22 GMT
    Content-Type: application/json
    Content-Length: 1123
    Connection: keep-alive

    JSON</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_post_new_device.pcapng">Дамп транзакции</a>.

Теперь новым запросом с методом GET можно его увидеть в выдаче:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?q=russian" -H "Accept: application/json; indent=4"</code>
<blockquote>
    "q" в NetBox'е позволяет найти все объекты, содержащие в своём названии строку, идущую дальше.
</blockquote>

POST, очевидно, не является **ни безопасным, ни идемпотентным** - он наверняка меняет данные, и дважды выполненный запрос приведёт или к созданию второго такого же объекта, или к ошибке.

HTTP PUT</h2>
Это метод для изменения существующего объекта. Endpoint для PUT выглядит иначе, чем для POST - в нём теперь содержится конкретный объект.
PUT может возвращать коды 201 или 200.

Важный момент с этим методом: нужно передавать все обязательные атрибуты, поскольку PUT замещает собой старый объект.
Поэтому, если например, просто попытаться добавить атрибут asset_tag нашему новому устройству, то получим ошибку:
<code>
curl -X PUT "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"asset_tag\": \"12345678\"}"</code>
Вот такую:
<code>{"device_type":["This field is required."],"device_role":["This field is required."],"site":["This field is required."]}</code>

Но если добавить недостающие поля, то всё сработает:
<code>
curl -X PUT "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3, \"rack\": 3, \"position\": 5, \"face\": \"front\", \"asset_tag\": \"12345678\"}"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_put_asset_tag.pcapng" target="_blank">Дамп транзакции</a>.

<blockquote>
Обратите внимание на URL здесь - теперь он включает ID устройства, которое мы хотим менять (**18**).
</blockquote>

HTTP PATCH</h2>
Этот метод используется для частичного изменения ресурса.
WAT? Спросите вы, а как же PUT?

PUT - изначально существовавший в стандарте метод, предполагающий полную замену изменяемого объекта. Соответственно в методе PUT, как я и писал выше, придётся указать даже те атрибуты объекта, которые не меняются.

А PATCH был добавлен позже и позволяет указать только те атрибуты, которые действительно меняются.

Например:
<code>
curl -X PATCH "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"serial\": \"BREAKINGBAD\"}"</code>

Здесь также в URL указан ID устройства, но для изменения только один атрибут **serial**.

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_patch_serial.pcapng" target="_blank">Дамп транзакции</a>.

HTTP DELETE</h2>
Очевидно, удаляет объект.

Пример.
<code>
curl -X DELETE "http://netbox.linkmeup.ru:45127/api/dcim/devices/21/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"</code>

Метод DELETE идемпотентен с той точки зрения, что повторно выполненный запрос уже ничего не меняет в списке ресурсов (но вернёт код 404 (NOT FOUND).

<code>
curl -X DELETE "http://netbox.linkmeup.ru:45127/api/dcim/devices/21/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"</code>
<code>
{"detail":"Not found."}</code>

Способы работы с RESTful API</h1>
Curl - это, конечно, очень удобно для доблестных воинов CLI, но есть инструменты получше:
<ul>
    <li><a href="#POSTMAN">Графическая утилита Postman</a></li>
    <li><a href="#REQUESTS">Библиотека requests в Python</a></li>
    <li><a href="#PYNETBOX">Python SDK для NetBox Pynetbox</a></li>
    <li><a href="#SWAGGER">API-фреймворк Swagger</a></li>
</ul>


Postman</h2>
Postman позволяет в графическом интерфейсе формировать запросы, выбирая методы, заголовки, тело, и отображает результат в удобочитаемом виде. 
Кроме того запросы и URI можно сохранять и возвращаться к ним позже. 

<a href="https://www.getpostman.com/downloads/" target="_blank">Скачать Postman на оф.сайте</a>.

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
<blockquote>
    Например, не пытайтесь через него отправить NETCONF XML, как это делал я на заре своей автоматизационной карьеры.
</blockquote>

Один из приятных бонусов <a href="#SWAGGER">специфицированного API</a> в том, что вы можете в Postman импортировать все эндпоинты и их методы как коллекцию.
Для этого в окне **Import** (File->Import) выберите **Import From Link** и вставьте в окно URL http://netbox.linkmeup.ru:45127/api/docs/?format=openapi.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_import.png" width="400">

Далее, всё, что только можно, вы найдёте в коллекциях.
    .. figure:: https://fs.linkmeup.ru/images/adsm/3/postman_collections.png" width="200">
<a name ="REQUESTS"></a>
Python+requests</h2>
Но даже через Postman вы, скорее всего, не будете управлять своими Production-системами. Наверняка, у вас будут внешние приложения, которые захотят без вашего участия взаимодействовать с ними.
Например, система генерации конфигурации захочет забрать список IP-интерфейсов из NetBox. 
В Python есть чудесная библиотека **requests**, которая реализует работу через HTTP.
Пример запроса списка всех устройств:

<code>
import requests

HEADERS = {'Content-Type': 'application/json', 'Accept': 'application/json'}
NB_URL = "http://netbox.linkmeup.ru:45127"

request_url = f"{NB_URL}/api/dcim/devices/"
devices = requests.get(request_url, headers = HEADERS)
print(devices.json())</code>

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_get_devices.py" target="_blank">Код скрипта на github</a>.

Снова добавим новое устройство:
<code>
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
print(new_device.json())</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_post_new_device.py" target="_blank">Код скрипта на github</a>.



Python+NetBox SDK</h3>
В случае NetBox есть также Python SDK - <a href="https://github.com/digitalocean/pynetbox" target="_blank">Pynetbox</a>, который представляет все Endpoint'ы NetBox в виде объекта и его атрибутов, делая за вас всю грязную работу по формированию URI и парсингу ответа, хотя и не бесплатно, конечно.

Например, сделаем то же, что и выше, использую pynetbox.
Список всех устройств:
<code>
import pynetbox

NB_URL = "http://netbox.linkmeup.ru:45127"
nb = pynetbox.api(NB_URL)

devices = nb.dcim.devices.all()
print(devices)</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/pynetbox_get_devices.py" target="_blank">Код скрипта на github</a>.

Добавить новое устройство:
<code>
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
print(new_device)</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/scripts/requests_post_new_device.py" target="_blank">Код скрипта на github</a>.

<a href="https://pynetbox.readthedocs.io/en/latest/" target="_blank">Документация по Pynetbox</a>.


SWAGGER</h2>
За что ещё стоит поблагодарить ушедшее десятилетие, так это за спецификации API. Если вы перейдёте по <a href="http://netbox.linkmeup.ru:45127/api/docs/" target="_blank">этому пути</a>, то попадёте в Swagger UI - документацию по API Netbox.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger.png           
           :width: 800
           :align: center

На этой странице перечислены все Endpoint'ы, методы работы с ними, возможные параметры и атрибуты и указано, какие из них обязательны. Кроме того описаны ожидаемые ответы. 

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger_endpoints_and_methods.png           
           :width: 800
           :align: center

На этой же странице можно выполнять интерактивные запросы, кликнув на **Try it out**.

<blockquote>
По какой-от причине swagger в качестве Base URL берёт имя сервера без порта, поэтому функция Try it out не работает в моих примерах со Swagger'ом. Но вы можете попробовать это на собственной инсталляции.
</blockquote>

При нажатии на **Execute** Swagger UI сформирует строку curl, с помощью которой можно аналогичный запрос сделать из командной строки.

В Swagger UI можно даже создать объект:
    .. figure:: https://fs.linkmeup.ru/images/adsm/3/swagger_post.png           
           :width: 800
           :align: center

Для этого достаточно быть авторизованным пользователем, обладающим нужными правами.

То, что мы видим на этой странице - это Swagger UI - документация, сгенерированная на основе спецификации API.

С трендами на микросервисную архитектуру всё более важным становится иметь стандартизированный API для взаимодействия между компонентами, эндпоинты и методы которого легко определить как человеку, так и приложению, не роясь в исходном коде или PDF-документации.
Поэтому разработчики сегодня всё чаще следуют парадигме <a href="https://medium.com/adobetech/three-principles-of-api-first-design-fa6666d9f694" target="_blank">API First</a>, когда сначала задумываются об API, а уже потом о реализации. 
В этом дизайне сначала специфицируется API, а затем из него **генерируются** документация, клиентское приложение, серверная часть и необходимы тесты.

Swagger - это фреймворк и язык спецификации (который ныне переименован в OpenAPI 2.0), позволяющие реализовать эту задачу.
Углубляться в него я не буду. 
За бо́льшими деталями сюда:
<ul>
    <li><a href="https://swagger.io/docs/specification/">Сайт Swagger</a></li>
    <li><a href="https://justcodeit.ru/swagger-docs-dlya-api-na-laravel/">Пример использования</a></li>
    <li><a href="https://en.wikipedia.org/wiki/OpenAPI_Specification">Wiki проOpen API</a></li>
</ul>

Критика REST и альтернативы</h1>
Существует и такая, да. Не всё в том мире 2000-го года так уже радужно.
Не являясь экспертом, не берусь предметно раскрывать вопрос, но дам ссылку на небесспорную <a href="https://habr.com/ru/post/265845/" target="_blank">статью на хабре</a>.
Альтернативным интерфейсом взаимодействия компонентов системы сегодня является gRPC. Ему же пророчат большое будущее на ниве новых подходов к работе с сетевым оборудованием. Но о нём мы поговорим когда-то в будущем, когда придёт его черёд.
<blockquote>
    **Важно**
    Токен a9aae70d65c928a554f9a038b9d4703a1583594f был использован только в демонстрационных целях и больше не работает.
    Прямое указание токенов в коде программы недопустимо и сделано здесь мной только в интересах упрощения примеров.
</blockquote>

Полезные ссылки</h1>
<ul>
    <li><a href="https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm" target="_blank">Доклад Роя Филдинга: Representational State Transfer (REST)</a></li>
    <li><a href="https://medium.com/adobetech/three-principles-of-api-first-design-fa6666d9f694" target="_blank">Three Principles of API First Design</a></li>
    <li><a href="https://restfulapi.net/http-methods/" target="_blank">HTTP-методы</a></li>
    <li><a href="https://restfulapi.net/rest-architectural-constraints/" target="_blank">REST Architectural Constraints</a></li>
    <li><a href="https://swagger.io/docs/specification/" target="_blank">Сайт Swagger</a></li>
    <li><a href="https://justcodeit.ru/swagger-docs-dlya-api-na-laravel/" target="_blank">Пример использования Swagger</a></li>
    <li><a href="https://en.wikipedia.org/wiki/OpenAPI_Specification" target="_blank">Wiki про OpenAPI</a></li>
    <li><a href="https://habr.com/ru/post/265845/" target="_blank">Критика REST</a></li>
</ul>

Спасибы</h1>
<ul>
    <li>Андрею Панфилову за вычитку и правки</li>
</ul>

<blockquote>Оставайтесь на связи</h5>
<a href="https://linkmeup.ru/rss">    .. figure:: https://linkmeup.ru/templates/skin/synio/images/RSS.png" title="RSS сайта"></a><a href="mailto:info@linkmeup.ru">    .. figure:: https://linkmeup.ru/templates/skin/synio/images/Email.png" title="Написать авторам"></a><a href="https://vk.com/linkmeup">    .. figure:: https://linkmeup.ru/templates/skin/synio/images/vk1.png" title="linkmeup вконтакте"></a><a href="https://www.facebook.com/linkmeup.sdsm">    .. figure:: https://linkmeup.ru/templates/skin/synio/images/Facebook.png" title="linkmeup на Фейсбуке"></a><a href="https://www.patreon.com/linkmeup">    .. figure:: https://linkmeup.ru/templates/skin/synio/images/patreon.png" width="25" title=" Поддержать linkmeup на Patreon"></a>

Особо благодарных просим задержаться и пройти на Патреон.
<a href="https://www.patreon.com/linkmeup?ty=h" target="_blank">    .. figure:: https://fs.linkmeup.ru/images/patreon.jpg" width="400"></a></blockquote>