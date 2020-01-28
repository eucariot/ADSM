Схема данных NetBox
===================

Две главные задачи, которые решает NetBox: управление адресным пространством и инвентаризация.
NetBox едва ли станет единственной системой инвентаризации в компании, скорее, это будет специфическая дополнительная система для инвентаризации именно сети, забирающая данные из основной. 
Очевидно, в нашем случае для целей АДСМ будет только NetBox.

    К данному моменту бо́льшая часть начальных данных в NetBox уже внесена.
    На этих данных я буду демонстрировать различные примеры работы через API.
    Вы можете просто полазить и посмотреть: http://netbox.linkmeup.ru:45127
    И эти же данные понадобятся в дальнейшем, когда мы перейдём к автоматизации.

В общих чертах схему данных можно увидеть по схеме БД в Postgres'е
    .. code-block:: bash
    
       +--------+------------------------------------+-------+--------+
       |        |               List of relations    |       |        |
       | Schema |                Name                | Type  | Owner  |
       +========+====================================+=======+========+
       | public | auth_group                         | table | netbox |
       | public | auth_group_permissions             | table | netbox |
       | public | auth_permission                    | table | netbox |
       | public | auth_user                          | table | netbox |
       | public | auth_user_groups                   | table | netbox |
       | public | auth_user_user_permissions         | table | netbox |
       | public | circuits_circuit                   | table | netbox |
       | public | circuits_circuittermination        | table | netbox |
       | public | circuits_circuittype               | table | netbox |
       | public | circuits_provider                  | table | netbox |
       | public | dcim_cable                         | table | netbox |
       | public | dcim_consoleport                   | table | netbox |
       | public | dcim_consoleporttemplate           | table | netbox |
       | public | dcim_consoleserverport             | table | netbox |
       | public | dcim_consoleserverporttemplate     | table | netbox |
       | public | dcim_device                        | table | netbox |
       | public | dcim_devicebay                     | table | netbox |
       | public | dcim_devicebaytemplate             | table | netbox |
       | public | dcim_devicerole                    | table | netbox |
       | public | dcim_devicetype                    | table | netbox |
       | public | dcim_frontport                     | table | netbox |
       | public | dcim_frontporttemplate             | table | netbox |
       | public | dcim_interface                     | table | netbox |
       | public | dcim_interface_tagged_vlans        | table | netbox |
       | public | dcim_interfacetemplate             | table | netbox |
       | public | dcim_inventoryitem                 | table | netbox |
       | public | dcim_manufacturer                  | table | netbox |
       | public | dcim_platform                      | table | netbox |
       | public | dcim_powerfeed                     | table | netbox |
       | public | dcim_poweroutlet                   | table | netbox |
       | public | dcim_poweroutlettemplate           | table | netbox |
       | public | dcim_powerpanel                    | table | netbox |
       | public | dcim_powerport                     | table | netbox |
       | public | dcim_powerporttemplate             | table | netbox |
       | public | dcim_rack                          | table | netbox |
       | public | dcim_rackgroup                     | table | netbox |
       | public | dcim_rackreservation               | table | netbox |
       | public | dcim_rackrole                      | table | netbox |
       | public | dcim_rearport                      | table | netbox |
       | public | dcim_rearporttemplate              | table | netbox |
       | public | dcim_region                        | table | netbox |
       | public | dcim_site                          | table | netbox |
       | public | dcim_virtualchassis                | table | netbox |
       | public | django_admin_log                   | table | netbox |
       | public | django_content_type                | table | netbox |
       | public | django_migrations                  | table | netbox |
       | public | django_session                     | table | netbox |
       | public | extras_configcontext               | table | netbox |
       | public | extras_configcontext_platforms     | table | netbox |
       | public | extras_configcontext_regions       | table | netbox |
       | public | extras_configcontext_roles         | table | netbox |
       | public | extras_configcontext_sites         | table | netbox |
       | public | extras_configcontext_tags          | table | netbox |
       | public | extras_configcontext_tenant_groups | table | netbox |
       | public | extras_configcontext_tenants       | table | netbox |
       | public | extras_customfield                 | table | netbox |
       | public | extras_customfield_obj_type        | table | netbox |
       | public | extras_customfieldchoice           | table | netbox |
       | public | extras_customfieldvalue            | table | netbox |
       | public | extras_customlink                  | table | netbox |
       | public | extras_exporttemplate              | table | netbox |
       | public | extras_graph                       | table | netbox |
       | public | extras_imageattachment             | table | netbox |
       | public | extras_objectchange                | table | netbox |
       | public | extras_reportresult                | table | netbox |
       | public | extras_tag                         | table | netbox |
       | public | extras_taggeditem                  | table | netbox |
       | public | extras_webhook                     | table | netbox |
       | public | extras_webhook_obj_type            | table | netbox |
       | public | ipam_aggregate                     | table | netbox |
       | public | ipam_ipaddress                     | table | netbox |
       | public | ipam_prefix                        | table | netbox |
       | public | ipam_rir                           | table | netbox |
       | public | ipam_role                          | table | netbox |
       | public | ipam_service                       | table | netbox |
       | public | ipam_service_ipaddresses           | table | netbox |
       | public | ipam_vlan                          | table | netbox |
       | public | ipam_vlangroup                     | table | netbox |
       | public | ipam_vrf                           | table | netbox |
       | public | secrets_secret                     | table | netbox |
       | public | secrets_secretrole                 | table | netbox |
       | public | secrets_secretrole_groups          | table | netbox |
       | public | secrets_secretrole_users           | table | netbox |
       | public | secrets_sessionkey                 | table | netbox |
       | public | secrets_userkey                    | table | netbox |
       | public | taggit_tag                         | table | netbox |
       | public | taggit_taggeditem                  | table | netbox |
       | public | tenancy_tenant                     | table | netbox |
       | public | tenancy_tenantgroup                | table | netbox |
       | public | users_token                        | table | netbox |
       | public | virtualization_cluster             | table | netbox |
       | public | virtualization_clustergroup        | table | netbox |
       | public | virtualization_clustertype         | table | netbox |
       | public | virtualization_virtualmachine      | table | netbox |
       +--------+------------------------------------+-------+--------+

`Функции NetBox <https://netbox.readthedocs.io/en/stable/#what-is-netbox>`_:

* **IP address management (IPAM)** - IP-префиксы, адреса, VRF'ы и VLAN'ы
* **Equipment racks** - Стойки для оборудования, организованные по сайтам, группам и ролям
* **Devices** - Устройства, их модели, роли, комплектующие и расопложение
* **Connections** - Сетевые, консольные и силовые соединения между устройствами
* **Virtualization** - Виртуальные машины и вычислительные кластера
* **Data circuits** - Подключения к провайдерам
* **Secrets** - Защифрованное хранилизе учётных данных пользователей

В этой статье я коснусь следующих вещей: DCIM - Data Center Infrastructure Management, IPAM - IP Address Management, Виртуализация, дополнительные приятные вещи.
Обо всём по порядку.

DCIM
----

Самая важная часть - это, несомненно, какое оборудование у нас стоит и как оно друг к другу подключено. Но начинается всё с того, **где** оно стоит.

Регионы и сайты (regions/sites)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

В парадигме NetBox устройство устанавливается на сайт, сайт принадлежит региону, регионы могут быть вложены. При этом устройство не может быть установлено просто в регионе. Если такая необходимость есть, должен быть заведён отдельный сайт.

Для нашего случая это может (и будет) выглядеть так:

* `Россия <http://netbox.linkmeup.ru:45127/dcim/sites/?region=ru>`_: `Москва <http://netbox.linkmeup.ru:45127/dcim/sites/msk/>`_, `Казань <http://netbox.linkmeup.ru:45127/dcim/sites/kzn/>`_ 
* `Испания <http://netbox.linkmeup.ru:45127/dcim/sites/?region=sp>`_: `Барселона <http://netbox.linkmeup.ru:45127/dcim/sites/bcn/>`_, `Малага <http://netbox.linkmeup.ru:45127/dcim/sites/mlg/>`_ 
* `Китай <http://netbox.linkmeup.ru:45127/dcim/sites/?region=cn>`_: `Шанхай <http://netbox.linkmeup.ru:45127/dcim/sites/sha/>`_, `Сиань <http://netbox.linkmeup.ru:45127/dcim/sites/sia/>`_.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/sites.png           
           :width: 800
           :align: center

Напоминаю где и как мы планировали нашу сеть: `АДСМ2. Дизайн сети <https://linkmeup.ru/blog/479.html>`_

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/topology.png
           :width: 700
           :align: center

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/sites_mlg.png           
           :width: 800
           :align: center

Давайте посмотрим, что позволяет API.
Вот так можно вывести список всех регионов:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/regions/" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.regions.all()

    Здесь и далее я буду приводить примеры curl и pynetbox без вывода результата.
    **Не забудьте** слэш в конце URL - без него не заработает.
    Как использовать pynetbox я рассказывал в статье про `RESTful API <https://linkmeup.ru/blog/530.html#PYNETBOX>`_.

Получить список сайтов:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/sites/" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.sites.all()

Список сайтов конкретного региона:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/sites/?region=ru" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.sites.filter(region="ru")

    Обратите внимание, что поиск идёт не по полному имени, а по так называемому `slug <https://qna.habr.com/q/375615>`_.
    **Slug** - это идентификатор, содержащий только безопасные символы: [0-9A-Za-z-_], который можно использовать в URL. Задаётся он при создании объекта, например, "bcn" вместо "Барселона".

        .. figure:: https://fs.linkmeup.ru/images/adsm/3/nb_slug.png
           :width: 400
           :align: center

Устройства
~~~~~~~~~~

Само устройство обладает какой-то `ролью <http://netbox.linkmeup.ru:45127/dcim/device-roles/>`_, например, leaf, spine, edge, border.
Оно, очевидно, является какой-то `моделью <http://netbox.linkmeup.ru:45127/dcim/device-types/>`_ какого-то `вендора <http://netbox.linkmeup.ru:45127/dcim/manufacturers/>`_.
Например, `Arista <http://netbox.linkmeup.ru:45127/dcim/device-types/?manufacturer=arista>`_.
Таким образом, сначала создаётся вендор, далее внутри него модели.
`Модель <http://netbox.linkmeup.ru:45127/dcim/device-types/2/>`_ характеризуется именем, набором сервисных интерфейсов, интерфейсом удалённого управления, консольным портом и набором модулей питания.

Помимо коммутаторов, маршрутизаторов и хостов, обладающих Ethernet-интерфейсами, можно создавать консольные сервера.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/devices.png           
           :width: 800
           :align: center

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/device_mlg.png
           :width: 500
           :align: center

Получить список всех устройств:


    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.devices.all()

Всех устройств конкретного сайта:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?site=mlg" -H "Accept: application/json; indent=4"

    .. code-block:: bash
    
       nb.dcim.devices.filter(site="mlg")

Всех устройств определённой модели

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?model=veos" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.devices.filter(device_type_id=2)

Всех устройств определённой роли:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?role=leaf" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.devices.filter(role="leaf")

Устройство может быть в разных статусах: Active, Offline, Planned итд.
Все активные устройства:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?status=active" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.devices.filter(status="active")

Интерфейсы
~~~~~~~~~~

NetBox поддерживает множество типов физических `интерфейсов <http://netbox.linkmeup.ru:45127/api/dcim/_choices/>`_ и LAG, однако все виртуальные, такие как Vlan/IRB и loopback объединены под одним типом - Virtual. 
Каждый интерфейс привязан к какому-либо устройству.

Интерфейсы устройств могут быть подключены друг к другу. Это будет отображаться как в интерфейсе, так и в ответах API (атрибут connected_endpoint).

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/interfaces.png           
           :width: 800
           :align: center

Интерфейс может быть в различных режимах: Tagged или Access.
Соответственно, в него могут быть спущены с тегом или без VLAN'ы - данного сайта или глобальные. 

Получить список всех интерфейсов устройства:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.interfaces.filter(device="mlg-leaf-0")


Получить список VLAN'ов конкретного интерфейса.

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&name=Ethernet7" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.interfaces.get(device="mlg-leaf-0", name="Ethernet7").untagged_vlan.vid

    Обратите внимание, что тут я уже использую метод **get** вместо **filter**. Filter возвращает список, даже если результат - один единственный объект. Get - возвращает один объект или падает с ошибкой, если результатом запроса является список объектов. 
    Поэтому get следует использовать только тогда, когда вы абсолютно уверены, что результат будет в единственном экземпляре.
    Ещё здесь же прямо после запроса я обращаюсь к атрибутам объекта. Строго говоря, это неправильно: если по запросу ничего не найдено, то pynetbox вернёт None, а у него нет атрибута "untagged_vlan".
    И ещё обратите внимание, что не везде pynetbox ожидает slug, где-то и name.


Выяснить к какому интерфейсу какого устройства подключен определённый интерфейс:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&name=Ethernet1" -H "Accept: application/json; indent=4" 

    .. code-block:: python
       
       iface = nb.dcim.interfaces.get(device="mlg-leaf-0", name="Ethernet1")
       iface.connected_endpoint.device
       iface.connected_endpoint.name 

Узнать имя интерфейса управления:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/interfaces/?device=mlg-leaf-0&mgmt_only=true" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.dcim.interfaces.get(device="mlg-leaf-0", mgmt_only=True)

Консольные порты
~~~~~~~~~~~~~~~~

Консольные порты не являются интерфейсами, поэтому вынесены как отдельные эндпоинты.
Порты устройства можно связать с портами консольного сервера.

Выяснить к какому порту какого консольного сервера подключено конкретное устройство.

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/console-ports/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.console_ports.get(device="mlg-leaf-0").serialize()

    Метод **serialize** в pynetbox позволяет преобразовать атрибуты экземпляра класса в словарь.


IPAM
----

VLAN и VRF
~~~~~~~~~~

Могут быть привязаны к локации - полезно для VLAN.
При создании VRF можно указать, допускается ли пересечение адресного пространства с другими VRF.


Получить список всех VLAN:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/vlans/" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.ipam.vlans.all()

Получить список всех VRF:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/vrfs/" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.ipam.vrfs.all()

IP-префиксы
~~~~~~~~~~~

Имеют иерархическую структуру. Может принадлежать какому-либо VRF (если не принадлежит - то Global).

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/prefixes.png           
           :width: 800
           :align: center

В NetBox очень удобное визуальное представление свободных префиксов:

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/available_prefixes.png           
           :width: 800
           :align: center

Выделить можно просто кликом на зелёную строчку.

Может быть привязан к локации. Можно через API выделить следующий свободный под-префикс нужного размера или следующий свободный IP-адрес. 
Галочка/параметр "Is a pool" определяет, будет ли при автоматическом выделении выделяться 0-й адрес из этого префикса, или начнётся с 1-го. 

Получить список IP-префиксов сайта Малага c ролью Underlay и длиной 19:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/?site=mlg&role=underlay&mask_length=19" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       prefix = nb.ipam.prefixes.get(site="mlg", role="underlay", mask_length="19")

Получить список свободных префиксов в регионе Россия c ролью Underlay:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/40/available-prefixes/" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       prefix.available_prefixes.list()

Выделить следующий свободный префикс длиной в 24:

    .. code-block:: bash
    
       curl -X POST "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/40/available-prefixes/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f" \
       -d "{\"prefix_length\": 24}"

    .. code-block:: python
    
       prefix.available_prefixes.create({"prefix_length":24})

    Когда внутри одного объекта нам нужно выделить какой-то дочерний, используется метод POST и нужно указать ID родительского объекта - в данном случае - **40**. Его мы выяснили вызовом из предыдущего примера.
    В случае pynetbox мы сначала (в предыдущем примере) сохранили результат в переменную **prefix**, а далее обратились к его атрибуту **available_prefixes** и методу **create**.
    Этот пример у вас **не сработает**, поскольку токен с правом записи уже недействителен.

IP-адреса
~~~~~~~~~

Если есть включающий этот адрес префикс, то будут его частью. Могут быть и сами по себе.
Могут принадлежать какому-либо VRF или быть в Global.
Могут быть привязаны к интерфейсу, а могут висеть в воздухе.
Можно выделить следующий свободный IP-адрес в префиксе.

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/ip_addresses.png           
           :width: 800
           :align: center

Чтобы сделать это, просто нужно кликнуть по зелёной строчке.


Получить список IP-адресов конкретного интерфейса:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?interface_id=8" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.ipam.ip_addresses.filter(interface_id=8)
       
Или:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?device=mlg-leaf-0&interface=Ethernet1" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.ipam.ip_addresses.filter(device="mlg-leaf-0", interface="Ethernet1")

Получить список всех IP-адресов устройства:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/ip-addresses/?device=mlg-leaf-0" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.ipam.ip_addresses.filter(device="mlg-leaf-0")

Получить список доступных IP-адресов префикса:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/28/available-ips/" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       prefix = nb.ipam.prefixes.get(site="mlg", role="leaf-loopbacks")
       prefix.available_ips.list()

    Здесь снова нужно в URL указать ID префикса, из которого выделяем адрес - на сей раз это 28.

Выделить следующий свободный IP-адрес в префиксе:

    .. code-block:: bash
    
       curl -X POST "http://netbox.linkmeup.ru:45127/api/ipam/prefixes/28/available-ips/" \
       -H "accept: application/json" \
       -H "Content-Type: application/json" \
       -H "Authorization: TOKEN a9aae70d65c928a554f9a038b9d4703a1583594f"

    .. code-block:: python
    
       prefix.available_ips.create()


Виртуализация
-------------

Мы же всё-таки боремся за звание современного ДЦ. Куда же без виртуализации.
NetBox не выглядит и не является местом, где стоит хранить информацию о виртуальных машинах (даже о необходимости хранения в нём физических машин можно порассуждать). Однако нам это может оказаться полезным, например, можно занести информация о Route Reflector'ах, о служебных машинах, таких как NTP, Syslog, S-Flow-серверах, о машинах-управляках. 
ВМ обладает своим списком интерфейсов - они отличны от интерфейсов физических устройств и имеют свой отдельный Endpoint.

Так можно вывести список всех виртуальных машин:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/virtualization/virtual-machines/" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.virtualization.virtual_machines.all()

Так - всех интерфейсов всех ВМ:

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/virtualization/interfaces/" -H "Accept: application/json; indent=4" 

    .. code-block:: python
    
       nb.virtualization.interfaces.all()

Для ВМ нельзя указать конкретный гипервизор/физическую машину, на котором она запущена, но можно указать кластер. Хотя не всё так безнадёжно. Читаем дальше.


Дополнительные приятные вещи
----------------------------

Основная функциональность NetBox закрывает большинство задач многих пользователей, но не все. Всё-таки изначально продукт написан для решения задач конкретной компании. Однако он активно развивается и новые релизы выходят довольно `часто <https://github.com/netbox-community/netbox/releases>`_. Соответственно появляются и новые функции.
Так, например, с моей первой установки NetBox пару лет назад в нём появились теги, config contexts, webhooks, кэширование, supervisord сменился на systemd, внешние хранилища для файлов.

Custom fields
~~~~~~~~~~~~~

Иногда хочется к какой-либо сущности добавить поле, в которое можно было бы поместить произвольные данные. 
Например, указать номер договора поставки, по которому был приобретён коммутатор или имя физической машины, на которой запущена ВМ. 
Тут на помощь и приходит custom fields - как раз такое поле с текстовым значением, которое можно добавить почти к любой сущности в NetBox.

Создаётся Custom fields в админской панели

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/nb_custom_fields.png
           :width: 600
           :align: center

Вот так это выглядит при редактировании устройства, для которого был создан custom field:

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/nb_custom_field_edit.png
           :width: 450
           :align: center

Запросить список устройств по значению custom_field

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?cf_contract_number=0123456789" -H "Accept: application/json; indent=4"

    .. code-block:: python
    
       nb.dcim.devices.filter(cf_contract_number="0123456789")

Config Context
~~~~~~~~~~~~~~

Иногда хочется чего-то большего, чем неструктурированный текст. Тогда на помощь приходит `Config Context <http://netbox.linkmeup.ru:45127/extras/config-contexts/1/>`_.
Это возможность ввести набор структурированных данных в формате JSON, который больше некуда поместить.
Это может быть, например, набор BGP communities или список Syslog-серверов.
Config Context может быть локальным - настроенным для конкретного объекта - или глобальным, когда он настраивается однажды, а затем распространяется на все объекты, удовлетворяющие определённым условиям (например, расположенные на одном сайте, или запущенные на одной платформе).

    .. figure:: https://fs.linkmeup.ru/images/adsm/3/config_context.png           
           :width: 800
           :align: center

Config Context автоматически добавляется к результатам запроса. При этом локальные и глобальные контексты сливаются в один.

Например, для устройства just a simple russian girl, для которого есть локальный контекст, в выводе будет ключ "config_context":

    .. code-block:: bash
    
       curl -X GET "http://netbox.linkmeup.ru:45127/api/dcim/devices/?q=russian" -H "Accept: application/json; indent=4"

    .. code-block:: python
       
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
       }

Теги
~~~~

Про теги сложно сказать что-то новое. Они есть. Они удобны для добавления какого-либо признака. К примеру, можно пометить тегом "бяда" коммутаторы из партии, в которой сбоит память.

Webhooks
~~~~~~~~

Незаменимая вещь, когда нужно, чтобы об изменениях в NetBox'е узнавали другие сервисы.
Например, при заведении нового коммутатора отправляется хука в систему автоматизации, которая запускает процесс настройки устройства и ввода в эксплуатацию. 