Некоторые нюансы установки NetBox
=================================

Я не буду описывать процесс инсталляции в деталях - он более чем классно описан в `официальной документации <https://netbox.readthedocs.io/en/stable/installation/>`_.

Посмотреть на процесс запуска docker-образа NetBox и работу в GUI можно в видео Димы Фиголя (`раз <https://www.youtube.com/watch?v=GGXgAlWm9aY&t=9655s>`_ и `два <https://www.youtube.com/watch?v=a3yK_WAisPw>`_) и `Эмиля Гарипова <https://www.youtube.com/watch?v=I_Ra3PIR2Lc&feature=youtu.be>`_.

| В целом, если следовать шагам установки/запуска неукоснительно, то всё получится. 
| Но вот какие есть нюансы, про которые случайно можно забыть.

* | В файле configuration.py должен быть заполнен параметр `ALLOWED_HOSTS <https://netbox.readthedocs.io/en/stable/installation/2-netbox/#allowed_hosts>`_:
  | ALLOWED_HOSTS = ['netbox.linkmeup.ru', 'localhost']
  | Тут нужно указать все возможные имена  NetBox, к которым вы будете обращаться, например, может быть внешний IP-адрес или 127.0.0.1 или DNS-alias. 
  | Если этого не будет сделано, сайт NetBox не откроется и будет показывать 400.

* В этом же файле должен быть указан `SECRET_KEY <https://netbox.readthedocs.io/en/stable/installation/2-netbox/#secret_key>`_, который можно выдумать самому или сгенерировать скриптом.
* Главная страница будет показывать 502 Bad Gateway, если что-то не так с настройкой базы PostgreSQL: проверьте хост(если ставили на другую машину), порт, имя базы, имя пользователя, пароль.
* | С `некоторых пор <https://github.com/netbox-community/netbox/releases/tag/v2.6.0>`_ NetBox по умолчанию не даёт никаких прав на чтение без авторизации.
  | Изменяется это всё в том же configuration.py:
  | EXEMPT_VIEW_PERMISSIONS = ['*']
* | А ещё API запросы будут возвращать 200 и не работать, если в API URL не будет слэша в конце.
  | curl -X GET -H "Accept: application/json; indent=4" "http://netbox.linkmeup.ru:45127/api/dcim/devices"