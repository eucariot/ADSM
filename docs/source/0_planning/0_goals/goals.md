Сейчас мы поставим максимально абстрактные цели:
<ul>
    <li>Сеть - как единый организм</li>
    <li>Тестирование конфигурации</li>
    <li>Версионирование состояния сети</li>
    <li>Мониторинг и самовосстановление сервисов</li>
</ul>
Позже в этой статье разберём какие будем использовать средства, а в следующих и цели и средства в подробностях.

<a name="SAVE"></a>
<h2>Сеть - как единый организм</h2>
Определяющая фраза цикла, хотя на первый взгляд она может показаться не такой уж значительной: <b>мы будем настраивать сеть, а не отдельные устройства</b>.   
Все последние годы мы наблюдаем сдвиг акцентов к тому, чтобы обращаться с сетью, как с единой сущностью, отсюда и приходящие в нашу жизнь <i>Software Defined Networking</i>, <i>Intent Driven Networks</i> и <i>Autonomous Networks</i>.  
Ведь что глобально нужно приложениям от сети: связности между точками А и Б (ну иногда +В-Я) и изоляции от других приложений и пользователей. 

<img src="https://fs.linkmeup.ru/images/adsm/0/seteviki-ne-nuzhny.jpg" width="400">


И таким образом, наша задача в этой серии - <b>выстроить систему</b>,  поддерживающую актуальную конфигурацию <b>всей сети</b>, которая уже декомпозируется на актуальную конфигурацию на каждом устройстве в соответствии с его ролью и местоположением.  
<b>Система</b> управления сетью подразумевает, что для внесения изменений мы обращаемся в неё, а она уже в свою очередь вычисляет нужное состояние для каждого устройства и настраивает его.  
Таким образом мы минимизируем почти до нуля хождение в CLI руками - любые изменения в настройках устройств или дизайне сети должны быть формализованы и документированы - и только потом выкатываться на нужные элементы сети.  

<blockquote>
    То есть, например, если мы решили, что с этого момента стоечные коммутаторы в Казани должны анонсировать две сети вместо одной, мы
    <ol>
        <li>Сначала документируем изменения в системах</li>
        <li>Генерируем целевую конфигурацию всех устройств сети</li>
        <li>Запускаем программу обновления конфигурации сети, которая вычисляет, что нужно удалить на каждом узле, что добавить, и приводит узлы к нужному состоянию.</li>
    </ol>
    
    При этом руками мы вносим изменения только на первом шаге.
</blockquote>

<a name="US"></a>
<h2>Тестирование конфигурации</h2>
<a href="http://www.wikisummaries.org/wiki/Visible_Ops" target="blank">Известно</a>, что 80% проблем случаются во время изменения конфигурации - косвенное тому свидетельство - то, что в период новогодних каникул обычно всё спокойно.  
Я лично был свидетелем десятков глобальных даунтаймов из-за ошибки человека: неправильная команда, не в той ветке конфигурации выполнили, забыли комьюнити, снесли MPLS глобально на маршрутизаторе, настроили пять железок, а на шестой ошибку не заметили, закоммитили старые изменения, сделанные другим человеком. Сценариев тьма тьмущая.  

Автоматика нам позволит совершать меньше ошибок, но в большем масштабе. Так можно окирпичить не одно устройство, а всю сеть разом.  

Испокон веков наши деды проверяли правильность вносимых изменений острым глазом, стальными яйцами и работоспособностью сети после их выкатки.  
Те деды, чьи работы приводили к простою и катастрофическим убыткам, оставляли меньше потомства и должны со временем вымереть, но эволюция процесс медленный, и поэтому до сих пор не все предварительно проверяют изменения в лаборатории.  
Однако на острие прогресса те, кто автоматизировал процесс тестирования конфигурации, и дальнейшего её применения на сеть. Иными словами - позаимствовал процедуру CI/CD (<a href="https://img.devrant.com/devrant/rant/r_1535091_ErSUL.jpg">Continuous Integration, Continuous Deployment</a>) у разработчиков.
В одной из частей мы рассмотрим как реализовать это с помощью системы контроля версий, вероятно, гитхаба.  

<blockquote>
    Как только вы свыкнитесь с мыслью о сетевом CI/CD, в одночасье метод проверки конфигурации путём её применения на рабочую сеть покажется вам раннесредневековым невежеством. Примерно как стучать молотком по боеголовке.
</blockquote>


Органическим продолжением идей о <b>системе</b> управления сетью и CI/CD становится полноценное версионирование конфигурации.  

<a name="FROM"></a>
<h2>Версионирование</h2>
Мы будем считать, что при любых изменениях, даже самых незначительных, даже на одном незаметном устройстве, вся сеть переходит из одного состояния в другое.
И мы всегда не выполняем команду на устройстве, мы меняем состояние сети. 
Вот давайте эти состояния и будем называть версиями?

Допустим, текущая версия - 1.0.0.
Поменялся IP-адрес Loopback-интерфейса на одном из ToR'ов? Это минорная версия - получит номер 1.0.1.
Пересмотрели политики импорта маршрутов в BGP - чуть посерьёзнее - уже 1.1.0
Решили избавиться от IGP и перейти только на BGP - это уже радикальное изменение дизайна - 2.0.0.

При этом разные ДЦ могут иметь разные версии - сеть развивается, ставится новое оборудование, где-то добавляются новые уровни спайнов, где-то - нет, итд.

Про <a href="https://semver.org">семантическое версионирование</a> мы поговорим в отдельной статье.

Повторюсь - любое изменение (кроме отладочных команд) - это обновление версии. О любых отклонениях от актуальной версии должны оповещаться администраторы.

То же самое касается отката изменений - это не отмена последних команд, это не rollback силами операционной системы устройства - это приведение всей сети к новой (старой) версии. 

<a name="PYTHON"></a>
<h2>Мониторинг и самовосстановление сервисов</h2>
Это самоочевидная задача в современных сетях выходит на новый уровень.
Зачастую у больших сервис-провайдеров практикуется подход, что упавший сервис надо очень быстро добить и поднять новый, вместо того, чтобы разбираться, что произошло.
"Очень" означает, что со всех сторон нужно обильно обмазаться мониторингами, которые в течение секунд обнаружат малейшие отклонения  от нормы.
И здесь уже не достаточно привычных метрик, вроде загрузки интерфейса или доступности узла. Недостаточно и ручного слежения дежурного за ними.
Для многих вещей вообще должен быть <a href="https://www.irisns.com/self-healing-network-tomorrow-look-like/">Self-Healing</a> - мониторинги зажглись красным и пошли сами подорожник приложили, где болит.

И здесь мы тоже мониторим не только отдельные устройства, но и здоровье сети целиком, причём как вайтбокс, что сравнительно понятно, так и блэкбокс, что уже сложнее.

<hr>

Что нам понадобится для реализации таких амбициозных планов?
<ul>
    <li>Иметь список всех устройств в сети, их расположение, роли, модели, версии ПО.  
    <i>kazan-leaf-1.lmu.net, Kazan, leaf, Juniper QFX 5120, R18.3.</i>
    </li>
    <li>Иметь систему описания сетевых сервисов.  
    <i>IGP, BGP, L2/3VPN, Policy, ACL, NTP, SSH.</i></li>
    <li>Уметь инициализировать устройство.  
    <i>Hostname, Mgmt IP, Mgmt Route, Users, RSA-Keys, LLDP, NETCONF</i></li>
    <li>Настраивать устройство и приводить конфигурацию к нужной (в том числе старой) версии.</li>
    <li>Тестировать конфигурацию</li>
    <li>Периодически проверять состояние всех устройств на предмет отхождения от актуального и сообщать кому следует.
    ночью кто-то тихонько добавил правило в ACL</li>
    <li>Следить за работоспособностью.</li>
</ul>
<hr>