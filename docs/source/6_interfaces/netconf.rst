NETCONF
=======

| Ох, как я вился вокруг этого нетконфа в своё время, ожидая, что это серебряная пуля, решающая если не все, то 99,99% всех проблем сетевых инженеров.
| Спойлер: это не так.

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/netconf-snmp-sw.jpg
           :width: 800
           :align: center

Если вам по какой-то причине кажется, что стандарты рождаются где-то в недрах институтов, оторванных от жизни, то вот вам контр-пример.

| В 1996 был основан Juniper Networks, в недрах которого создали легендарный М40 и лучший в мире интерфейс командной строки. До сих пор никто не сделал ничего лучшего - все только повторяют.
| Операционка, предоставляющая клиенту обычный текстовый интерфейс, на самом деле перекладывает команды в XML, который фактически является интерфейсом для управления устройством.
| Если вы сейчас к любой show-команде на джуне добавите ``| display xml``, то увидите ответ в формате XML 

    .. code-block:: xml

       eucariot@kzn-spine-0> show system uptime | display xml
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/18.3R3/junos">
           <multi-routing-engine-results>
               <multi-routing-engine-item>
                   <re-name>localre</re-name>
                   <system-uptime-information xmlns="http://xml.juniper.net/junos/18.3R3/junos">
                       <current-time>
                           <date-time junos:seconds="1641211199">2022-01-03 14:59:59 MSK</date-time>
                       </current-time>
                       <time-source> LOCAL CLOCK </time-source>
                       <system-booted-time>
                           <date-time junos:seconds="1614866046">2021-03-04 16:54:06 MSK</date-time>
                           <time-length junos:seconds="26345153">43w3d 22:05</time-length>
                       </system-booted-time>
                       <protocols-started-time>
                           <date-time junos:seconds="1614866101">2021-03-04 16:55:01 MSK</date-time>
                           <time-length junos:seconds="26345098">43w3d 22:04</time-length>
                       </protocols-started-time>
                       <last-configured-time>
                           <date-time junos:seconds="1638893962">2021-12-07 19:19:22 MSK</date-time>
                           <time-length junos:seconds="2317237">3w5d 19:40</time-length>
                           <user>scamp</user>
                       </last-configured-time>
                       <uptime-information>
                           <date-time junos:seconds="1641211200">3:00PM</date-time>
                           <up-time junos:seconds="26345160">304 days, 22:06</up-time>
                           <active-user-count junos:format="1 users">1</active-user-count>
                           <load-average-1>0.20</load-average-1>
                           <load-average-5>0.17</load-average-5>
                           <load-average-15>0.20</load-average-15>
                           <user-table></user-table>
                       </uptime-information>
                   </system-uptime-information>
               </multi-routing-engine-item>
           </multi-routing-engine-results>
           <cli>
               <banner>{master:0}</banner>
           </cli>
       </rpc-reply>
       

В корне вы можете видеть ``<rpc-reply>``, что означает, что был какой-то ``<rpc>``-request. И вот так вы можете увидеть, каким RPC-запросом можно получить такие данные:

    .. code-block:: xml

       eucariot@kzn-spine-0> show version | display xml rpc
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/18.3R3/junos">
           <rpc>
               <get-software-information>
               </get-software-information>
           </rpc>
           <cli>
               <banner>{master:0}</banner>
           </cli>
       </rpc-reply>

       *Внимание, работает только для Juniper!*

Так вот, их CLI и способ взаимодействия его с системой оказался настолько естественным и удачным, что его и положили в основу стандарта. Не без участия Juniper Networks, конечно же, появился `RFC4741 <https://www.ietf.org/rfc/rfc4741.txt>`_. Будем честны, один только джунипер там и постарался. И то тут, то там будут проскакивать его куски, начиная с ``commit confirmed`` и заканчивая ``candidate config``.

Вот как NETCONF был определён в 2006-м году:

    .. code-block:: text

       Abstract
       The Network Configuration Protocol (NETCONF) defined in this document
       provides mechanisms to install, manipulate, and delete the
       configuration of network devices.  It uses an Extensible Markup
       Language (XML)-based data encoding for the configuration data as well
       as the protocol messages.  The NETCONF protocol operations are
       realized on top of a simple Remote Procedure Call (RPC) layer.

И определение с тех пор не менялось - вся суть NETCONF в этом параграфе.

А теперь давайте разбираться с очень непростым NETCONF и его составными частями.

NETCONF и его команды
---------------------

Если совсем коротко, NETCONF - это четырёхуровневый стек, согласно которому через SSH передаётся RPC, где указана операция и конкретный набор действий (контент).

    .. figure:: https://fs.linkmeup.ru/images/adsm/5/netconf.png
           :width: 800
           :align: center


Стек NETCONF
~~~~~~~~~~~~

Итак, в качестве транспорта NETCONF использует SSH. На самом деле, там есть и другие протоколы: SSH, SOAP, BEEP, TLS - но мы их опустим - SSH стал де-факто стандартом.

Каждый NETCONF запрос содержит элемент (или сообщение):


* ``<rpc>`` - это собственно запрос на вызов процедуры с необходимыми параметрами.
* ``<rpc-reply>`` - ответ на RPC.
      
        * ``<rpc-error>`` - очевидно, ответная ошибка, когда RPC некорректен.
        * ``<ok>`` - rpc корректен и отработал.
   
* ``<notification>`` - сообщение о событии, инициированное сетевой коробкой - аналог трапа в snmp. (из `RFC6241 <https://www.ietf.org/rfc/rfc6241.txt>`_)

Это всё сообщения, внутри которых определённым образом сформированные XML. 

| Внутри сообщения определяется какая операция (действие) исполняется.
| Ниже полный их список, определённый в RFC:

* ``<get>`` - retrieve running configuration and device state information
* ``<get-config>`` - retrieve all or part of a specified configuration datastore
* ``<edit-config>`` - edit a configuration datastore by creating, deleting, merging or replacing content
* ``<copy-config>`` - copy an entire configuration datastore to another configuration datastore
* ``<delete-config>`` - delete a configuration datastore
* ``<lock>`` - lock an entire configuration datastore of a device
* ``<unlock>`` - release a configuration datastore lock previously obtained with the <lock> operation
* ``<close-session>`` - request graceful termination of a netconf session
* ``<kill-session>`` - force the termination of a netconf session

Каждый вендор может расширять список операций хоть до бесконечности. Так, у кого-то, например, есть ``<copy-config>``.

| И далее уже сам контент. Это самая сложная часть.
| Но забегая вперёд - он никак не формализован, не описан, и, возможно, это величайшая претензия к нетконф, как стандарту, позволившему благую идею превратить в очередного зомби.
| Даже удивительно, что после опыта с SNMP, где необходимость языка моделирования стала очевидна со временем, NETCONF родился сам по себе без какого-либо языка спецификации для данных. Уже много позже для этого подтянули YANG.

Установка сессии и Capabilities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Так, сначала включаем SSH NETCONF. На примере джунипер.

    .. code-block:: text

       set system services netconf


    | Это значит, что SSH будет использоваться как транспорт для указанной подсистемы.
    | Для netconf IANA установила специальный порт 830, хотя часто используется и обычный для SSH 22.

| И пробуем подключиться.
| Для того, чтобы указать, что это не просто подключение по SSH, мы используем вызов подсистемы:

    .. code-block:: xml

       ssh kazan-spine-0.juniper -s netconf
       
       <!-- No zombies were killed during the creation of this user interface -->
       <!-- user eucariot, class j-super-user -->
       <hello xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <capabilities>
           <capability>urn:ietf:params:netconf:base:1.0</capability>
           <capability>urn:ietf:params:netconf:capability:candidate:1.0</capability>
           <capability>urn:ietf:params:netconf:capability:confirmed-commit:1.0</capability>
           <capability>urn:ietf:params:netconf:capability:validate:1.0</capability>
           <capability>urn:ietf:params:netconf:capability:url:1.0?scheme=http,ftp,file</capability>
           <capability>urn:ietf:params:xml:ns:netconf:base:1.0</capability>
           <capability>urn:ietf:params:xml:ns:netconf:capability:candidate:1.0</capability>
           <capability>urn:ietf:params:xml:ns:netconf:capability:confirmed-commit:1.0</capability>
           <capability>urn:ietf:params:xml:ns:netconf:capability:validate:1.0</capability>
           <capability>urn:ietf:params:xml:ns:netconf:capability:url:1.0?protocol=http,ftp,file</capability>
           <capability>http://xml.juniper.net/netconf/junos/1.0</capability>
           <capability>http://xml.juniper.net/dmi/system/1.0</capability>
         </capabilities>
         <session-id>15420</session-id>
       </hello>
       ]]>]]>

| Мы ещё ничего не успели сделать, а железка нам уже насыпала в терминал.
| Это сообщение NETCONF Hello, которое заставляет на берегу договориться, что поддерживается в данной сессии, а что нет.
| Внутри - список капабилитей - возможностей, поддерживаемых коробкой.
| `RFC4741 <https://www.ietf.org/rfc/rfc4741.txt>`_ определял базовый набор функций, который должен поддерживаться каждым клиентом и каждым сервером.

При этом базовые могут расширяться другими стандартизированными capability и даже проприетарными.
Давайте рассмотрим сначала стандартные, а потом самые интересные расширенные. Ну и будем называть их "способностями", а то капабилитя - это почти как капибара.

NETCONF Standard Capabilities (стандартные способности)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


* **Candidate configuration**
    Эта способность говорит о том. Что коробка поддерживает отдельный кандидат-конфиг, содержащий полную конфигурацию, с которой можно работать без влияния на фактически применённую конфигурацию.  Аналоги candidate-config на Juniper.
  
* **Confirmed commit**
    Опять же аналог джуниперовоского commit confirmed - откат изменений после коммита, если не было подтверждения коммита.
  
* **Validate**
    Способность проверить желаемую конфигурацию до её применения.
  
* **Rollback-on-error**
    Способность отмены изменений при ошибке. Работает, если поддерживается способность candidate configuration. 
  
* **Writable-running**
    Такая способность говорит о том, что устройство позволяет писать непосредственно в running-конфигурацию, в обхода candidate.
  
* **Distinct startup**
    Способность задавать startup конфигурацию отличную от running и candidate.
  
* **Notification**
    Аналог SNMP-trap. Коробка может слать аварии и события клиенту.

| И ещё несколько более других способностей, которыми грузить вас не хочу, ибо в лучшем виде они описаны в `RFC <https://www.ietf.org/rfc/rfc6241.txt>`_.
| Посмотрите, кстати, какие способности отдал джунипер, а какие нет.

NETCONF Extended Capabilities (сверх-способности)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Их тьма. Из самых интересных:


* **YANG push**
    Способность отсылать данные с коробки на клиент - периодически или по событию.

* **YANG-library**
    Способность сервера сообщить клиенту о поддерживаемых параметрах относительно YANG: версия, модель, нейспейсы итд.
  
* **Commit-description**
    Самоговорящее название.

| Формат названия capability строго регламентирован: ``urn:ietf:params:netconf:capability:{name}:1.0``.
| Последние два значения - это имя и версия - и только они могут меняться.
| Так ``urn:ietf:params:netconf:base:1.1`` - это имя базовой капабилити для версии 1.1.

В ответ на ``<hello>`` сервера клиент в свою очередь должен послать свои capability:

    .. code-block:: xml

       <hello>
        <capabilities>
         <capability>urn:ietf:params:xml:ns:netconf:base:1.0</capability>
         <capability>urn:ietf:params:xml:ns:netconf:capability:candidate:1.0</capability>
         <capability>urn:ietf:params:xml:ns:netconf:capability:confirmed-commit:1.0</capability>
         <capability>urn:ietf:params:xml:ns:netconf:capability:validate:1.0</capability>
         <capability>urn:ietf:params:xml:ns:netconf:capability:url:1.0?protocol=http,ftp,file</capability>
         <capability>xml.juniper.net/netconf/junos/1.0</capability>
         <capability>xml.juniper.net/dmi/system/1.0</capability>
        </capabilities>
       </hello>
       ]]>]]>


Чего почти нигде не пишут, но что очень важно: если вы пробуете взаимодействовать с коробкой по нетконф руками, то нужно обязательно вручную отослать такую последовательность ``]]>]]>``, сообщающую, что ввод закончен. Она называется **Framing Marker** или **Message Separator Sequence**.

    | Есть важный нюанс, описанный в `RFC6242 <https://www.ietf.org/rfc/rfc6242.txt>`_, ``]]>]]>`` - это старый **End-of-Message Framing Marker**, который был выбран из соображений, что такая последовательность не должна встречаться в well-formed XML. Однако жизнь показала, что она встречается. Поэтому в NETCONF 1.1 придумали новый механизм, который делит данные на блоки - чанки - и нумерует их. Так он и называется: **Chunked Framing Mechanism**.
    | Каждый чанк данных начинается с ``##X``, где ``X`` - это число октетов в нём.
    | Это одно из фундаментальных отличий между 1.0 и 1.1 :). Другие `менее значительны <https://support.yumaworks.com/support/solutions/articles/1000227848-what-are-the-differences-between-netconf-1-0-and-1-1->`_.

Сейчас NETCONF-сессия установлена и можно заслать какой-то RPC. 

Посылаем свой первый RPC

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get-config>
          <source>
            <running/>
          </source>
          <filter type="subtree">
            <configuration>
              <system>
                 <host-name/>
              </system>
            </configuration>
          </filter>
         </get-config>
       </rpc>
       ]]>]]>

    .. code-block:: xml

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
          <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644510087" junos:commit-localtime="2022-02-10 16:21:27 UTC" junos:commit-user="eucariot">
           <system>
               <host-name>kzn-spine-0</host-name>
           </system>
       </configuration>
       </data>
       </rpc-reply>

Мы отправили элемент ``<rpc>``, в котором запросили ``<running>``-конфигурацию с помощью операцию ``<get-config>``. И ещё на сервере отфильтровали по интересной ветке.

А в ответ пришёл ``<rpc-reply>`` с ответом. И в запросе, и в ответе можете найти ``message-id`` - по ним можно отслеживать на что именно ответ - ведь режим работы NETCONF асинхронный и можно засылать следующее сообщение, пока предыдущее ещё не было обработано.

| Здесь вы видите некоторую структуру XML. Её легко можно скормить XML-парсеру, который превратит его в JSON или python dict или что угодно другое, с чем удобно работать в скриптах и программах. И далее извлечь по ключам нужные данные. 
| Но почему XML? За что? Как вообще с этим быть?

| Ох. Зря вы спросили.
| В общем дальше 10 000 знаков про XML. Если вы не готовы это выдержать, милости прошу дальше. Но будьте готовы, что практика NETCONF тогда пройдёт мимо вас. Или вы мимо неё. В общем разминётесь.

Так за что же так с нами?