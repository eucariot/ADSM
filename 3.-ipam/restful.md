Эта статья - одна из обещанных коротких заметок по ходу <a href="https://linkmeup.ru/adsm/">АДСМ</a>.
Поскольку основным способом взаимодействия с NetBox будет RESTful API, я решил рассказать о нём отдельно. 

<hr>
Воздаю хвалы архитекторам современного мира - у нас есть стандартизированные интерфейсы. Да их много - это минус, но они есть - это плюс.

Эти интерфейсы взаимодействия обрели имя API - Application Programming Interface.

Одним из таких интерфейсов является RESTful API, который и используется для работы с NetBox.

Если очень просто, то API даёт клиенту набор инструментов, через которые тот может управлять сервером. А клиентом может выступать по сути что угодно - веб-браузер, командная консоль, разработанное производителем приложение, или вообще любое другое приложение, у которого есть доступ к API.

Например, в случае NetBox, добавить новое устройство в него можно через веб-браузер, отправив <a href="#CURL">curl'ом</a> запрос в консоли, использовать <a href="#POSTMAN">Postman</a>, обратиться к <a href="#REQUESTS">библиотеке requests</a> в питоне, воспользоваться <a href="#PYNETBOX">SDK pynetbox</a> или перейти в <a href="#SWAGGER">Swagger</a>.

Таким образом, один раз написав единый интерфейс, производитель навсегда освобождает себя от необходимости с каждым новым клиентом договариваться как его подключать (хотя, это самую малость лукавство).

<h1>Содержание</h1>
<ul>
    <li><a href="#RESTX">REST, RESTful, API</a></li>
    <li><a href="#STRUCTURE">Структура сообщений HTTP</a>
    <ul>
        <li><a href="#REQUEST_LINE">Стартовая строка</a></li>
        <li><a href="#HEADERS">Заголовки</a></li>
        <li><a href="#BODY">Тело HTTP-сообщения</a></li>
    </ul>
    </li>
    <li><a href="#METHODS">Методы</a>
    <ul>
        <li><a href="#GET">HTTP GET</a></li>
        <li><a href="#POST">HTTP POST</a></li>
        <li><a href="#PUT">HTTP PUT</a></li>
        <li><a href="#PATCH">HTTP PATCH</a></li>
        <li><a href="#DELETE">HTTP DELETE</a></li>
    </ul>
    </li>
    <li><a href="#WAYS">Способы работы с RESTful API</a>
    <ul>
        <li><a href="#CURL">CURL</a></li>
        <li><a href="#POSTMAN">Postman</a></li>
        <li><a href="#REQUESTS">Python+Requests</a></li>
        <li><a href="#PYNETBOX">SDK Pynebtbox</a></li>
        <li><a href="#SWAGGER">SWAGGER</a></li>
    </ul>
    </li>
    <li><a href="#OTHERS">Критика REST и альтернативы</a></li>
    <li><a href="#LINKS">Полезные ссылки</a></li>
</ul>


<a name="RESTX"></a>
<h1>REST, RESTful, API</h1>
Ниже я дам очень упрощённое описание того, что такое REST. 

Начнём с того, что <b>RESTful API</b> - это именно <b>интерфейс</b> взаимодействия, основанный на REST, в то время как сам <b>REST</b> (<b>REpresentational State Transfer</b>) - это набор ограничений, используемых для создания WEB-сервисов.
О каких именно ограничениях идёт речь, можно почитать в <a href="https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm" target="_blank">главе 5 диссертации Роя Филдинга Architectural Styles and the Design of Network-based Software Architectures</a>. Мне же позвольте привести только три наиболее значимых (с моей точки зрения) из них:

<ol>
    <li>Модель взаимодействия Клиент-Сервер. </li>
    <li>Каждый REST-запрос содержит всю информацию, необходимую для его выполнения. То есть сервер не должен помнить ничего о предыдущих запросах клиента, что, как известно, характеризуется словом Sateless - не храним информацию о состоянии. </li>
    <li>Единый интерфейс. Реализация приложения отделена от сервиса, который оно предоставляет. То есть пользователь знает, что оно делает и как с ним взаимодействовать, но как именно оно это делает не имеет значения. При изменении приложения, интерфейс остаётся прежним, и клиентам не нужно подстраиваться.</li>
</ol>

WEB-сервисы, удовлетворяющие всем принципам REST, называются <b>RESTful WEB-services</b>.
А API, который предоставляют RESTful WEB-сервисы, называется RESTful API.


REST - не протокол, а, так называемый, стиль архитектуры (один из). Развиваемому вместе с HTTP Роем Филдингом, REST'у было предназначено использовать <b>HTTP 1.1</b>, в качестве транспорта.
Адрес сервера - это привычный нам <b>URI</b>.
Формат передаваемых данных - <b>XML</b> или <b>JSON</b>.

<blockquote>
    Для этой серии статей на linkmeup развёрнута read-only (для вас, дорогие, читатели) инсталляция <a href="http://netbox.linkmeup.ru:45127" target="_blank">NetBox</a>: http://netbox.linkmeup.ru:45127.
    На чтение права не требуются, но если хочется попробовать читать с токеном, то можно воспользоваться этим: API Token: 90a22967d0bc4bdcd8ca47ec490bbf0b0cb2d9c8
</blockquote>


Давайте интереса ради сделаем один запрос:
<code>
curl -X GET -H "Authorization: TOKEN 90a22967d0bc4bdcd8ca47ec490bbf0b0cb2d9c8" \
-H "Accept: application/json; indent=4" \
http://netbox.linkmeup.ru:45127/api/dcim/devices/1/</code>

То есть утилитой <b>curl</b> мы делаем <b>GET</b> объекта по адресу <b>http://netbox.linkmeup.ru:45127/api/dcim/devices/1/</b> с ответом в формате <b>JSON</b> и отступом в <b>4</b> пробела.
Его можете выполнить и вы - просто скопируйте себе в терминал.

<blockquote>
    URL, к которому мы обращаемся в запросе, называется <b>Endpoint</b>. В некотором смысле это конечный объект, с которым мы будем взаимодействовать.
    Например, в случае netbox'а список всех endpoint'ов можно получить <a href="http://netbox.linkmeup.ru:45127/api/docs/" target="_blank">тут</a>.
</blockquote>


<div class="spoiler"><b class="spoiler_title">Вот что мы получим в ответ:...</b><div class="spoiler_text" style="display: none;">
<code>
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
</code>
</div></div>

Это JSON (как мы и просили), описывающий device с ID 1: как называется, с какой ролью, какой модели, где стоит итд.

Так будет выглядеть HTTP-запрос:
<code>
    GET /api/dcim/devices/1/ HTTP/1.1
    Host: netbox.linkmeup.ru:45127
    User-Agent: curl/7.54.0
    Accept: application/json; indent=4</code>

Так будет выглядеть ответ:
<code>
    HTTP/1.1 200 OK
    Server: nginx/1.14.0 (Ubuntu)
    Date: Tue, 21 Jan 2020 15:14:22 GMT
    Content-Type: application/json
    Content-Length: 1638
    Connection: keep-alive
    
    Data</code>

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_devices.pcapng" target="_blank">Дамп транзакции</a>.

А теперь разберёмся, что же мы натворили.
<hr>

<a name="STRUCTURE"></a>
<h1>Структура сообщений HTTP</h1>
HTTP-сообщение состоит из трёх частей, только первая из которых является обязательной. 
<ul>
    <li><a href="#REQUEST_LINE">Стартовая строка</a></li>
    <li><a href="#HEADERS">Заголовки</a></li>
    <li><a href="#BODY">Тело сообщения</a></li>
</ul>

<a name="REQUEST_LINE"></a>
<h2>Стартовая строка</h2>
Стартовые строки HTTP-запроса и ответа выглядят по-разному.

<h4>HTTP-Запрос</h4>
<code>
METHOD URI HTTP_VERSION</code>
<blockquote>
    <b>Метод</b> определяет, какое действие клиент хочет совершить: получить данные, создать объект, обновить его, удалить.
    <b>URI</b> - идентификатор ресурса, куда клиент обращается или иными словами путь к ресурсу/документу.
    <b>HTTP_VERSION</b> - соответственно версия HTTP. На сегодняшний день для REST это всегда 1.1.
</blockquote>

Пример:
<code>
GET /api/dcim/devices/1/ HTTP/1.1</code>

<h4>HTTP-Ответ</h4>
<code>
HTTP_VERSION STATUS_CODE REASON_PHRASE</code>
<blockquote>
    <b>HTTP_VERSION</b> - версия HTTP.
    <b>STATUS_CODE</b> - три цифры кода состояния (200, 404, 502 итд)
    <b>REASON_PHRASE</b> - Пояснение (OK, NOT FOUND, BAD GATEWAY итд)
</blockquote>

Пример:
<code>
HTTP/1.1 200 OK</code>


<a name="HEADERS"></a>
<h2>Заголовки</h2>
В заголовках передаются параметры данной HTTP-транзакции. 

Например, в примере выше в  HTTP-запросе это были:
<code>
    Host: netbox.linkmeup.ru:45127
    User-Agent: curl/7.54.0
    Accept: application/json; indent=4</code>

В них указано, что
<ol>
    <li>Обращаемся к хосту <b>netbox.linkmeup.ru:45127</b>,</li>
    <li>Запрос был сгенерирован в <b>curl</b>,</li>
    <li>Для авторизации использован Token <b>90a22967d0bc4bdcd8ca47ec490bbf0b0cb2d9c8</b>,</li>
    <li>А принимаем данные в формате <b>JSON</b> с отступом <b>4</b>.</li>
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
    <li>Тип сервера: <b>nginx на Ubuntu</b>,</li>
    <li>Время формирования ответа,</li>
    <li>Формат данных в ответе: <b>JSON</b></li>
    <li>Длина ответа: <b>1638 байтов</b></li>
    <li>Соединение не нужно закрывать - ещё будут данные.</li>
</ol>

Заголовки, как вы уже заметили, выглядят как пары имя:значение, разделённые знаком ":".

<a href="https://en.wikipedia.org/wiki/List_of_HTTP_header_fields" target="_blank">Полный список заголовков</a>.

<a name="BODY"></a>
<h2>Тело HTTP-сообщения</h2>
Тело используется для передачи собственно данных.
В HTTP-ответе это может быть HTML страничка, или в нашем случае JSON-объект.

Между заголовками и телом должна быть как минимум одна пустая строка.

При использовании метода GET в HTTP-запросе обычно никакого тела нет, потому что передавать нечего. Но тело есть в HTTP-ответе.
А вот например, при POST уже и в запросе будет тело. Давайте о методах и поговорим теперь.
<hr>
<a name="METHODS"></a>
<h1>Методы</h1>
Как вы уже поняли, для работы с WEB-сервисами HTTP использует методы. То же самое касается и RESTful API.
Возможные сценарии описываются термином <b>CRUD - Create, Retrieve, Update, Delete</b>.
Вот список наиболее популярных методов HTTP, реализующих CRUD:

<ul>
    <li><a href="#GET">HTTP GET</a></li>
    <li><a href="#POST">HTTP POST</a></li>
    <li><a href="#PUT">HTTP PUT</a></li>
    <li><a href="#DELETE">HTTP DELETE</a></li>
    <li><a href="#PATCH">HTTP PATCH</a></li>
</ul>

Методы также называются <b>глаголами</b>, поскольку указывают на то, какое действие производится.

<a href="https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods" target="_blank">Полный список методов</a>.

Давайте на примере NetBox разберёмся с каждым из них.

<a name="GET"></a>
<h2>HTTP GET</h2>
Это метод для получения информации.

Так мы забираем список устройств:

<code>
curl -H "Authorization: TOKEN 90a22967d0bc4bdcd8ca47ec490bbf0b0cb2d9c8" \
-H "Accept: application/json; indent=4" \
http://netbox.linkmeup.ru:45127/api/dcim/devices/ </code>

Метод GET <b>безопасный</b> (<b>safe</b>), поскольку не меняет данные, а только запрашивает.
Он <b>идемпотентный</b> с той точки зрения, что один и тот же запрос всегда возвращает одинаковый результат (до тех пор, пока сами данные не поменялись).

На GET сервер возвращает сообщение с HTTP-кодом и телом ответа (<b>response code</b> и <b>response body</b>).
То есть если всё OK, то код ответа - 200 (OK).
Если URL не найден - 404 (NOT FOUND).
Если что-то не так с самим сервером или компонентами, это может быть 500 (SERVER ERROR) или 502 (BAD GATEWAY).

Тело возвращается в формате JSON или XML.
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_all_devices.pcapng" target="_blank">Дамп транзакции</a>.


Давайте ещё пару примеров. Теперь мы запросим информацию по конкретному устройству по его имени.
<code>
curl -X GET -H "Accept: application/json; indent=4" \
"http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0"</code>
Здесь, чтобы задать условия поиска в URI я ещё указал атритбут объекта (параметр <b>name</b> и его значение <b>mlg-leaf-0</b>). Как вы можете видеть, перед условием и после слэша идёт знак "?", а имя и значение разделяются знаком "=".

Так выглядит запрос.
<code>
    GET /api/dcim/devices/?name=mlg-leaf-0 HTTP/1.1
    Host: netbox.linkmeup.ru:45127
    User-Agent: curl/7.54.0
    Accept: application/json; indent=4</code>

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_by_name.pcapng" target="_blank">Дамп транзакции</a>.


Если нужно задать пару условий, то запрос будет выглядеть так:
<code>
curl -X GET -H "Accept: application/json; indent=4" \
"http://netbox.linkmeup.ru:45127/api/dcim/devices/?role=leaf&site=mlg"</code>
Здесь мы запросили все устройства с ролью <b>leaf</b>, расположенные на сайте <b>mlg</b>.
То есть два условия отделяются друг от друга знаком "&".

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_double_conditions.pcapng" target="_blank">Дамп транзакции</a>.

Из любопытного и приятного - если через "&" задать два условия с одним значением, то между ними будет на самом деле не логическое "И", а логическое "ИЛИ".
То есть вот такой запрос и в самом деле вернёт два объекта: mlg-leaf-0 и mlg-spine-0
<code>
curl -X GET -H "Accept: application/json; indent=4" \
"http://netbox.linkmeup.ru:45127/api/dcim/devices/?name=mlg-leaf-0&name=mlg-spine-0"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_device_with_or_operand.pcapng" target="_blank">Дамп транзакции</a>.


Попробуем обратиться к несуществующему URL.

<code>
curl -X GET -H "Accept: application/json; indent=4" \
"http://netbox.linkmeup.ru:45127/api/dcim/IDGAF/"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_get_not_found.pcapng" target="_blank">Дамп транзакции</a>.

<a name="POST"></a>
<h2>HTTP POST</h2>
POST используется для создания нового объекта в наборе объектов. Или более сложным языком: для создания нового подчинённого ресурса.
То есть, если есть набор devices, то POST позволяет создать новый объект device внутри devices. 

Выберем тот же Endpoint !!! и с помощью POST создадим новое устройство.

<code>
curl -X POST "http://netbox.linkmeup.ru:45127/api/dcim/devices/" \
-H "accept: application/json"\
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3, \"rack\": 3, \"position\": 5, \"face\": \"front\"}"</code>
Здесь уже появляется Token, который авторизует запрос на запись, а после директивы <b>-d</b> расположен JSON с параметрами создаваемого устройства:
<code>
{
    "name": "just a simple russian girl",
    "device_type": 1,
    "device_role": 1,
    "site": 3,
    "rack": 3,
    "position": 5,
    "face": "front"}</code>

<blockquote>
    Запрос у вас не сработает, потому что Токен уже не валиден - не пытайтесь записать в мой NetBox!
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
<code>
curl -X GET -H "Accept: application/json; indent=4" \
"http://netbox.linkmeup.ru:45127/api/dcim/devices/?q=russian"</code>
<blockquote>
    "q" в NetBox'е позволяет найти все объекты, содержание в своём названии строку, идущую дальше.
</blockquote>

POST не является ни безопасным, ни идемпотентным - он наверняка меняет данные, и дважды выполненный запрос приведёт или к созданию второго такого же объекта, или к ошибке.

<a name="PUT"></a>
<h2>HTTP PUT</h2>
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
<code>
{"device_type":["This field is required."],"device_role":["This field is required."],"site":["This field is required."]}</code>

Но если добавить недостающие поля, то всё сработает:
<code>
curl -X PUT "http://netbox.linkmeup.ru:45127/api/dcim/devices/18/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{ \"name\": \"just a simple russian girl\", \"device_type\": 1, \"device_role\": 1, \"site\": 3, \"rack\": 3, \"position\": 5, \"face\": \"front\", \"asset_tag\": \"12345678\"}"</code>
<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_put_asset_tag.pcapng" target="_blank">Дамп транзакции</a>.

<blockquote>
Обратите внимание на URL здесь - теперь он включает ID устройства, которое мы хотим менять (<b>18</b>).
</blockquote>


<a name="PATCH"></a>
<h2>HTTP PATCH</h2>
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

Здесь также в URL указан ID устройства, но для изменения только один атрибут <b>serial</b>.

<a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/dumps/http_patch_serial.pcapng" target="_blank">Дамп транзакции</a>.

<a name="DELETE"></a>
<h2>HTTP DELETE</h2>
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
{"detail":"Not found."}%</code>
<hr>
<a name="WAYS"></a><a name="CURL"></a>
<h1>Способы работы с RESTful API</h1>
Curl - это, конечно, очень удобно для доблестных воинов CLI, но есть инструменты получше.

<a name="POSTMAN"></a>
<h2>Postman</h2>
Postman позволяет в графическом интерфейсе формировать запросы, выбирая методы, заголовки, тело, и отображает результат в удобочитаемом виде. 
Кроме того запросы и URI можно сохранять и возвращаться к ним позже. 

<a href="https://www.getpostman.com/downloads/" target="_blank">Скачать Postman на оф.сайте</a>.

Так мы можем сделать GET:
<img src="https://fs.linkmeup.ru/images/adsm/3/postman_get.png" width="800">
<i>Здесь указан Token в GET только для примера</i>

А так POST:
<img src="https://fs.linkmeup.ru/images/adsm/3/postman_post.png" width="800">

Postman служит только для работы с RESTful API.
<blockquote>
    Например, не пытайтесь через него отправить NETCONF XML, как это делал я на заре своей автоматизационной карьеры.
</blockquote>

Один из приятных бонусов <a href="#SWAGGER">специфицированного API</a> в том, что вы можете в Postman импортировать все эндпоинты и их методы как коллекцию.
Для этого в окне <b>Import</b> (File->Import) выберите <b>Import From Link</b> и вставьте в окно URL http://netbox.linkmeup.ru:45127/api/docs/?format=openapi.

<img src="https://fs.linkmeup.ru/images/adsm/3/postman_import.png" width="400">

Далее, всё, что только можно, вы найдёте в коллекциях.
<img src="https://fs.linkmeup.ru/images/adsm/3/postman_collections.png" width="250">

<a name ="REQUESTS"></a>
<h2>Python+requests</h2>
Но даже через Postman вы, скорее всего, не будете управлять своими Production-системами. Наверняка, у вас будут внешние приложения, которые захотят без вашего участия взаимодействовать с ними.
Например, система генерации конфигурации захочет забрать список IP-интерфейсов из NetBox. 
В Python есть чудесная библиотека requests, которая реализует работу через HTTP.
Пример запроса списка всех устройств:

<code>
import requests

HEADERS = {'Content-Type': 'application/json', 'Accept': 'application/json'}
NB_URL = "http://netbox.linkmeup.ru:45127"

request_url = f"{NB_URL}/api/dcim/devices/"
devices = requests.get(request_url, headers = HEADERS)
print(devices.json())</code>

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

<a name="PYNETBOX"></a>
<h3>Python+NetBox SDK</h3>
В случае NetBox есть также Python SDK - <a href="https://github.com/digitalocean/pynetbox" target="_blank">Pynetbox</a>, который представляет все Endpoint'ы NetBox в виде объекта и его атрибутов, делая за вас всю грязную работу по формированию URI и парсингу ответа, хотя и не бесплатно, конечно.

Например, сделаем то же, что и выше, использую pynetbox.
Список всех устройств:
<code>
import pynetbox

NB_URL = "http://netbox.linkmeup.ru:45127"

nb = pynetbox.api(
        NB_URL
    )

devices = nb.dcim.devices.all()
print(devices)</code>

Добавить новое устройство:
<code>
import pynetbox

API_TOKEN = "a9aae70d65c928a554f9a038b9d4703a1583594f"
NB_URL = "http://netbox.linkmeup.ru:45127"

nb = pynetbox.api(
        NB_URL,
        token = API_TOKEN
    )

device_parameters = {
    "name": "just a simple PYNETBOX girl", 
    "device_type": 1, 
    "device_role": 1, 
    "site": 3, 
}
new_device = nb.dcim.devices.create(**device_parameters)
print(new_device)</code>

<a href="https://pynetbox.readthedocs.io/en/latest/" target="_blank">Документация по Pynetbox</a>.

<a name="SWAGGER"></a>
<h2>SWAGGER</h2>
За что ещё стоит поблагодарить ушедшее десятилетие, так это за спецификации API. Если вы перейдёте по <a href="http://netbox.linkmeup.ru:45127/api/docs/" target="_blank">этому пути</a>, то попадёте в Swagger UI - документацию по API.

<img src="https://fs.linkmeup.ru/images/adsm/3/swagger.png" width="800">

На этой странице перечислены все Endpoint'ы, методы работы с ними, возможные параметры и атрибуты и указано, какие из них обязательны. Кроме того описаны ожидаемые ответы. 

<img src="https://fs.linkmeup.ru/images/adsm/3/swagger_endpoints_and_methods.png" width="800">

На этой же странице можно выполнять интерактивные запросы, кликнув на <b>Try it out</b>.

<blockquote>
По какой-от причине swagger в качестве Base URL берёт имя сервера без порта, поэтому функция Try it out не работает в моих примерах со Swagger'ом. Но вы можете попробовать это на собственной инсталляции.
</blockquote>

При нажатии на <b>Execute</b> Swagger UI сформирует строку curl, с помощью которой можно аналогичный запрос сделать из командной строки.

В Swagger UI можно даже создать объект:
<img src="https://fs.linkmeup.ru/images/adsm/3/swagger_post.png" width="800">

Для этого достаточно быть авторизованным под пользователем с нужными правами.

То, что мы видим на этой странице - это Swagger UI - документация, сгенерированная на основе спецификации API.

С трендами на микросервисную архитектуру всё более важным становится иметь стандартизированный API для взаимодействия между компонентами, эндпоинты и методы которого легко определить как человеку, так и приложению, не роясь в исходном коде или PDF-документации.
Поэтому разработчики сегодня всё чаще следуют парадигме <a href="https://medium.com/adobetech/three-principles-of-api-first-design-fa6666d9f694" target="_blank">API First</a>, когда сначала задумываются об API, а уже потом о реализации. 
В этом дизайне сначала специфицируется API, а затем из него <b>генерируются</b> документация, клиентское приложение, серверная часть и необходимы тесты.

Swagger - это фреймворк и язык спецификации (который ныне переименован в OpenAPI 2.0), позволяющие реализовать эту задачу.
Углубляться в него я не буду. 
За бо́льшими деталями сюда:
<ul>
    <li><a href="https://swagger.io/docs/specification/">Сайт Swagger</a></li>
    <li><a href="https://justcodeit.ru/swagger-docs-dlya-api-na-laravel/">Пример использования</a></li>
    <li><a href="https://en.wikipedia.org/wiki/OpenAPI_Specification">Wiki проOpen API</a></li>
</ul>
<hr>
<a name="OTHERS"></a>
<h1>Критика REST и альтернативы</h1>
Существует и такая, да. Не всё в том мире 2000-го года так уже радужно.
Не являясь экспертом, не берусь предметно раскрывать вопрос, но дам ссылку на небесспорную <a href="https://habr.com/ru/post/265845/" target="_blank">статью на хабре</a>.
Альтернативным интерфейсом взаимодействия компонентов системы сегодня является gRPC. Ему же пророчат большое будущее на ниве новых подходов к работе с сетевым оборудованием. Но о нём мы поговорим когда-то в будущем, когда придёт его черёд.
<hr>
<blockquote>
    <b>Важно</b>
    Токен a9aae70d65c928a554f9a038b9d4703a1583594f был использован только в демонстрационных целях и больше не работает.
    Прямое указание токенов в коде программы недопустимо и сделано здесь мной только в интересах упрощения примеров.
</blockquote>
<hr>
<a name="LINKS"></a>
<h1>Полезные ссылки</h1>
<ul>
    <li><a href="https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm" target="_blank">Изначальный доклад Роя Филдинга</a></li>
    <li><a href="https://medium.com/adobetech/three-principles-of-api-first-design-fa6666d9f694" target="_blank">API First</a></li>
    <li><a href="https://restfulapi.net/http-methods/" target="_blank">HTTP-методы</a></li>
    <li><a href="https://restfulapi.net/rest-architectural-constraints/" target="_blank">Принципы REST</a></li>
    <li><a href="https://swagger.io/docs/specification/">Сайт Swagger</a></li>
    <li><a href="https://justcodeit.ru/swagger-docs-dlya-api-na-laravel/">Пример использования Swagger</a></li>
    <li><a href="https://en.wikipedia.org/wiki/OpenAPI_Specification">Wiki про OpenAPI</a></li>

    <li><a href="https://habr.com/ru/post/265845/" target="_blank">Критика REST</a></li>
</ul>