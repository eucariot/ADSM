YANG
====

| Оооо, как долго я шёл к этому, как долго я ждал, чтобы разобраться с этой темой.
| Такой манящий и такой недоступный - **YANG** - *Yet Another Next Generation*, который решит все мои дилеммы автоматизатора, который снимет с меня груз парсинга CLI и приведёт нас всех в новый дивный мир.
| Почему-то казалось, что стоит только понять, что такое YANG - и дальше самой сложной задачей останется оттраблшутить Ансибль и высадиться на Марсе.

YANG, а точнее модели, написанные на нём, не стали серебряной пулей, как не стали ей (пока) NETCONF, OpenConfig, gNMI.

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/yang-data-model.png
           :width: 800
           :align: center

И вообще YANG - вещь весьма академическая. Это просто язык описания моделей. Модели у каждого производителя и под каждую задачу могут быть совершенно разными, но, учитывая, что они все написаны на одном языке, мы можем применять одни и те же подходы и инструменты для работы с ними, и не отращивать ещё новые нейронные связи.

Вообще-то модели может не быть вовсе, или она может быть описана по-английски или по-русски, вместо YANG. Но при этом в JunOS/VRP/IOS по-прежнему будет какая-то структура данных. Просто в этом случае у вас не будет контракта, и в суд вы обратиться не сможете.
Это собственно то, как мы и жили прежде.

| Вообще-то YANG пришёл на помощь NETCONF'у, когда стало понятно, что <s>достаточно разврата - откапывайте SNMP SMI</s> без моделей дальше никуда ни шагу - и уже достаточно ошибок было совершено.
| YANG - достойный сын SMIng. Когда парни из Network Working Group поняли, что с SNMP у них как-то не выгорело, весь накопленный багаж знаний они пустили на пользу обществу.
| В общем-то, не мудрствуя лукаво, ребята из IETF взяли синтаксическую структуру и базовые типы из SMIng и запилили YANG.
| При разработке YANG решили не совершать ошибок SMIng, который должен был стать универсальным языком под общие задачи, отчего немало страдал - нет, YANG нацеливался исключительно на NETCONF.
| И какова ирония: RESTCONF и gNMI тоже решили использовать YANG - как язык моделирования. Ну логично ведь - не выдумывать 13-й стандарт же (хотя, подождите)?

Но гугл пошёл ещё дальше - gNMI может работать как с YANG-моделями, так и нет. Свободу вариативности! Что, впрочем, вполне логично, ведь в основе gNMI - protobuf'ы gRPC. А они могут как быть созданы на основе YANG-модели, так и просто придуманы из головы, или модель может быть написана не на YANG.

Как видно, благими намерениями уже тогда - был устлан путь к хьюман-ридабл, мэшин-парсибл.

Давайте мы не будем закапываться в сам язык - пожалуй, это нужно не очень большому числу людей. Нам интереснее практическая сторона - конкретные модели, как в них найти глазами нужные вещи, как с ними работать программно, какая вообще от них польза.

Дальше в качестве практики возьмём модель OpenConfig.

Препарируем YANG-модель
-----------------------

Давайте ещё раз вспомним пример, как мы собирали данные по конфигурации интерфейсов.

    .. code-block:: bash

       gnmic get --path "/interfaces/interface/subinterfaces/subinterface/ipv4/addresses/address/config" \
             -a bcn-spine-1.arista:6030 \
             -u eucariot \
             -p password \
             --insecure

Откуда взялся этот замысловатый путь?

Для этого нам понадобится взглянуть на `открытый репозиторий OpenConfig <https://github.com/openconfig/public/tree/master/release/models/interfaces>`_.

| Пристально смотрим…
| Ещё немного…
| Понятно?

| И мне не очень. Чтобы такое читать, надо всё же разбираться с самим языком.
| Нам лень.
| Поэтому воспользуемся помощью библиотеки pyang.


Pyang
-----

Продолжим с примером про интерфейсы.

    .. code-block:: bash

       sudo pip install pyang


В рабочий каталог склоним репу:

    .. code-block:: bash

       git clone https://github.com/openconfig/public

И дадим вот такую команду:

    .. code-block:: bash

       pyang -f tree -p yang/oc/public/release/models/ yang/oc/public/release/models/interfaces/openconfig-interfaces.yang

И дальше вываливается много текста:

    .. code-block:: bash

       module: openconfig-interfaces
         +--rw interfaces
            +--rw interface* [name]
               +--rw name             -> ../config/name
               +--rw config
               |  +--rw name?            string
               |  +--rw type             identityref
               |  +--rw mtu?             uint16
               |  +--rw loopback-mode?   boolean
               |  +--rw description?     string
               |  +--rw enabled?         boolean
               +--ro state
               |  +--ro name?            string
               |  +--ro type             identityref
               |  +--ro mtu?             uint16
               |  +--ro loopback-mode?   boolean
               |  +--ro description?     string
               |  +--ro enabled?         boolean
               |  +--ro ifindex?         uint32
               |  +--ro admin-status     enumeration
               |  +--ro oper-status      enumeration
               |  +--ro last-change?     oc-types:timeticks64
               |  +--ro logical?         boolean
               |  +--ro management?      boolean
               |  +--ro cpu?             boolean
               |  +--ro counters
               |     +--ro in-octets?             oc-yang:counter64
               |     +--ro in-pkts?               oc-yang:counter64
               |     +--ro in-unicast-pkts?       oc-yang:counter64
               |     +--ro in-broadcast-pkts?     oc-yang:counter64
               |     +--ro in-multicast-pkts?     oc-yang:counter64
               |     +--ro in-discards?           oc-yang:counter64
               |     +--ro in-errors?             oc-yang:counter64
               |     +--ro in-unknown-protos?     oc-yang:counter64
               |     +--ro in-fcs-errors?         oc-yang:counter64
               |     +--ro out-octets?            oc-yang:counter64
               |     +--ro out-pkts?              oc-yang:counter64
               |     +--ro out-unicast-pkts?      oc-yang:counter64
               |     +--ro out-broadcast-pkts?    oc-yang:counter64
               |     +--ro out-multicast-pkts?    oc-yang:counter64
               |     +--ro out-discards?          oc-yang:counter64
               |     +--ro out-errors?            oc-yang:counter64
               |     +--ro carrier-transitions?   oc-yang:counter64
               |     +--ro last-clear?            oc-types:timeticks64
               +--rw hold-time
               |  +--rw config
               |  |  +--rw up?     uint32
               |  |  +--rw down?   uint32
               |  +--ro state
               |     +--ro up?     uint32
               |     +--ro down?   uint32
               +--rw subinterfaces
                  +--rw subinterface* [index]
                     +--rw index     -> ../config/index
                     +--rw config
                     |  +--rw index?         uint32
                     |  +--rw description?   string
                     |  +--rw enabled?       boolean
                     +--ro state
                        +--ro index?          uint32
                        +--ro description?    string
                        +--ro enabled?        boolean
                        +--ro name?           string
                        +--ro ifindex?        uint32
                        +--ro admin-status    enumeration
                        +--ro oper-status     enumeration
                        +--ro last-change?    oc-types:timeticks64
                        +--ro logical?        boolean
                        +--ro management?     boolean
                        +--ro cpu?            boolean
                        +--ro counters
                           +--ro in-octets?             oc-yang:counter64
                           +--ro in-pkts?               oc-yang:counter64
                           +--ro in-unicast-pkts?       oc-yang:counter64
                           +--ro in-broadcast-pkts?     oc-yang:counter64
                           +--ro in-multicast-pkts?     oc-yang:counter64
                           +--ro in-discards?           oc-yang:counter64
                           +--ro in-errors?             oc-yang:counter64
                           +--ro in-unknown-protos?     oc-yang:counter64
                           +--ro in-fcs-errors?         oc-yang:counter64
                           +--ro out-octets?            oc-yang:counter64
                           +--ro out-pkts?              oc-yang:counter64
                           +--ro out-unicast-pkts?      oc-yang:counter64
                           +--ro out-broadcast-pkts?    oc-yang:counter64
                           +--ro out-multicast-pkts?    oc-yang:counter64
                           +--ro out-discards?          oc-yang:counter64
                           +--ro out-errors?            oc-yang:counter64
                           +--ro carrier-transitions?   oc-yang:counter64
                           +--ro last-clear?            oc-types:timeticks64

| Неплохо. С такими аргументами pyang представляет модель в виде дерева, выбрасывая несущественные данные.
| Здесь сразу видно, на каком уровне иерархии что находится, какой у него тип и режим - rw или ro.
| Постойте, но где же ipv4, который в запросе gnmic? Тут его явно нет. А в запросе и ответе явно был - то есть где-то он должен существовать и в модели.
| Взглянем ещё раз на директорию. И повторим pyang:

    .. code-block:: bash

       pyang -f tree  -p yang/oc/public/release/models/ yang/oc/public/release/models/interfaces/openconfig-if-ip.yang | head -n 10
       module: openconfig-if-ip

         augment /oc-if:interfaces/oc-if:interface/oc-if:subinterfaces/oc-if:subinterface:
           +--rw ipv4
              +--rw addresses
              |  +--rw address* [ip]
              |     +--rw ip        -> ../config/ip
              |     +--rw config
              |     |  +--rw ip?              oc-inet:ipv4-address
              |     |  +--rw prefix-length?   uint8

Вот и он во всей красе. И тут видно, что это аугментация к модели `/oc-if:interfaces/oc-if:interface/oc-if:subinterfaces/oc-if:subinterface`.

А что такое `oc-if`?

    .. code-block:: bash

       less yang/oc/public/release/models/interfaces/openconfig-interfaces.yang | grep '^ *prefix'
       prefix "oc-if";

| Итак, у модели есть короткий префикс для более удобного обращения к ней. Он используется в другой модели, чтобы сделать его аугментацию.
| Так можно просто проверить корректность

    .. code-block:: bash

       pyang -p yang/oc/public/release/models/ yang/oc/public/release/models/interfaces/openconfig-interfaces.yang


| Ключ `-f` позволяет конвертировать в разные форматы: `tree`, `yin`, `yang`, `jstree`, `uml` и другие.
| Для нас интереснее всего `tree` и `uml`, потому что вот такие крутые картинки можно рисовать для визуалов

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/openconfig-interfaces.png
           :width: 800
           :align: center
    
    *Чтобы конвертировать uml в png можно воспользоваться пакетом plantuml*. `Ссылка на картинку побольше <https://fs.linkmeup.ru/images/adsm/5/openconfig-interfaces.png>`_

С помощью pyang, конечно, можно работать не только с моделями OpenConfig, но и с любыми другими, написанными на языке YANG.

`Место, где неплохо описан pyang <https://www.ietf.org/proceedings/90/slides/slides-90-edu-yang-0.pdf>`_.

А `тут <https://ultraconfig.com.au/blog/learn-yang-full-tutorial-for-beginners/>`_ бравые парни из Австралии пишут свою модель. С этой работой будет полезно ознакомиться тем, кто хочет разобраться поглубже в языке YANG.

На сегодняшний день многие вендоры поддерживают YANG-схему для своих NETCONF/gNMI-интерфейсов.

Есть несколько мест, где их можно раздобыть:

* `Официальный репозиторий YANG <https://github.com/YangModels/yang/tree/master/vendor>`_. Тут есть ссылки на гитхабы вендоров, которые публикуют свои модели.
  
* Но Huawei, например, хранит свои YANG-и в нескольких местах (https://github.com/Huawei/yang/ и https://github.com/HuaweiDatacomm/yang)
  
* Отдельно так же лежат схемы аристы: https://github.com/aristanetworks/yang
  
* Некоторые вендоры могут хранить их на своих сайтах.
  
В общем, собираем с репы по коммиту. 

| Замечательная новость в том, что все коробки, заявляющие своё соответствие RFC6022 должны уметь возвращать всю YANG-схему по запросу с операцией `<get_schema>`.
| Отвратительная новость в том, что не все вендоры эту операцию поддерживают.

Что нужно знать про YANG?
~~~~~~~~~~~~~~~~~~~~~~~~~

| Это способ описать структуру данных, но не сами данные.
| Сами данные могут быть представлены в любом формате, поддерживающем структуры: XML, JSON, Protobuf, объекты Python.
| YANG придумывали не для того, чтобы решить общую задачу, он нацелен на конкретно NETCONF и конкретно XML-кодирование. Но его смогли присобачить и к другим интерфейсам.

Я бы взял на себя смелость сказать, что NETCONF/YANG - это как TCP/IP. То есть там и про NETCONF, и про YANG. Однако не только NETCONF.

| Очевидно, YANG - огромная тема, которой будет тесно даже на страницах отдельной книги. В этой статье мне хотелось только приоткрыть первый её разворот, на котором ещё нет пугающих выкладок.
| Возможно, когда-то, если я осознаю неизбежность его повсеместного проявления, я напишу отдельную огромную статью и о нём. А пока положим достаточным эти едва ли заметные тропинки. 


Model Driven Programmability
============================

Так что же это такое? Ведомая моделью программируемость? Теперь, после двух статей, нам хватит пары минут, чтобы разобраться что это такое.

Давайте вернёмся к `4-й части АДСМ <https://linkmeup.ru/blog/1275/>`_, где я использовал позаимствованную у Дмитрия Тесля картинку.

    .. figure:: https://dteslya.engineer/images/2020-10-netdevops-pipeline.png
    
    *`Источник: dteslya.engineer/network_automaiton_101 <https://dteslya.engineer/network_automaiton_101/>`_*

Она ведь очень понятная? Inventory, Git с шаблонами конфигурации, рендер, валидация, применение.

| Где закопаны два мешка с человеко-неделями? Под шаблонами с генераторами и под системами применения конфигурации.
| Со вторым пытаются бороться NETCONF, RESTCONF, gNMI.
| А с первым - модели.

Проблема в том, что шаблоны мы составляем руками на основе изучения документации, интерфейса коробки и действуем методом проб и ошибок, вообще-то. Если нужна проверка типов, диапазонов, если меняется иерархия - будьте добры сами всё это написать и обработать. И, окончив, уехать в сумасшедший дом, учить друзей джинджа-программированию. 

Model Driven меняет картину следующим образом:


    .. figure:: https://fs.linkmeup.ru/images/adsm/5/model-driven.png
           :width: 800
           :align: center

    *Не могу найти, откуда брал эту картинку.*

| Здесь шаблоны конфигурации заменяются на YANG-модель (в данном случае OpenConfig).
| Из инвентарки (топологии) и этих моделей рендерится конфиг, который с помощью RPC (тут gRPC) прогружается на коробку.

Model Driven означает тут, что мы

| А) не думаем (или думаем меньше) про иерархию, типы данных. Перестаём мыслить тегами XML.
| Б) Модель определяет, как будет выглядеть конфигурация, как с ней работать.
| В) Использование точно такой же модели на устройстве гарантирует, что отправленное нами, будет принято и валидно на той стороне, коль скоро оно валидно на этой.

| Иными словами именно модель управляет тем, как мы и железо будет работать с конфигурацией.
| Вот и вся суть.