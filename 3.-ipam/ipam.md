В предыдущих сериях АДСМ мы выработали фреймворк автоматизации, разобрались с тем, зачем появилась виртуализация и как она работает. В <a href="https://linkmeup.ru/blog/479.html">последней части</a> мы выбрали и обосновали дизайн сети, роли устройств, производителей, определились с LLD (адресацией, маршрутизацией, номерами Автономных Систем).
Теперь мы готовы подумать о том, как всю эту гору информации хранить и в дальнейшем удобно извлекать.

Нет, есть, конечно, и сегодня компании, которые ведут учёт выделенных IP-адресов в таблице Excel. Но это не наш путь.
Даже для самой маленькой конторки размеров в пару филиалов наличие централизованной системы управления IP-пространством не повредит.
Необходимость системы инвентаризации очевидна без лишних слов. 

<div class="spoiler"><b class="spoiler_title">Все выпуски АДСМ...</b><div class="spoiler_text" style="display: none;">
    <a href="https://linkmeup.ru/blog/424.html">0. АДСМ. Часть Нулевая. Планирование</a>
    <a href="https://linkmeup.ru/blog/449.html">1. АДСМ. Часть Первая (которая после нулевой). Виртуализация сети</a>
    <a href="https://linkmeup.ru/blog/479.html">2. АДСМ. Часть Вторая. Дизайн сети</a>
    <a href="https://linkmeup.ru/blog/530.html">3. АДСМ. Часть Третья. IPAM/DCIM-система</a>
</div></div>

Этот выпуск я посвящу неотъемлемым системам в сетевой автоматизации - системе управления адресным пространством и инвентарной системе.
Мы выберем и установим её, разберёмся с архитектурой, схемой БД, интерфейсами взаимодействия и наполним её. А в следующих частях начнём писать несложные скрипты, автоматизирующие повторяющиеся операции, такие как добавление новых стоек. 
Кроме того, я уже опубликовал отдельную статью о <a href="https://linkmeup.ru/blog/530.html">RESTful API</a>, в которой сделал короткий обзор его принципов и работы, это нам понадобится.

<h1>Содержание</h1>
<ul>
    <li><b><a href="#ARCHITECTURE">Архитектура системы</a></b></li>
    <li><b><a href="#SCHEME">Схема данных NetBox</a></b></li>
    <ul>
        <li><a href="#DCIM">DCIM</a>
        <ul>
            <li><a href="#LOCATION">Регионы и сайты (regions/sites)</a></li>
            <li><a href="#DEVICES">Устройства</a></li>
            <li><a href="#INTERFACES">Интерфейсы</a></li>
            <li><a href="#CONSOLE">Консольные порты</a></li>
        </ul>
        </li>
        <li><a href="#IPAM">IPAM</a>
        <ul>
            <li><a href="#VLANSVRFS">VLAN и VRF</a></li>
            <li><a href="#PREFIXES">IP-префиксы</a></li>
            <li><a href="#ADDRESSES">IP-адреса</a></li>
        </ul>
        </li>
        <li><a href="#VIRTUALIZATION">Виртуализация</a></li>
        <li><a href="#OTHERS">Дополнительные приятные вещи</a>
        <ul>
            <li><a href="#CUSTOM_FIELDS">Custom fields</a></li>
            <li><a href="#CONFIG_CONTEXTS">Config Context</a></li>
            <li><a href="#TAGS">Теги</a></li>
            <li><a href="#WEBHOOKS">Webhooks</a></li>
        </ul>
        </li>
    </ul>
    <li><b><a href="#THEEND">Заключение</a></b></li>
    <li><b><a href="#INSTALLATION">Некоторые нюансы установки NetBox</a></b></li>
    <li><b><a href="#POSTGRES">Немного о PostgreSQL</a></b></li>
    <li><b><a href="#LINKS">Полезные ссылки</a></b></li>
</ul>


<cut>
Сегодня рынок предлагает около дюжины инструментов, реализующих эту задачу: как платных, так и Open Source.

Для задач этой серии статей я выбрал NetBox по следующим причинам:
<ol>
    <li>Это бесплатно</li>
    <li>Он содержит в себе обе необходимые части - инвентаризацию и управление IP-пространством.</li>
    <li>У него есть RESTful API-интерфейс.</li>
    <li>Его разработал Digital Ocean (а конкретнее, любимый всеми Jeremy Stretch) для себя, то есть для дата-центров. Поэтому тут есть почти всё, что нужно, и почти ничего лишнего.</li>
    <li>Он активно поддерживается (Slack, Github, Google-рассылки) и обновляется.</li>
    <li>Это Open Source</li>
</ol>

<blockquote>
    Для нужд АДСМ я развернул NetBox в виртуалочке на нашем сервере (спасибо Антону Клочкову и <a href="https://miran.ru/">Мирану</a>): http://netbox.linkmeup.ru:45127
    Кроме того я заполнил почти все необходимые нам в дальнейшем данные.
    Поэтому вы можете попробовать почти все примеры и изучать схему данных в режиме чтения, пока не развернули свою инсталляцию.
</blockquote>

Немного полезного перед началом:
<ul>
    <li><a href="https://github.com/netbox-community/netbox" target="_blank">Сам NetBox на github</a></li>
    <li><a href="https://github.com/netbox-community/netbox-docker" target="_blank">Контейнерная версия</a></li>
    <li><a href="https://netbox.readthedocs.io/en/stable/" target="_blank">Полная инструкция по установке и вся документация по продукту</a></li>
    <li><a href="https://github.com/digitalocean/pynetbox" target="_blank">SDK для работы с NetBox в Python</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/api/docs/" target="_blank">Документация по API</a></li>
    <li><a href="https://groups.google.com/forum/#!forum/netbox-discuss" target="_blank">Mailing list</a></li>
    <li><a href="https://networktocode.slack.com/" target="_blank">Slack-канал NetworkToCode</a></li>
    <li><a href="https://linkmeup.ru/blog/530.html" target="_blank">Что такое REST</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/" target="_blank">Инсталляция NetBox для нужд АДСМ</a></li>
</ul>
<hr>

<a name="ARCHITECTURE"></a>
<h1>Архитектура системы</h1>
<ul>
    <li>NetBox написан на Python3. Что хорошо, потому что ряд других решений написан на php и изменять их при необходимости не так уж просто.</li>
    <li>Фреймворк для самого сайта - Django.</li>
    <li>В качестве БД используется PostgreSQL.</li>
    <li>WEB-frontend (HTTP-сревис) - NGINX - он проксирует запросы в Gunicron.</li>
    <li>WSGI - Gunicorn - интерфейс между Nginx и самим приложением.</li>
    <li>Фреймворк для документации по API - Swagger.</li>
    <li>Чтобы демонизировать NetBox - Systemd.</li>
</ul>
<blockquote>
    NetBox - проект молодой и быстро развивающийся. Например, в 2.7 отказались от supervisord и тянущегося за ним Python 2.7 в пользу systemd. Не так давно там не было ни кэширования, ни Webhooks.
    Поэтому меняется всё быстро и информация в статье может устареть к моменту чтения.
</blockquote>

Иными словами все компоненты зрелые и проверенные.

По словам автора NetBox отражает не реальное состояние сети, а целевое. Поэтому ничего не подгружается в NetBox из сети - это сеть настраивается в соответствие с содержимым NetBox.
Таким образом NetBox выступает единственным источником истины (калька с single source of truth).
И изменения на сети должны быть инициированы изменениями в NetBox.
А это очень неплохо ложится на идеологию, которую я исповедую в этой серии статей - хочешь сделать изменения на сети - сначала внеси их в системы. 
<hr>

<a name="SCHEME"></a>
<h1>Схема данных NetBox</h1>
Две главные задачи, которые решает NetBox: управление адресным пространством и инвентаризация.
NetBox едва ли станет единственной системой инвентаризации в компании, скорее, это будет специфическая дополнительная система для инвентаризации именно сети, забирающая данные из основной. 
Очевидно, в нашем случае для целей АДСМ будет только NetBox.

<blockquote>
    К данному моменту бо́льшая часть начальных данных в NetBox уже внесена.
    На этих данных я буду демонстрировать различные примеры работы через API.
    Вы можете просто полазить и посмотреть: http://netbox.linkmeup.ru:45127
    И эти же данные понадобятся в дальнейшем, когда мы перейдём к автоматизации.
</blockquote>

<div class="spoiler"><b class="spoiler_title">В общих чертах схему данных можно увидеть по схеме БД в Postgres'е…</b><div class="spoiler_text" style="display: none;">
<code>
                      List of relations
 Schema |                Name                | Type  | Owner
--------+------------------------------------+-------+--------
 public | auth_group                         | table | netbox
 public | auth_group_permissions             | table | netbox
 public | auth_permission                    | table | netbox
 public | auth_user                          | table | netbox
 public | auth_user_groups                   | table | netbox
 public | auth_user_user_permissions         | table | netbox
 public | circuits_circuit                   | table | netbox
 public | circuits_circuittermination        | table | netbox
 public | circuits_circuittype               | table | netbox
 public | circuits_provider                  | table | netbox
 public | dcim_cable                         | table | netbox
 public | dcim_consoleport                   | table | netbox
 public | dcim_consoleporttemplate           | table | netbox
 public | dcim_consoleserverport             | table | netbox
 public | dcim_consoleserverporttemplate     | table | netbox
 public | dcim_device                        | table | netbox
 public | dcim_devicebay                     | table | netbox
 public | dcim_devicebaytemplate             | table | netbox
 public | dcim_devicerole                    | table | netbox
 public | dcim_devicetype                    | table | netbox
 public | dcim_frontport                     | table | netbox
 public | dcim_frontporttemplate             | table | netbox
 public | dcim_interface                     | table | netbox
 public | dcim_interface_tagged_vlans        | table | netbox
 public | dcim_interfacetemplate             | table | netbox
 public | dcim_inventoryitem                 | table | netbox
 public | dcim_manufacturer                  | table | netbox
 public | dcim_platform                      | table | netbox
 public | dcim_powerfeed                     | table | netbox
 public | dcim_poweroutlet                   | table | netbox
 public | dcim_poweroutlettemplate           | table | netbox
 public | dcim_powerpanel                    | table | netbox
 public | dcim_powerport                     | table | netbox
 public | dcim_powerporttemplate             | table | netbox
 public | dcim_rack                          | table | netbox
 public | dcim_rackgroup                     | table | netbox
 public | dcim_rackreservation               | table | netbox
 public | dcim_rackrole                      | table | netbox
 public | dcim_rearport                      | table | netbox
 public | dcim_rearporttemplate              | table | netbox
 public | dcim_region                        | table | netbox
 public | dcim_site                          | table | netbox
 public | dcim_virtualchassis                | table | netbox
 public | django_admin_log                   | table | netbox
 public | django_content_type                | table | netbox
 public | django_migrations                  | table | netbox
 public | django_session                     | table | netbox
 public | extras_configcontext               | table | netbox
 public | extras_configcontext_platforms     | table | netbox
 public | extras_configcontext_regions       | table | netbox
 public | extras_configcontext_roles         | table | netbox
 public | extras_configcontext_sites         | table | netbox
 public | extras_configcontext_tags          | table | netbox
 public | extras_configcontext_tenant_groups | table | netbox
 public | extras_configcontext_tenants       | table | netbox
 public | extras_customfield                 | table | netbox
 public | extras_customfield_obj_type        | table | netbox
 public | extras_customfieldchoice           | table | netbox
 public | extras_customfieldvalue            | table | netbox
 public | extras_customlink                  | table | netbox
 public | extras_exporttemplate              | table | netbox
 public | extras_graph                       | table | netbox
 public | extras_imageattachment             | table | netbox
 public | extras_objectchange                | table | netbox
 public | extras_reportresult                | table | netbox
 public | extras_tag                         | table | netbox
 public | extras_taggeditem                  | table | netbox
 public | extras_webhook                     | table | netbox
 public | extras_webhook_obj_type            | table | netbox
 public | ipam_aggregate                     | table | netbox
 public | ipam_ipaddress                     | table | netbox
 public | ipam_prefix                        | table | netbox
 public | ipam_rir                           | table | netbox
 public | ipam_role                          | table | netbox
 public | ipam_service                       | table | netbox
 public | ipam_service_ipaddresses           | table | netbox
 public | ipam_vlan                          | table | netbox
 public | ipam_vlangroup                     | table | netbox
 public | ipam_vrf                           | table | netbox
 public | secrets_secret                     | table | netbox
 public | secrets_secretrole                 | table | netbox
 public | secrets_secretrole_groups          | table | netbox
 public | secrets_secretrole_users           | table | netbox
 public | secrets_sessionkey                 | table | netbox
 public | secrets_userkey                    | table | netbox
 public | taggit_tag                         | table | netbox
 public | taggit_taggeditem                  | table | netbox
 public | tenancy_tenant                     | table | netbox
 public | tenancy_tenantgroup                | table | netbox
 public | users_token                        | table | netbox
 public | virtualization_cluster             | table | netbox
 public | virtualization_clustergroup        | table | netbox
 public | virtualization_clustertype         | table | netbox
 public | virtualization_virtualmachine      | table | netbox
</code>
</div></div>

<a href="https://netbox.readthedocs.io/en/stable/#what-is-netbox" target="_blank">Функции NetBox</a>:
<ul>
    <li><b>IP address management (IPAM)</b> - IP-префиксы, адреса, VRF'ы и VLAN'ы</li>
    <li><b>Equipment racks</b> - Стойки для оборудования, организованные по сайтам, группам и ролям</li>
    <li><b>Devices</b> - Устройства, их модели, роли, комплектующие и расопложение</li>
    <li><b>Connections</b> - Сетевые, консольные и силовые соединения между устройствами</li>
    <li><b>Virtualization</b> - Виртуальные машины и вычислительные кластера</li>
    <li><b>Data circuits</b> - Подключения к провайдерам</li>
    <li><b>Secrets</b> - Защифрованное хранилизе учётных данных пользователей</li>
</ul>

В этой статье я коснусь следующих вещей: <a href="#DCIM">DCIM - Data Center Infrastructure Management</a>, <a href="#IPAM">IPAM - IP Address Management</a>, <a href="#VIRTUALIZATION">Виртуализация</a>, <a href="#OTHERS">Дополнительные приятные вещи</a>.
<hr>
Обо всём по порядку.

<a name="DCIM"></a>
<h2>DCIM</h2>
Самая важная часть - это, несомненно, какое оборудование у нас стоит и как оно друг к другу подключено. Но начинается всё с того, <b>где</b> оно стоит.

<a name="LOCATION"></a>
<h3>Регионы и сайты (regions/sites)</h3>
В парадигме NetBox устройство устанавливается на сайт, сайт принадлежит региону, регионы могут быть вложены. При этом устройство не может быть установлено просто в регионе. Если такая необходимость есть, должен быть заведён отдельный сайт.

Для нашего случая это может (и будет) выглядеть так:

<ul>
    <li><a href="http://netbox.linkmeup.ru:45127/dcim/sites/?region=ru" target="_blank">Россия</a>: <a href="http://netbox.linkmeup.ru:45127/dcim/sites/msk/" target="_blank">Москва</a>, <a href="http://netbox.linkmeup.ru:45127/dcim/sites/kzn/" target="_blank">Казань</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/dcim/sites/?region=sp" target="_blank">Испания</a>: <a href="http://netbox.linkmeup.ru:45127/dcim/sites/bcn/" target="_blank">Барселона</a>, <a href="http://netbox.linkmeup.ru:45127/dcim/sites/mlg/" target="_blank">Малага</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/dcim/sites/?region=cn" target="_blank">Китай</a>: <a href="http://netbox.linkmeup.ru:45127/dcim/sites/sha/">Шанхай</a>, <a href="http://netbox.linkmeup.ru:45127/dcim/sites/Sia/" target="_blank">Сиань</a>.</li>
</ul>

<img src="https://fs.linkmeup.ru/images/adsm/3/sites.png" width="800">

Напоминаю где и как мы планировали нашу сеть: <a href="https://linkmeup.ru/blog/479.html" target="_blank">АДСМ2. Дизайн сети</a>

<img src="https://fs.linkmeup.ru/images/adsm/2/locations.png" width="700">

<img src="https://fs.linkmeup.ru/images/adsm/3/sites_mlg.png" width="800">

Давайте посмотрим, что позволяет API.
Вот так можно вывести список всех регионов:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/regions/" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.regions.all()</code>
<blockquote>
    Здесь и далее я буду приводить примеры curl и pynetbox без вывода результата.
    <b>Не забудьте</b> слэш в конце URL - без него не заработает.
    Как использовать pynetbox я рассказывал в статье про <a href="https://linkmeup.ru/blog/530.html#PYNETBOX">RESTful API</a>.
</blockquote>

Получить список сайтов:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/sites/" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.sites.all()</code>

Список сайтов конкретного региона:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/sites/?region=ru" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.sites.filter(region="ru")</code>

<blockquote>
    Обратите внимание, что поиск идёт не по полному имени, а по так называемому <a href="https://qna.habr.com/q/375615" target="_blank">slug</a>.
    <b>Slug</b> - это идентификатор, содержащий только безопасные символы: [0-9A-Za-z-_], который можно использовать в URL. Задаётся он при создании объекта, например, "bcn" вместо "Барселона".
    <img src="https://fs.linkmeup.ru/images/adsm/3/nb_slug.png" width="400">
</blockquote>
<hr>

<a name="DEVICES"></a>
<h3>Устройства</h3>
Само устройство обладает какой-то <a href="http://netbox.linkmeup.ru:45127/dcim/device-roles/" target="_blank">ролью</a>, например, leaf, spine, edge, border.
Оно, очевидно, является какой-то <a href="http://netbox.linkmeup.ru:45127/dcim/device-types/" target="_blank">моделью</a> какого-то <a href="http://netbox.linkmeup.ru:45127/dcim/manufacturers/" target="_blank">вендора</a>.
Например, <a href="http://netbox.linkmeup.ru:45127/dcim/device-types/?manufacturer=arista" target="_blank">Arista</a>.
Таким образом, сначала создаётся вендор, далее внутри него модели.
<a href="http://netbox.linkmeup.ru:45127/dcim/device-types/2/" target="_blank">Модель</a> характеризуется именем, набором сервисных интерфейсов, интерфейсом удалённого управления, консольным портом и набором модулей питания.

Помимо коммутаторов, маршрутизаторов и хостов, обладающих Ethernet-интерфейсами, можно создавать консольные сервера.

<img src="https://fs.linkmeup.ru/images/adsm/3/devices.png" width="800">

<img src="https://fs.linkmeup.ru/images/adsm/3/device_mlg.png" width="500">

Получить список всех устройств:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.all()</code>

Всех устройств конкретного сайта:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?site=mlg" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.filter(site="mlg")</code>

Всех устройств определённой модели
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?model=veos" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.filter(device_type_id=2)</code>

Всех устройств определённой роли:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?role=leaf" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.filter(role="leaf")</code>

Устройство может быть в разных статусах: Active, Offline, Planned итд.
Все активные устройства:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?status=active" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.filter(status="active")</code>
<hr>

<a name="INTERFACES"></a>
<h3>Интерфейсы</h3>
NetBox поддерживает множество типов физических <a href="http://netbox.linkmeup.ru:45127/api/dcim/_choices/" target="_blank">интерфейсов</a> и LAG, однако все виртуальные, такие как Vlan/IRB и loopback объединены под одним типом - Virtual. 
Каждый интерфейс привязан к какому-либо устройству.

Интерфейсы устройств могут быть подключены друг к другу. Это будет отображаться как в интерфейсе, так и в ответах API (атрибут connected_endpoint).
<img src="https://fs.linkmeup.ru/images/adsm/3/interfaces.png" width="800">

Интерфейс может быть в различных режимах: Tagged или Access.
Соответственно, в него могут быть спущены с тегом или без VLAN'ы - данного сайта или глобальные. 

Получить список всех интерфейсов устройства:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.interfaces.filter(device="mlg-leaf-0")</code>


Получить список VLAN'ов конкретного интерфейса.
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&name=Ethernet7" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.interfaces.get(device="mlg-leaf-0", name="Ethernet7").untagged_vlan.vid</code>

<blockquote>
    Обратите внимание, что тут я уже использую метод <b>get</b> вместо <b>filter</b>. Filter возвращает список, даже если результат - один единственный объект. Get - возвращает один объект или падает с ошибкой, если результатом запроса является список объектов. 
    Поэтому get следует использовать только тогда, когда вы абсолютно уверены, что результат будет в единственном экземпляре.
    Ещё здесь же прямо после запроса я обращаюсь к атрибутам объекта. Строго говоря, это неправильно: если по запросу ничего не найдено, то pynetbox вернёт None, а у него нет атрибута "untagged_vlan".
    И ещё обратите внимание, что не везде pynetbox ожидает slug, где-то и name.
</blockquote>


Выяснить к какому интерфейсу какого устройства подключен определённый интерфейс:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&name=Ethernet1" -H "Accept: application/json; indent=4" </code>
<code>
    iface = nb.dcim.interfaces.get(device="mlg-leaf-0", name="Ethernet1")
    iface.connected_endpoint.device
    iface.connected_endpoint.name</code> 

Узнать имя интерфейса управления:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&mgmt_only=true" -H "Accept: application/json; indent=4" </code>
<code>nb.dcim.interfaces.get(device="mlg-leaf-0", mgmt_only=True)</code>
<hr>

<a name="CONSOLE"></a>
<h3>Консольные порты</h3>
Консольные порты не являются интерфейсами, поэтому вынесены как отдельные эндпоинты.
Порты устройства можно связать с портами консольного сервера.

Выяснить к какому порту какого консольного сервера подключено конкретное устройство.
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/console-ports/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.console_ports.get(device="mlg-leaf-0").serialize()</code>
<blockquote>
    Метод <b>serialize</b> в pynetbox позволяет преобразовать атрибуты экземпляра класса в словарь.
</blockquote>
<hr>

<a name="IPAM"></a>
<h2>IPAM</h2>
<a name="VLANSVRFS"></a>
<h3>VLAN и VRF</h3>
Могут быть привязаны к локации - полезно для VLAN.
При создании VRF можно указать, допускается ли пересечение адресного пространства с другими VRF.


Получить список всех VLAN:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/vlans/" -H "Accept: application/json; indent=4" </code>
<code>nb.ipam.vlans.all()</code>

Получить список всех VRF:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/vrfs/" -H "Accept: application/json; indent=4" </code>
<code>nb.ipam.vrfs.all()</code>
<hr>

<a name="PREFIXES"></a>
<h3>IP-префиксы</h3>
Имеют иерархическую структуру. Может принадлежать какому-либо VRF (если не принадлежит - то Global).

<img src="https://fs.linkmeup.ru/images/adsm/3/prefixes.png" width="800">

В NetBox очень удобное визуальное представление свободных префиксов:
<img src="https://fs.linkmeup.ru/images/adsm/3/available_prefixes.png" width="800">

Выделить можно просто кликом на зелёную строчку.

Может быть привязан к локации. Можно через API выделить следующий свободный под-префикс нужного размера или следующий свободный IP-адрес. 
Галочка/параметр "Is a pool" определяет, будет ли при автоматическом выделении выделяться 0-й адрес из этого префикса, или начнётся с 1-го. 

Получить список IP-префиксов сайта Малага c ролью Underlay и длиной 19:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/?site=mlg&role=underlay&mask_length=19" -H "Accept: application/json; indent=4" </code>
<code>prefix = nb.ipam.prefixes.get(site="mlg", role="underlay", mask_length="19")</code>

Получить список свободных префиксов в регионе Россия c ролью Underlay:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/40/available-prefixes/" -H "Accept: application/json; indent=4"</code>
<code>prefix.available_prefixes.list()</code>

Выделить следующий свободный префикс длиной в 24:
<code>curl -X POST "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/40/available-prefixes/" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
-d "{\"prefix_length\": 24}"</code>
<code>prefix.available_prefixes.create({"prefix_length":24})</code>

<blockquote>
    Когда внутри одного объекта нам нужно выделить какой-то дочерний, используется метод POST и нужно указать ID родительского объекта - в данном случае - <b>40</b>. Его мы выяснили вызовом из предыдущего примера.
    В случае pynetbox мы сначала (в предыдущем примере) сохранили результат в переменную <b>prefix</b>, а далее обратились к его атрибуту <b>available_prefixes</b> и методу <b>create</b>.
    Этот пример у вас <b>не сработает</b>, поскольку токен с правом записи уже недействителен.
</blockquote>
<hr>

<a name="ADDRESSES"></a>
<h3>IP-адреса</h3> 
Если есть включающий этот адрес префикс, то будут его частью. Могут быть и сами по себе.
Могут принадлежать какому-либо VRF или быть в Global.
Могут быть привязаны к интерфейсу, а могут висеть в воздухе.
Можно выделить следующий свободный IP-адрес в префиксе.
<img src="https://fs.linkmeup.ru/images/adsm/3/ip_addresses.png" width="800">

Чтобы сделать это, просто нужно кликнуть по зелёной строчке.


Получить список IP-адресов конкретного интерфейса:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?interface_id=8" -H "Accept: application/json; indent=4" </code>
<code>nb.ipam.ip_addresses.filter(interface_id=8)</code>
Или:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?device=mlg-leaf-0&interface=Ethernet1" -H "Accept: application/json; indent=4"</code>
<code>nb.ipam.ip_addresses.filter(device="mlg-leaf-0", interface="Ethernet1")</code>

Получить список всех IP-адресов устройства:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"</code>
<code>nb.ipam.ip_addresses.filter(device="mlg-leaf-0")</code>

Получить список доступных IP-адресов префикса:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/28/available-ips/" -H "Accept: application/json; indent=4"</code>
<code>
    prefix = nb.ipam.prefixes.get(site="mlg", role="leaf-loopbacks")
    prefix.available_ips.list()</code>

<blockquote>
    Здесь снова нужно в URL указать ID префикса, из которого выделяем адрес - на сей раз это 28.
</blockquote>

Выделить следующий свободный IP-адрес в префиксе:
<code>
    curl -X POST "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/28/available-ips/" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"</code>
<code>prefix.available_ips.create()</code>
<hr>

<a name="VIRTUALIZATION"></a>
<h2>Виртуализация</h2>
Мы же всё-таки боремся за звание современного ДЦ. Куда же без виртуализации.
NetBox не выглядит и не является местом, где стоит хранить информацию о виртуальных машинах (даже о необходимости хранения в нём физических машин можно порассуждать). Однако нам это может оказаться полезным, например, можно занести информация о Route Reflector'ах, о служебных машинах, таких как NTP, Syslog, S-Flow-серверах, о машинах-управляках. 
ВМ обладает своим списком интерфейсов - они отличны от интерфейсов физических устройств и имеют свой отдельный Endpoint.

Так можно вывести список всех виртуальных машин:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/virtualization/virtual-machines/" -H "Accept: application/json; indent=4" </code>
<code>nb.virtualization.virtual_machines.all()</code>

Так - всех интерфейсов всех ВМ:
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/virtualization/interfaces/" -H "Accept: application/json; indent=4" </code>
<code>nb.virtualization.interfaces.all()</code>

Для ВМ нельзя указать конкретный гипервизор/физическую машину, на котором она запущена, но можно указать кластер. Хотя не всё так безнадёжно. Читаем дальше.

<hr>


<a name="OTHERS"></a>
<h2>Дополнительные приятные вещи</h2>
Основная функциональность NetBox закрывает большинство задач многих пользователей, но не все. Всё-таки изначально продукт написан для решения задач конкретной компании. Однако он активно развивается и новые релизы выходят довольно <a href="https://github.com/netbox-community/netbox/releases" target="_blank">часто</a>. Соответственно появляются и новые функции.
Так, например, с моей первой установки NetBox пару лет назад в нём появились теги, config contexts, webhooks, кэширование, supervisord сменился на systemd, внешние хранилища для файлов.

<a name="CUSTOM_FIELDS"></a>
<h3>Custom fields</h3>
Иногда хочется к какой-либо сущности добавить поле, в которое можно было бы поместить произвольные данные. 
Например, указать номер договора поставки, по которому был приобретён коммутатор или имя физической машины, на которой запущена ВМ. 
Тут на помощь и приходит custom fields - как раз такое поле с текстовым значением, которое можно добавить почти к любой сущности в NetBox.

Создаётся Custom fields в админской панели
<img src="https://fs.linkmeup.ru/images/adsm/3/nb_custom_fields.png" width="600">

Вот так это выглядит при редактировании устройства, для которого был создан custom field:
<img src="https://fs.linkmeup.ru/images/adsm/3/nb_custom_field_edit.png" width="450">

Запросить список устройств по значению custom_field
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?cf_contract_number=0123456789" -H "Accept: application/json; indent=4"</code>
<code>nb.dcim.devices.filter(cf_contract_number="0123456789")</code>
<hr>

<a name="CONFIG_CONTEXTS"></a>
<h3>Config Context</h3>
Иногда хочется чего-то большего, чем неструктурированный текст. Тогда на помощь приходит <a href="http://netbox.linkmeup.ru:45127/extras/config-contexts/1/" target="_blank">Config Context</a>.
Это возможность ввести набор структурированных данных в формате JSON, который больше некуда поместить.
Это может быть, например, набор BGP communities или список Syslog-серверов.
Config Context может быть локальным - настроенным для конкретного объекта - или глобальным, когда он настраивается однажды, а затем распространяется на все объекты, удовлетворяющие определённым условиям (например, расположенные на одном сайте, или запущенные на одной платформе).
<img src="https://fs.linkmeup.ru/images/adsm/3/config_context.png" width="800">

Config Context автоматически добавляется к результатам запроса. При этом локальные и глобальные контексты сливаются в один.

Например, для устройства just a simple russian girl, для которого есть локальный контекст, в выводе будет ключ "config_context":
<code>curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?q=russian" -H "Accept: application/json; indent=4"</code>
<img src="https://fs.linkmeup.ru/images/adsm/3/config_context_result.png" width="204">
<code>
    "config_context": {
        "syslog_servers": [
            {
                "ip": "1.1.1.1"
            },
            {
                "ip": "2.2.2.2"
            }
        ],
        "ntp_servers": [
            {
                "ip": "3.3.3.3"
            }
        ]
    }</code>
<hr>

<a name="TAGS"></a>
<h3>Теги</h3>
Про теги сложно сказать что-то новое. Они есть. Они удобны для добавления какого-либо признака. К примеру, можно пометить тегом "бяда" коммутаторы из партии, в которой сбоит память.
<hr>

<a name="WEBHOOKS"></a>
<h3>Webhooks</h3>
Незаменимая вещь, когда нужно, чтобы об изменениях в NetBox'е узнавали другие сервисы.
Например, при заведении нового коммутатора отправляется хука в систему автоматизации, которая запускает процесс настройки устройства и ввода в эксплуатацию. 
<hr>

<a name="THEEND"></a>
<h1>Заключение</h1>
В этой статье я не преследую цель рассмотреть все возможности NetBox, поэтому всё остальное отдаю вам на откуп. Разбирайтесь, пробуйте.

Далее в рамках построения системы автоматизации я буду касаться только тех частей, которые нам действительно нужны. 

Итак, выше я коротко рассказал о том, что из себя представляет NetBox, и как в нём хранятся данные. 
Повторюсь, что почти все необходимые данные я туда уже внёс, и вы можете утащить себе <a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/netbox_initial_db.sql" target="_blank">дамп БД</a>.

Всё готово к следующему этапу автоматизации: написанию системы (ахаха, просто скриптов) инициализации устройств и управления конфигурацией. 
<hr>

Но, прежде чем закончить статью я ещё скажу пару слов об установке и работе компонентов NetBox.


<a name="INSTALLATION"></a>
<h1>Некоторые нюансы установки NetBox</h1>
Я не буду описывать процесс инсталляции в деталях - он более чем классно описан в <a href="https://netbox.readthedocs.io/en/stable/installation/" target="_blank">официальной документации</a>.

Посмотреть на процесс запуска docker-образа NetBox и работу в GUI можно в видео Димы Фиголя (<a href="https://www.youtube.com/watch?v=GGXgAlWm9aY&t=9655s" target="_blank">раз</a> и <a href="https://www.youtube.com/watch?v=a3yK_WAisPw" target="_blank">два</a>) и <a href="https://www.youtube.com/watch?v=I_Ra3PIR2Lc&feature=youtu.be" target="_blank">Эмиля Гарипова</a>.

В целом, если следовать шагам установки/запуска неукоснительно, то всё получится. 
Но вот какие есть нюансы, про которые случайно можно забыть.

<ul>
    <li>В файле configuration.py должен быть заполнен параметр <a href="https://netbox.readthedocs.io/en/stable/installation/2-netbox/#allowed_hosts" target="_blank">ALLOWED_HOSTS</a>:
    <code>
    ALLOWED_HOSTS = ['netbox.linkmeup.ru', 'localhost']</code>
    Тут нужно указать все возможные имена  NetBox, к которым вы будете обращаться, например, может быть внешний IP-адрес или 127.0.0.1 или DNS-alias. 
    Если этого не будет сделано, сайт NetBox не откроется и будет показывать 400.</li>
    <li>В этом же файле должен быть указан <a href="https://netbox.readthedocs.io/en/stable/installation/2-netbox/#secret_key" target="_blank">SECRET_KEY</a>, который можно выдумать самому или сгенерировать скриптом.</li>
    <li>Главная страница будет показывать 502 Bad Gateway, если что-то не так с настройкой базы PostgreSQL: проверьте хост(если ставили на другую машину), порт, имя базы, имя пользователя, пароль.</li>
    <li>С <a href="https://github.com/netbox-community/netbox/releases/tag/v2.6.0" target="_blank">некоторых пор</a> NetBox по умолчанию не даёт никаких прав на чтение без авторизации.
    Изменяется это всё в том же configuration.py:
    <code>
    EXEMPT_VIEW_PERMISSIONS = ['*']</code></li>
    <li>А ещё API запросы будут возвращать 200 и не работать, если в API URL не будет слэша в конце.
    <code>
        curl -X GET -H "Accept: application/json; indent=4" "http://netbox.linkmeup.ru:45127/api/dcim/devices"</code>
    </li>
</ul>
<hr>

<a name="POSTGRES"></a>
<h1>Немного о PostgreSQL</h1>
Для подключения к серверу: <code>psql -U <i>username</i> -h <i>hostname</i> <i>db_name</i></code>
Например: <code>psql -U netbox -h localhost netbox</code>
Для вывода всех таблиц: <code>/dt</code>
Для выхода: <code>/q</code>
Для дампа БД: <code>pg_dump -U <i>username</i> -h <i>hostname</i> <i>db_name</i> > netbox.sql</code>

Если не хочется каждый раз вводить пароль:
<code>
    echo *:*:*:<i>username</i>:<i>password</i> > ~/.pgpass
    chmod 600 ~/.pgpass</code>


Если у вас есть своя инсталляция и не хочется вносить всё руками, можно просто сделать так, взяв дамп текущей БД NetBox <a href="https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/netbox_initial_db.sql" target="_blank">тут</a>:
<code>
    psql -U <i>username</i> -h <i>hostname</i> <i>db_name</i> < netbox_initial_db.sql</code>

Если предварительно нужно дропнуть все таблицы (а сделать это придётся), то можно подготовить заранее файл:
<code>
    psql -U <i>username</i> -h <i>hostname</i> <i>db_name</i>
    \o drop_all_tables.sql
    select 'drop table ' || tablename || ' cascade;' from pg_tables;
    \q
    psql -U <i>username</i> -h <i>hostname</i> <i>db_name</i> -f drop_all_tables.sql</code>
<hr>

<a name="LINKS"></a>
<h1>Полезные ссылки</h1>
<ul>
    <li><a href="https://github.com/netbox-community/netbox" target="_blank">Сам NetBox на guthub</a></li>
    <li><a href="https://github.com/netbox-community/netbox-docker" target="_blank">Контейнерная версия</a></li>
    <li><a href="https://netbox.readthedocs.io/en/stable/" target="_blank">Полная инструкция по установке и вся документация по продукту</a></li>
    <li><a href="http://karneliuk.com/2019/04/documenting-your-network-infrastructure-in-netbox-integrating-with-ansible-over-rest-api-and-automating-provisioning-of-cumulus-linux-arista-eos-nokia-sr-os-and-cisco-ios-xr/" target="_blank">Documenting your network infrastructure in NetBox, integrating with Ansible over REST API</a></li>
    <li><a href="https://www.youtube.com/watch?v=GGXgAlWm9aY&t=9655s" target="_blank">IPAM NetBox and its API, Docker, Postman</a></li>
    <li><a href="https://www.youtube.com/watch?v=a3yK_WAisPw" target="_blank">IPAM NetBox and its API, configuration templates with Python</a></li>
    <li><a href="https://github.com/digitalocean/pynetbox" target="_blank">SDK для работы с NetBox в Python</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/api/docs/" target="_blank">Документация по API</a></li>
    <li><a href="https://groups.google.com/forum/#!forum/netbox-discuss" target="_blank">Mailing list</a></li>
    <li><a href="https://networktocode.slack.com/" target="_blank">Slack-канал NetworkToCode</a></li>
    <li><a href="https://linkmeup.ru/blog/530.html" target="_blank">Что такое REST</a></li>
    <li><a href="http://netbox.linkmeup.ru:45127/" target="_blank">Инсталляция NetBox для нужд АДСМ</a></li>
</ul>

<hr>
<blockquote><h5>Оставайтесь на связи</h5>
<a href="https://linkmeup.ru/rss"><img src="https://linkmeup.ru/templates/skin/synio/images/RSS.png" title="RSS сайта"></a><a href="mailto:info@linkmeup.ru"><img src="https://linkmeup.ru/templates/skin/synio/images/Email.png" title="Написать авторам"></a><a href="https://vk.com/linkmeup"><img src="https://linkmeup.ru/templates/skin/synio/images/vk1.png" title="linkmeup вконтакте"></a><a href="https://www.facebook.com/linkmeup.sdsm"><img src="https://linkmeup.ru/templates/skin/synio/images/Facebook.png" title="linkmeup на Фейсбуке"></a><a href="https://www.patreon.com/linkmeup"><img src="https://linkmeup.ru/templates/skin/synio/images/patreon.png" width="25" title=" Поддержать linkmeup на Patreon"></a>

Особо благодарных просим задержаться и пройти на Патреон.
<a href="https://www.patreon.com/linkmeup?ty=h" target="_blank"><img src="https://fs.linkmeup.ru/images/patreon.jpg" width="400"></a></blockquote>