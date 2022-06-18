RESTCONF
========

| Просто пара слов об этом мертворожденном протоколе.
| Это помесь RESTAPI и NETCONF, которая была призвана упростить управление сетью для WEB-приложений.
| Внутри идеологически это NETCONF с его datastores и способами работать с конфигурацией, однако в качестве транспорта - HTTP с набором операций CRUD, реализованных через стандартные методы (*GET*, *POST*, *PUT*, *PATCH*, *DELETE*).
| Данные передаются в формате JSON или XML.
| В качестве модели данных используется YANG.

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/restconf.png
           :width: 800
           :align: center

Описан в `RFC8040 <https://datatracker.ietf.org/doc/html/rfc8040>`_.

| Не могу отказать себе в удовольствии попробовать.
| Возьмём на этот раз Arista veos-4.21.

Что нужно настроить, чтобы заработал restconf:

# Выпускаем самоподписанный сертификат

    .. code-block:: bash

       security pki certificate generate self-signed restconf.crt key restconf.key generate rsa 2048 parameters common-name restconf
       certificate:restconf.crt generated


  
# Разрешаем доступ на устройство по порту 6020 - правим `control-plane acl`
      
    Смотрим то, что разрешено сейчас - это readonly acl.

        .. code-block:: bash

           show ip access-lists default-control-plane-acl

 
# Копируем правила и создаём копию ACL. Добавляем правило, разрешающее доступ по порту 6020  

    .. code-block:: bash

       ip access-list control-plane-acl-with-restconf
       9 permit tcp any any eq 6020
       30 permit udp any any eq bfd ttl eq 255
       40 permit udp any any eq bfd-echo ttl eq 254
       50 permit udp any any eq multihop-bfd
       60 permit udp any any eq micro-bfd
       70 permit ospf any any
       80 permit tcp any any eq ssh telnet www snmp bgp https msdp ldp
       90 permit udp any any eq bootps bootpc snmp rip ntp ldp
       100 permit tcp any any eq mlag ttl eq 255
       110 permit udp any any eq mlag ttl eq 255
       120 permit vrrp any any
       130 permit ahp any any
       140 permit pim any any
       150 permit igmp any any
       160 permit tcp any any range 5900 5910
       170 permit tcp any any range 50000 50100
       180 permit udp any any range 51000 51100
       190 permit tcp any any eq 3333
       200 permit tcp any any eq nat ttl eq 255
       210 permit tcp any eq bgp any
       220 permit rsvp any any
  
# Применяем ACL на Control-Plane

    .. code-block:: bash

       control-plane
          ip access-group control-plane-acl-with-restconf in
  
# Включаем сервис RESTCONF

    .. code-block:: bash

       management api restconf
           transport https test
           ssl profile restconf
  
# Настраиваем SSL

    .. code-block:: bash

       management security
           ssl profile restconf
           certificate restconf.crt key restconf.key

# Вы божественны

Теперь проверяем, что порт открыт

    .. code-block:: bash

       nc -zv bcn-spine-1.arista 6020
       Connection to bcn-spine-1.arista 6020 port [tcp/*] succeeded!

И собственно курлим:

    .. code-block:: bash

       curl -k -s GET 'https://bcn-spine-1.arista:6020/restconf/data/openconfig-interfaces:interfaces/interface=Management1' \
            --header 'Accept: application/yang-data+json' \
            -u eucariot:password

Так мы извлекли информацию про интерфейс `Management1`.

А вот так можно получить данные по BGP:

    .. code-block:: bash

       curl -k -s GET 'https://bcn-spine-1.arista:6020/restconf/data/network-instances/network-instance/config/protocols' \
            --header 'Accept: application/yang-data+json' \
            -u eucariot:password | jq

Строка URL формируется следующим образом:

    .. code-block:: bash

       https://<ADDRESS>/<ROOT>/data/<[YANG-MODULE]:CONTAINER>/<LEAF>/[?<OPTIONS>]

* **&lt;ADDRESS&gt;** - адрес RESTCONF-сервера.
* **&lt;ROOT&lt;** - Точка входа для запросов RESTCONF. Можно найти тут : https://&lt;ADDRESS&gt;/.well-known/
* **data** - прям так и остаётся
* **&lt;[YANG MODULE:]CONTAINER&gt;** - Базовый контейнер YANG. Наличие YANG Module - не обязательно. 
* **&lt;LEAF&gt;** - Отдельный элемент в контейнере
* **&lt;OPTIONS&gt;** - Опциональные параметры, влияющие на результат.


Пробуем выяснить `<ROOT>`:

    .. code-block:: bash

       curl -k https://bcn-spine-1.arista:6020/.well-known/host-meta
       <XRD xmlns=’http://docs.oasis-open.org/ns/xri/xrd-1.0’>
           <Link rel=’restconf’ href=’/restconf’/>
       </XRD>

| Ну можно и настроить что-нибудь:
| К примеру hostname.

    .. code-block:: bash

       curl -k -X PUT https://bcn-spine-1.arista:6020/restconf/data/system/config \
            -H 'Content-Type: application/json' -u eucariot:password \
            -d '{"openconfig-system:hostname":"vika-kristina-0"}'

       {"openconfig-system:hostname":"vika-kristina-0"}

Проверим?

    .. code-block:: bash

       curl -k -X GET https://bcn-spine-1.arista:6020/restconf/data/system/config \
            --header 'Accept: application/yang-data+json' \
            -u eucariot:password

       {"openconfig-system:hostname":"bcn-spine-1","openconfig-system:login-banner":"","openconfig-system:motd-banner":""}

Что? Не поменялось?! И оно действительно не поменялось. Я не смог заставить это работать.

| В общем знакомство с RESTCONF пока скорее травматично: документации исчезающие мало, большая часть ссылок - на космические корабли, бороздящие просторы неизученной Вселенной, примеры работы с RESTCONF все как один однообразны, а некоторые просто не работают. С той же аристой использование разных моделей - ietf, openconfig приводит к одному ответу в виде OpenConfig.
| В конце концов отсутствие в выдаче хоть сколько-то серьёзных работ по автоматизации с помощью RESTCONF говорит о том, что это всё не более чем баловство. И я намеренно не пишу слово "пока". Лично я в него не верю

| Хотя ощутимые удобства присутствуют - это использование чуть более привычного интерфейса и существующих библиотек. И с точки зрения разработчика несколько проще - он теперь имеет дело со знакомым с пелёнок WEB-сервисом.
| При этом CRUD не очень гладко ложится на RPC-подход, да и в идее держать открытым на сетевом железе HTTP есть что-то противоестественное, согласитесь?

Просто жаль сил, вложенных в этот протокол. Потому что на пятки ему наступает gRPC/gNMI.

На самостоятельное изучение: `RESTCONF intro with Postman - Part 1 <https://blog.wimwauters.com/networkprogrammability/2020-04-02_restconf_introduction_part1>`_
