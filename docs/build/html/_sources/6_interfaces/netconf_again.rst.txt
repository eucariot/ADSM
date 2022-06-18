NETCONF Again
=============

| И вот теперь время взглянуть на операции NETCONF и попрактиковаться.
| Один из принципов NETCONF - это отделение конфигурационных данных от операционных.
| Поэтому отдельными операциями он позволяет управлять конфигурацией, а отдельными - забирать информацию о состоянии.
| Вот базовый неполный список операций NETCONF:

* &lt;get&gt;
* &lt;get-config&gt;
* &lt;edit-config&gt;
* &lt;copy-config&gt;
* &lt;delete-config&gt;
* &lt;lock&gt;
* &lt;unlock&gt;
* &lt;close-session&gt;
* &lt;kill-session&gt;

Но зачастую вендоры определяют свои собственные операции.

Действия, операции
------------------

&lt;get&gt;
~~~~~~~~~~~

| Эта операция возвращает текущие (running) операционные и конфигурационные данные.
| Выполните просто 

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get/>
       </rpc>
       ]]>]]>


| И в ответ получите несколько экранов XML.
| Ответ приходит в `<rpc-reply>`. В случае ошибки внутри `<rpc-reply>` сервер вернёт `<rpc-error>` с текстом ошибки.
| Для получения ошибки можно просто сформировать некорректный XML.
| Например, забудем закрывающий тег `</get>`:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
       </rpc>
       ]]>]]>
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <rpc-error>
       <error-type>protocol</error-type>
       <error-tag>operation-failed</error-tag>
       <error-severity>error</error-severity>
       <error-message>syntax error, expecting &lt;filter&gt; or &lt;/get&gt;</error-message>
       <error-info>
       <bad-element>interfaces</bad-element>
       </error-info>
       </rpc-error>
       </rpc-reply>

Или запросить несуществующую ветку:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
           <interfaces/>
         </get>
       </rpc>
       ]]>]]>

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <rpc-error>
       <error-type>protocol</error-type>
       <error-tag>operation-failed</error-tag>
       <error-severity>error</error-severity>
       <error-message>syntax error, expecting &lt;filter&gt; or &lt;/get&gt;</error-message>
       <error-info>
       <bad-element>interfaces</bad-element>
       </error-info>
       </rpc-error>
       </rpc-reply>

| В зависимости от вендора в ответе на `<get>` будет содержаться либо вообще всё, что вам может дать устройство - полный конфиг и вся информацию по состоянию, либо какую-то часть.
| Так, Juniper возвращается конфиг и совсем немного данных сверху. Для того, чтобы забрать операционные данные нужно использовать специальные операции, например `<get-interface-information>`:

    .. code-block:: xml

       <rpc>
           <get-interface-information/>
       </rpc>

Вот такой будет ответ: `https://pastebin.com/2xTpuSi3 <https://pastebin.com/2xTpuSi3>`_.

    Этому, кстати, сложно найти объяснение. Довольно неудобно для каждой ветки операционных данных иметь собственный RPC. И более того, непонятно как это вообще описывается в моделях данных.

Очевидно, это не всегда (никогда) удобно. Хотелось бы пофильтровать данные. NETCONF позволяет не просто отфильтровать результат, а указать NETCONF-серверу, какую именно часть клиент желает запросить. Для этого используется элемент `<filter>`.


&lt;filter&gt;
~~~~~~~~~~~~~~

| С его помощью можно указать какую именно часть информации вы хотите получить. Можно указывать атрибут фильтрации, поддерживаются subtree и xpath.
| По умолчанию используется subtree, но обычно его задают явно, дабы избежать двусмысленности.

| Давайте на примере get пофильтруем ответ.
| Без фильтра совсем данные вернутся полностью.

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get/>
       </rpc>
       ]]>]]>

Вот такой будет ответ: `https://pastebin.com/MMWXM2eT <https://pastebin.com/MMWXM2eT>`_.

С пустым фильтром не вернётся никаких данных.

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
          <filter type="subtree">
          </filter>
         </get>
       </rpc>
       ]]>]]>

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <database-status-information>
       <database-status>
       <user>eucariot</user>
       <terminal></terminal>
       <pid>31101</pid>
       <start-time junos:seconds="1644636396">2022-02-12 03:26:36 UTC</start-time>
       <edit-path></edit-path>
       </database-status>
       </database-status-information>
       </data>
       </rpc-reply>
       ]]>]]>

Вот таким запросом можно вытащить операционные данные по всем интерфейсам

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
          <filter type="subtree">
            <configuration>
              <interfaces/>
            </configuration>
          </filter>
         </get>
       </rpc>
       ]]>]]>

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:changed-seconds="1644510087" junos:changed-localtime="2022-02-10 16:21:27 UTC">
           <interfaces>
               <interface>
                   <name>ge-0/0/0</name>
                   <unit>
                              <name>0</name>
                              <family>
                           <inet>
                                      <address>
                                   <name>169.254.0.1/31</name>
                                      </address>
                           </inet>
                              </family>
                   </unit>
               </interface>
               <interface>
                   <name>ge-0/0/2</name>
                   <unit>
                              <name>0</name>
                              <family>
                           <inet>
                                      <address>
                                   <name>169.254.100.1/31</name>
                                      </address>
                           </inet>
                              </family>
                   </unit>
               </interface>
               <interface>
                   <name>em0</name>
                   <unit>
                              <name>0</name>
                              <family>
                           <inet>
                                      <address>
                                   <name>192.168.1.2/24</name>
                                      </address>
                           </inet>
                              </family>
                   </unit>
               </interface>
           </interfaces>
       </configuration>
       <database-status-information>
       <database-status>
       <user>eucariot</user>
       <terminal></terminal>
       <pid>31101</pid>
       <start-time junos:seconds="1644636721">2022-02-12 03:32:01 UTC</start-time>
       <edit-path></edit-path>
       </database-status>
       </database-status-information>
       </data>
       </rpc-reply>
       ]]>]]>

Если вы хотите выбрать не все элементы дерева, а только интересующую вас часть, то можно указать, какие именно нужны:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
          <filter type="subtree">
            <configuration>
              <interfaces>
                <interface>
                  <name/>
                  <description/>
                </interface>
              </interfaces>
            </configuration>
          </filter>
         </get>
       </rpc>
       ]]>]]>

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:changed-seconds="1644637011" junos:changed-localtime="2022-02-12 03:36:51 UTC">
           <interfaces>
               <interface>
                   <name>ge-0/0/0</name>
                   <description>kzn-leaf-0</description>
               </interface>
               <interface>
                   <name>ge-0/0/2</name>
                   <description>kzn-edge-0</description>
               </interface>
               <interface>
                   <name>em0</name>
                   <description>mgmt-switch</description>
               </interface>
           </interfaces>
       </configuration>
       <database-status-information>
       <database-status>
       <user>eucariot</user>
       <terminal></terminal>
       <pid>31316</pid>
       <start-time junos:seconds="1644637103">2022-02-12 03:38:23 UTC</start-time>
       <edit-path></edit-path>
       </database-status>
       </database-status-information>
       </data>
       </rpc-reply>
       ]]>]]>

При этом если хочется забрать данные только по конкретному интерфейсу:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
          <filter type="subtree">
            <configuration>
              <interfaces>
                <interface>
                  <name>ge-0/0/0</name>
                </interface>
              </interfaces>
            </configuration>
          </filter>
         </get>
       </rpc>
       ]]>]]>
       
       
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:changed-seconds="1644637011" junos:changed-localtime="2022-02-12 03:36:51 UTC">
           <interfaces>
               <interface>
                   <name>ge-0/0/0</name>
                   <description>kzn-leaf-0</description>
                   <unit>
                              <name>0</name>
                              <family>
                           <inet>
                                      <address>
                                   <name>169.254.0.1/31</name>
                                      </address>
                           </inet>
                              </family>
                   </unit>
               </interface>
           </interfaces>
       </configuration>
       <database-status-information>
       <database-status>
       <user>eucariot</user>
       <terminal></terminal>
       <pid>31316</pid>
       <start-time junos:seconds="1644637321">2022-02-12 03:42:01 UTC</start-time>
       <edit-path></edit-path>
       </database-status>
       </database-status-information>
       </data>
       </rpc-reply>
       ]]>]]>

| Соответственно можно совместить запрос конкретного интерфейса и только тех его полей, которые интересны.
| В одном get-запросе можно выбрать несколько удовлетворяющих деревьев.

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get>
          <filter type="subtree">
            <configuration>
              <interfaces>
                <interface>
                  <name>ge-0/0/0</name>
                  <description/>
                </interface>
              </interfaces>
            </configuration>
          </filter>
         </get>
       </rpc>
       ]]>]]>

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:changed-seconds="1644637011" junos:changed-localtime="2022-02-12 03:36:51 UTC">
           <interfaces>
               <interface>
                   <name>ge-0/0/0</name>
                   <description>kzn-leaf-0</description>
               </interface>
           </interfaces>
       </configuration>
       <database-status-information>
       <database-status>
       <user>eucariot</user>
       <terminal></terminal>
       <pid>31316</pid>
       <start-time junos:seconds="1644637396">2022-02-12 03:43:16 UTC</start-time>
       <edit-path></edit-path>
       </database-status>
       </database-status-information>
       </data>
       </rpc-reply>
       ]]>]]>

Ещё немного про `subtree filtering <https://netdevops.me/2020/netconf-subtree-filtering-by-example/>`_.

| В случае Juniper `<get>` ничем практически не отличается от `<get-config>`. Для того, чтобы забрать операционные данные, нужно воспользоваться другими операциями - специфическими под каждую задачу.
| Узнать их можно достаточно просто:
| `show version | display xml rpc`

| С помощью операций `<get>` удобно забирать операционные данные с устройства. Например, для мониторинга. Или для отладки. Можно выбрать всех BGP-соседей в состоянии Idle, или все интерфейсы с ошибками, данные по маршрутам.
| Да, понятно, что для всего этого есть и более удобные способы, но всё же такой путь есть.

&lt;get-config&gt;
~~~~~~~~~~~~~~~~~~

| Позволяет забрать конфигурацию устройства.
| Могло показаться, что `<get-config>` - это поддерево `<get>`, но это всё-таки не так.

С помощью `<get-config>` можно указать из какого источника мы хотим получить конфигу - `running`, `candidate`, startup итд.

| Ну и можно быть уверенным, что в ответе будут только конфигурационные данные.
| Хотя по своему опыту вам скажу, что вендоры тут могут отличаться изобретательностью, подмешивая оперданные к конфиге.

Забираем текущий конфиг:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get-config>
          <source>
            <running/>
          </source>
         </get-config>
       </rpc>
       ]]>]]>

`<get-config>` так же, как и `<get>` позволяет использовать элемент `<filter>`. Например:

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

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644637011" junos:commit-localtime="2022-02-12 03:36:51 UTC" junos:commit-user="eucariot">
           <system>
               <host-name>kzn-spine-0</host-name>
           </system>
       </configuration>
       </data>
       </rpc-reply>
       ]]>]]>

В запросе самые внимательные обратили внимание на элемент `<source>`.

Configuration Datastores
~~~~~~~~~~~~~~~~~~~~~~~~

| Это место для хранения полной конфигурации. Хотя слово "хранения", возможно, и не очень точное. Обязательным!! является только `<running>` - это текущая актуальная конфигурация.
| В зависимости от вендора и поддерживаемых капабилитей могут быть так же `<candidate>`, `<startup>` и какие-то другие.

Соответственно запросить конфигурацию можно из разных Datastores при их наличии, указывая соответствующий элемент внутри `<source>`.

| Как увидим далее, менять конфигурацию так же,  можно в разных datastores через `<target>`.
| И тут разные вендоры ведут себя по-разному, кто-то разрешает менять сразу в `<running>`, а кто-то только `<candidate>` с последующим `<commit>`.

&lt;edit-config&gt;
~~~~~~~~~~~~~~~~~~~

ЕЙ богу, самая интересная штука во всём NETCONF! Операция, с помощью которой можно привести конфигурацию к нужному состоянию. Серебряная пуля, панацея, окончательное решение конфигурационного вопроса. Ага, щаз!
Идея в теории прекрасна: мы отправляем на устройство желаемую конфигурацию в виде XML, а оно само шуршит и считает, что нужно применить, а что удалить. Давайте идеальный случай и разберём сначала.

| `<edit-config>` позволяет загрузить полную конфигурацию устройства или его часть в указанный datastore. При этом устройство сравнивает актуальную конфигурацию в datastore и передаваемую с клиента и предпринимает указанные действия.
| А какие действия могут быть указаны? Это определяется атрибутом "operation" в любом из элементов поддерева `<configuration>`. Operation может встречаться несколько раз в XML и быть при этом разным. Атрибут может принимать следующие значения:

* **Merge** - новая конфига вливается в старую - что необходимо заменить - заменяется, новое - добавляется, ничего не удаляется.
* **Replace** - заменяет старую конфигурацию новой.
* **Create** - создаёт блок конфигурации. Однако, если он уже существует, вернётся `<rpc-error>`
* **Delete** - удаляет блок конфигурации. Однако, если его не существует, вернётся `<rpc-error>`
* **Remove** - удаляет блок конфигурации. Однако, если его не существует, проигнорирует. Определён в RFC6241.

Если тип операции не задан, то новая конфигурация будет вмёржена в старую. Задать операцию по умолчанию можно с помощью параметра `<default-operation>`: `merge`, `replace`, `none`.

В дереве `<configuration>` задаётся собственно целевая конфигурация в виде XML.

Безусловно, самая интересная операция внутри `<edit-config>` - это replace. Ведь она предполагает, что устройство возьмёт конфигурацию из RPC и заменит ею ту, что находится в datastore. А где-то там под капотом и крышкой блока цилиндров система сама просчитает дельту, которую нужно отправить на чипы.

Практика edit-config
~~~~~~~~~~~~~~~~~~~~

Давайте сначала что-то простое: поменяет hostname:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <edit-config>
          <target>
            <candidate/>
          </target>
          <config>
            <configuration>
              <system>
                 <host-name>just-for-lulz</host-name>
              </system>
            </configuration>
          </config>
         </edit-config>
       </rpc>
       ]]>]]>

Проверяем, что в кандидат-конфиге эти изменения есть, а в текущем - нет

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <get-config>
          <source>
            <candidate/>
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
       
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:changed-seconds="1644719855" junos:changed-localtime="2022-02-13 02:37:35 UTC">
           <system>
               <host-name>just-for-lulz</host-name>
           </system>
       </configuration>
       </data>
       </rpc-reply>
       ]]>]]>

Проверяем running:

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
       
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644637011" junos:commit-localtime="2022-02-12 03:36:51 UTC" junos:commit-user="eucariot">
           <system>
               <host-name>kzn-spine-0</host-name>
           </system>
       </configuration>
       </data>
       </rpc-reply>


Значит, надо закоммитить изменения.

    .. code-block:: xml

       <rpc>
         <commit/>
       </rpc>
       ]]>]]>
       
       <rpc-reply xmlns="urn:ietf:params:xml:ns:netconf:base:1.0" xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos">
       <ok/>
       </rpc-reply>

Проверяем running:

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
       
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644720065" junos:commit-localtime="2022-02-13 02:41:05 UTC" junos:commit-user="eucariot">
           <system>
               <host-name>just-for-lulz</host-name>
           </system>
       </configuration>
       </data>
       </rpc-reply>

На Juniper доступны в NETCONF те же функции коммитов, что и в CLI. Например, `commit confirmed` и `confirmed-timeout`.

А теперь что-то посложнее и с операцией `replace`: заменим список BGP-пиров:

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <edit-config>
          <target>
            <candidate/>
          </target>
          <config>
            <configuration>
           <protocols>
                   <bgp operation="replace">
                       <group>
                           <name>LEAFS</name>
                           <type>external</type>
                           <import>ALLOW</import>
                           <family>
                               <inet>
                                   <unicast>
                                   </unicast>
                               </inet>
                           </family>
                           <export>EXPORT</export>
                           <neighbor>
                               <name>169.254.0.0</name>
                               <peer-as>64513.00000</peer-as>
                           </neighbor>
                       </group>
                       <group>
                           <name>EDGES</name>
                           <type>external</type>
                           <import>ALLOW</import>
                           <family>
                               <inet>
                                   <unicast>
                                   </unicast>
                               </inet>
                           </family>
                           <export>EXPORT</export>
                           <neighbor>
                               <name>222.222.222.0</name>
                               <peer-as>65535</peer-as>
                           </neighbor>
                       </group>
                   </bgp>
               </protocols>
            </configuration>
          </config>
         </edit-config>
       </rpc>
       ]]>]]>

Коммит

    .. code-block:: xml

       <rpc>
         <commit/>
       </rpc>
       ]]>]]>

Проверяем running

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <get-config>
       <source>
           <running/>
       </source>
       <filter type="subtree">
           <configuration>
           <protocols>
               <bgp>
                   <group>
                   <neighbor/>
                   </group>
               </bgp>
           </protocols>
           </configuration>
       </filter>
       </get-config>
       </rpc>
       ]]>]]>
       
       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:    xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644720678"        junos:commit-localtime="2022-02-13 02:51:18 UTC" junos:commit-user="eucariot">
           <protocols>
               <bgp>
                   <group>
                       <name>LEAFS</name>
                       <neighbor>
                           <name>169.254.0.0</name>
                           <peer-as>64513.00000</peer-as>
                       </neighbor>
                   </group>
                   <group>
                       <name>EDGES</name>
                       <neighbor>
                           <name>222.222.222.0</name>
                           <peer-as>65535</peer-as>
                       </neighbor>
                   </group>
               </bgp>
           </protocols>
       </configuration>
       </data>
       </rpc-reply>

Всё сработало)

А теперь попробуем операцию `merge` при добавлении нового пира.

    .. code-block:: xml

       <rpc message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
         <edit-config>
          <target>
            <candidate/>
          </target>
          <config>
            <configuration>
           <protocols>
                   <bgp operation="merge">
                       <group>
                           <name>LEAFS</name>
                           <type>external</type>
                           <import>ALLOW</import>
                           <family>
                               <inet>
                                   <unicast>
                                   </unicast>
                               </inet>
                           </family>
                           <export>EXPORT</export>
                           <neighbor>
                               <name>169.254.0.0</name>
                               <peer-as>64513.00000</peer-as>
                           </neighbor>
                       </group>
                       <group>
                           <name>EDGES</name>
                           <type>external</type>
                           <import>ALLOW</import>
                           <family>
                               <inet>
                                   <unicast>
                                   </unicast>
                               </inet>
                           </family>
                           <export>EXPORT</export>
                           <neighbor>
                               <name>222.222.222.0</name>
                               <peer-as>65535</peer-as>
                           </neighbor>
                           <neighbor>
                               <name>169.254.100.0</name>
                               <peer-as>65535</peer-as>
                           </neighbor>
                       </group>
                   </bgp>
               </protocols>
            </configuration>
          </config>
         </edit-config>
       </rpc>
       ]]>]]>

Коммит

    .. code-block:: xml

       <rpc>
         <commit/>
       </rpc>
       ]]>]]>

Проверка:

    .. code-block:: xml

       <rpc-reply xmlns:junos="http://xml.juniper.net/junos/14.1R1/junos" message-id="100" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
       <data>
       <configuration xmlns="http://xml.juniper.net/xnm/1.1/xnm" junos:commit-seconds="1644721481" junos:commit-localtime="2022-02-13 03:04:41 UTC" junos:commit-user="eucariot">
           <protocols>
               <bgp>
                   <group>
                       <name>LEAFS</name>
                       <neighbor>
                           <name>169.254.0.0</name>
                           <peer-as>64513.00000</peer-as>
                       </neighbor>
                   </group>
                   <group>
                       <name>EDGES</name>
                       <neighbor>
                           <name>222.222.222.0</name>
                           <peer-as>65535</peer-as>
                       </neighbor>
                       <neighbor>
                           <name>169.254.100.0</name>
                           <peer-as>65535</peer-as>
                       </neighbor>
                   </group>
               </bgp>
           </protocols>
       </configuration>
       </data>
       </rpc-reply>
       ]]>]]>

| Вот он новенький пир, и старые на месте.
| То есть достаточно очевидна разница между работой `replace` и `merge`.

Operation replace
~~~~~~~~~~~~~~~~~

| С `replace` следует иметь в виду некоторые нюансы. Например, что нужно передавать полную конфигурацию того или иного сервиса или функциональности - не просто новые параметры - ведь железка натурально заменит то, что было,  тем, что прилетело. Едва ли вы хотите создав один интерфейс в OSPF Area, удалить остальные?
| Некоторые сущности не могут быть удалены, такие, например, как физические интерфейсы. Поэтому при формировании соответствующего блока конфигурации нужно быть аккуратнее - в целевой конфигурации должны все они присутствовать, иначе в лучшем случае вернётся `<rpc-error>`, а в худшем вы чего-то поудаляете.

Использовать `replace` можно как на уровне отдельных частей конфигурации, так и на верхнем уровне, требуя заменить всё поддерево.

Однако ещё один нюанс заключается в том, что в зависимости от реализации вычисление дельты может занять много ресурсов CPU. Поэтому, если собираетесь кинуть диф на 13 000 строк политик BGP, то дважды подумайте и трижды оттестируйте, что после этого происходит с коробкой.

&lt;commit&gt;
~~~~~~~~~~~~~~

| Ещё одно свидетельство того, что модель NETCONF скалькирована с API Juniper - это возможность commit'a candidate-конфигурации в running. Доступна она, конечно, только в том случае, если при обмене capability сервер сообщил, что поддерживает candidate datastore.
| `<commit>` не замещает running на candidate, как это делает `<copy-config>`, а выполняет именно применение конфигурационной дельты, как это происходит в CLI.

Как и в CLI у `commit` может быть параметр `confirmed`, заставляющий откатить изменения, если commit не был подтверждён. За это отвечает отдельная capability: `confirmed-commit`.

`<commit>` не входит в число базовых операций, поскольку как раз зависит от поддерживаемых возможностей сервера.

&lt;copy-config&gt;
~~~~~~~~~~~~~~~~~~~

Операция заменяет одну конфигурацию другой. Имеет два параметра: `source` - откуда - и `target` - куда.
Может использоваться как для применения новой конфигурации на коробку, так и для бэкапа активной.
Если коробка поддерживает capability `:url`, то в качестве `source` и/или `target` может быть указан URL.

&lt;delete-config&gt;
~~~~~~~~~~~~~~~~~~~~~

Очевидно, удаляет конфигурацию из target datastore. Без хитростей.

&lt;lock/unlock&gt;
~~~~~~~~~~~~~~~~~~~

Аналогично Juniper CLI ставит блок на target datastore от совместного редактирования, чтобы не было конфликта. Причём блок должен работать как на NETCONF, так и на другие способы изменения конфигурации - SNMP, CLI, gRPC итд.

&lt;close-session&gt;
~~~~~~~~~~~~~~~~~~~~~

Аккуратно закрывает существующую NETCONF-сессию, снимает локи, высвобождает ресурсы.

&lt;kill-session&gt;
~~~~~~~~~~~~~~~~~~~~

Грубо разрывает сессиию, но снимает локи. Если сервер получил такую операцию в тот момент, когда он дожидается confirmed commit, он должен отменить его и откатить изменения к состоянию, как было до установки сессии.

Инструменты разработчика для NETCONF
------------------------------------

| Ну вот как будто бы необходимый базис по NETCONF набрали.
| Я в этой статье не ставлю перед собой задачу выстроить какую-то систему автоматизации. Просто хочу показать разные интерфейсы в теории и на практике. 

И я думаю, к этому моменту вам уже очевидно, что отправка XML через SSH с ручным проставлением Framing Marker (`]]>]]>`) - не самый удобный способ. Давайте посмотрим на существующие библиотеки.

netconf-console
~~~~~~~~~~~~~~~

Прежде чем писать какой-то код, обычно стоит проверить всё руками. Но вот руками крафтить XML и проставлять framing marker'ы тоскливо. Тут отца русской автоматизации спасёт `netconf-console` - главный и, возможно, единственный CLI-инструмент для работы с NETCONF.

Может работать в режиме команды:

    .. code-block:: bash

       netconf-console --host 192.168.1.2 --port 22 -u eucariot -p password --get-config


А может в интерактивном:

    .. code-block:: bash

       netconf-console2 --host 192.168.1.2 --port 22 -u eucariot -p password -i
       netconf> hello

`Чуть больше про библиотеку у Романа Додина <https://netdevops.me/2020/netconf-console-in-a-docker-container/>`_.

NCclient
~~~~~~~~

| Это, пожалуй, самая известная библиотека для работы с NETCONF. Она для питона и достаточно зрелая.
| Начать пользоваться очень легко:

    .. code-block:: python

       from ncclient import manager
       
       
       if __name__ == "__main__":
           with manager.connect(
               host="kzn-spine-0.juniper",
               ssh_config=True,
               hostkey_verify=False,
               device_params={'name': 'junos'}
           ) as m:
               c = m.get_config(source='running').data_xml
       
           print(c)

    Дабы уберечь читателя от многочасовых мук с отладкой аунтентификации, небольшая подсказка тут.
    Текущая версия `paramiko` на момент написания статьи (>=2.9.0), которую подтягивает `ncclient`, в ряде случае не может работать с OpenSSH-ключами и падает с ошибкой "Authentication failed". Рекомендую в этом случае устанавливать 2.8.0.
    На гитхабе открыта куча issue на эту тему. И, кажется, его даже `починили <https://github.com/paramiko/paramiko/issues/2017>`_, но я не проверял.
    И вроде бы даже есть `решение <https://localcoder.org/paramiko-not-a-valid-rsa-private-key-file>`_, но и это я не проверял.

Так же работают `filter`:

    .. code-block:: python

       from ncclient import manager
       
       rpc = """
            <filter>
            <configuration>
              <system>
                 <host-name/>
              </system>
            </configuration>
            </filter>
            """

       if __name__ == "__main__":
           with manager.connect(
               host="kzn-spine-0.juniper",
               ssh_config=True,
               hostkey_verify=False,
               device_params={"name": "junos"}
           ) as m:
               c = m.get_config("running", rpc).data_xml

           print(c)

С таким вот результатом:

    .. code-block:: xml

       <?xml version="1.0" encoding="UTF-8"?>
       <rpc-reply message-id="urn:uuid:864dd143-7a86-40ca-8992-5a35f2322ea0">
         <data>
                  <configuration commit-seconds="1644732354" commit-localtime="2022-02-13 06:05:54 UTC" commit-user="eucariot">
             <system>
               <host-name>
               kzn-spine-0
               </host-name>
             </system>
           </configuration>
         </data>
       </rpc-reply>

На текстовый XML смотреть не надо - парсим библиотечкой `xmltodict`:

    .. code-block:: python

       from ncclient import manager
       import xmltodict

       rpc = """
            <filter>
            <configuration>
              <system>
                 <host-name/>
              </system>
            </configuration>
            </filter>
            """

       if __name__ == "__main__":
           with manager.connect(
               host="kzn-spine-0.juniper",
               ssh_config=True,
               hostkey_verify=False,
               device_params={"name": "junos"}
           ) as m:
               result = m.get_config("running", rpc).data_xml
           result_dict = xmltodict.parse(result)
           print(f'hostname is {result_dict["rpc-reply"]["data"]["configuration"]["system"]["host-name"]}')

С уже таким результатом:

    .. code-block:: bash

       hostname is kzn-spine-0


    При работе с сетевыми коробками по NETCONF xmltodict, пожалуй, самая практичная библиотека, преобразующая XML-данные в объект Python. Она использует C-шный парсер `pyexpat <https://docs.python.org/3/library/pyexpat.html>`_, так что недостатков у такого подхода фактически нет.

Точно так же можно обновить конфигурацию в два действия: `<edit-config>` в `<candidate>` и `<commit>`:

    .. code-block:: python

       from ncclient import manager
       import xmltodict

       rpc = """
            <config>
              <configuration>
                <interfaces>
                  <interface>
                    <name>ge-0/0/0</name>
                    <description>Mit der Dummheit kämpfen Götter selbst vergebens.</description>
                  </interface>
                </interfaces>
              </configuration>
            </config>
            """

       if __name__ == "__main__":
           with manager.connect(
               host="kzn-spine-0.juniper",
               ssh_config=True,
               hostkey_verify=False,
               device_params={"name": "junos"}
           ) as m:
               result = m.edit_config(target="candidate", config=rpc).data_xml
               m.commit()
           result_dict = xmltodict.parse(result)
           print(result_dict)

       OrderedDict([('rpc-reply', OrderedDict([('@message-id', 'urn:uuid:93bde991-81f9-42d6-a343-b4fc267646c2'), ('ok', None)]))])

Дальше пока копать не будем. Тем более, бытует мнение *"без всяких сомнений, самый ублюдочно написанный Python код, что я видел в opensource"*

scrapli-netconf
~~~~~~~~~~~~~~~

| NCclient был первым и классным, но отсутствие поддержки async в нём сильно ограничивает его использование.
| Тут нас выручает Карл Монтанари, который уже подарил миру `scrapli <https://github.com/carlmontanari/scrapli>`_.
| Но для тех, кто достаточно смел, чтобы использовать на своей сети NETCONF, создали `scrapli-netconf <https://github.com/scrapli/scrapli_netconf>`_.

Давайте взглянем на пару примеров работы.

    .. code-block:: python

       from scrapli_netconf.driver import NetconfDriver

       rpc = """
            <filter>
            <configuration>
              <system>
                 <host-name/>
              </system>
            </configuration>
            </filter>
            """

       device = {
               "host": "kzn-spine-0.juniper",
               "auth_strict_key": False,
               "port": 22
               }

       if __name__ == "__main__":
           with NetconfDriver(**device) as conn:
               response = conn.get_config("running", rpc)
       
           print(response.result)

Scrapligo и scrapligo-netconf
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| Для Go тоже не придумано ничего лучше, чем `scrapligo <https://github.com/scrapli/scrapligo>`_, в котором есть модуль для работы через netconf.
| Так что если вы сетевик, осваивающий Го, путь для вас уже проложен.

Как это использовать
--------------------

Мониторинг
~~~~~~~~~~

NETCONF предоставляет возможность собирать операционные данные:

* Состояния протоколов (OPSF, BGP-пиринги)
* Статистику интерфейсов
* Утилизацию ресурсов CPU
* Таблицы маршрутизации
* Другое

| При этом возвращаются структурированные данные, с которыми легко работать без сложных процедур парсинга.
| Поэтому NETCONF вполне можно использовать для целей мониторинга.
| Тут вы спросите: а зачем, если есть SNMP? А я отвечу. Точнее постараюсь.

* Используем безопасный SSH, не используем SNMP
* Не несём дополнительные протоколы в сеть
* Полная свобода того, какие данные мы собираем, без необходимости разбираться в OID'ах и MIB'ах
* При этом есть возможность собирать данные в соответствии с YANG-моделью
* Гипотетическая возможность оформить подписку на события в системе

Выполнение отдельных операций
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| Используя NETCONF, можно выполнять какие-то конкретные задачи: собрать данные с сети или изменить какую-то часть конфигурации.
| Например, вы хотите периодически собирать MAC-адреса с сети или список коммитов.
| Или вам нужно переключать порт коммутатора в другой VLAN.
| Или например, у вас есть скрипт, который проверяет, что устройство в порядке - правильные настройки сислог-сервера, корректное время и пинги, куда полагается, работают.
| Это всё можно сделать и на парсинге CLI, безусловно, но структурированные данные - это структурированные данные, а regexp - это regexp.


Configuration Management
~~~~~~~~~~~~~~~~~~~~~~~~

Да, это тоже возможно, если

1. Оборудование поддерживает 100% конфигурации через NETCONF. Увы, я на своём веку повидал ситуаций, когда некоторые секции просто-напросто отсутствовали в NETCONF и никакого способа настроить нужную функцию нет.
2. Оборудование честно поддерживает операцию "replace", без этого вычисление конфигурационной дельты ложится вновь на сетевиков.

| Однако, в том виде, в котором мы познакомились с темой на данный момент, дальше начинается Jinja-программирование. Каждому, кто этим занимался, обычно неловко, и он стыдливо избегает разговора на эту тему.
| Задача решается примерно следующим образом:

3. | Пишем циклопические развесистые jinja-шаблоны с ифами и форами, внутри которых XML. Шаблоны под каждого вендора, конечно, свои собственные, поскольку и схемы данных у них разные. Но при этом они универсальные в плане ролей устройств - не нужно для свитчей доступа и маршрутизаторов ядра писать разные шаблоны - просто в зависимости от роли будут активироваться те или иные их части.
| Здесь в нужных местах сразу описаны типы операций - где merge, где replace.
4. Каким-то образом формируем под каждое устройство файлы переменных, в которых указаны хостнеймы, IP-адреса, ASN, пиры и прочие специфические вещи. Эти файлы переменных в свою очередь, напротив, вендор-нейтральны, но будут отличаться от роли к роли.
5. Рендерим конфигурацию в формате XML, накладывая переменные на шаблоны. Получаем целевую конфигурацию в виде дерева XML, где в нужных местах проставлена операция `replace`.
6. Этот XML с помощью ncclient, ansible, scrapli-netconf или чего-то ещё подпихиваем на коробку.
7. NETCONF-сервер на коробке получает RPC и вычисляет конфигурационный патч, который фактически применит. То есть он находит разницу между целевой конфигурацией в RPC и текущей в `<running>`. Применяет эту конфигурацию.

Как бы это могло выглядеть я уже показывал в `предыдущем выпуске АДСМ <https://linkmeup.ru/blog/1275/>`_.

    .. figure:: https://dteslya.engineer/images/2020-10-netdevops-pipeline.png

    `Источник: dteslya.engineer/network_automaiton_101/ <https://dteslya.engineer/network_automaiton_101/>`_

Ручная правка файлов переменных - это очень неудобно, конечно же. Просто мрак, если мы говорим про какие-то типовые вещи, как например датацентровые регулярные топологии. Новая пачка стоек - сотни и тысячи строк для копипащения и ручного изменения. Но на самом деле их можно создавать автоматически на основе данных из централизованной базы данных - DCIM/IPAM.

| Почему я об этом говорю так уверенно?
| Потому что мы у себя (в Яндексе) полностью построили весь жизненный цикл отдельного сегмента сети на основе описанной схемы. И любые изменения на сеть могут применяться только через подобный конвейер и NETCONF. Любые временные конфигурации на железе перетрутся следующим же релизом.

Что тут хорошо:

1. Изменения в Jinja-шаблонах версионируются через git и проходят проверку другими инженерами перед применением. Это систематические изменения, влияющие на большое количество устройств.
2. Изменения в переменных - точно так же. Это точечное изменение конкретного устройства.
3. Только после согласования изменений в пунктах выше, можно сгенерировать новую конфигурацию и далее уже её отправить на проверку в git.
4. Если соблюдать процесс, то отсутствует конфигурационный дрейф.

Что тут плохо?

1. Ну, очевидно, Jinja-программирование
2. Работа с текстом, вместо объектов языка.
3. Отсутствие возможности взглянуть на конфигурационный диф до его применения.

На этом на самом деле заканчивается первая большая часть этой статьи, которая позволяет просто уже взять и получать пользу от NETCONF в задачах автоматизации.

**Я вот прям серьёзно сейчас, ей богу! Не туманные абстракции - берём NETCONF - и на многих вендорах уже можно с ним работать выстраивая автоматизацию того или иного объёма.**

| Как вам ощущения от составления XML? А представьте, что вам нужно всю конфигурацию на несколько тысяч строк описать? А приправить это всё Jinja-программированием? А описывать в ямлах переменные?
| Но абсолютное большинство тех, кто использует сегодня NETCONF, именно так и делают. (!) Мнение автора. Change my mind!
| В то время как есть YANG и набор инструментов вокруг него?

Хух. Давайте просто не будем об этом сейчас? Просто не сейчас? Попозже. После RESTCONF и gRPC?