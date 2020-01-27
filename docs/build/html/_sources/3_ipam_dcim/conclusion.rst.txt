Заключение
==========

В этой статье я не преследовал цель рассмотреть все возможности NetBox, поэтому всё остальное отдаю вам на откуп. Разбирайтесь, пробуйте.

Далее в рамках построения системы автоматизации я буду касаться только тех частей, которые нам действительно нужны. 

Итак, выше я коротко рассказал о том, что из себя представляет NetBox, и как в нём хранятся данные. 
Повторюсь, что почти все необходимые данные я туда уже внёс, и вы можете утащить себе `дамп БД <https://github.com/eucariot/ADSM/blob/master/docs/source/3_ipam/netbox_initial_db.sql>`_

Всё готово к следующему этапу автоматизации: написанию системы (ахаха, просто скриптов) инициализации устройств и управления конфигурацией. 

Полезные ссылки
---------------

* `Сам NetBox на github <https://github.com/netbox-community/netbox>`_
* `Контейнерная версия <https://github.com/netbox-community/netbox-docker>`_
* `Полная инструкция по установке и вся документация по продукту <https://netbox.readthedocs.io/en/stable/>`_ 
* `Documenting your network infrastructure in NetBox, integrating with Ansible over REST API <http://karneliuk.com/2019/04/documenting-your-network-infrastructure-in-netbox-integrating-with-ansible-over-rest-api-and-automating-provisioning-of-cumulus-linux-arista-eos-nokia-sr-os-and-cisco-ios-xr/>`_
* `IPAM NetBox and its API, Docker, Postman <https://www.youtube.com/watch?v=GGXgAlWm9aY&t=9655s>`_
* `IPAM NetBox and its API, configuration templates with Python <https://www.youtube.com/watch?v=a3yK_WAisPw>`_
* `SDK для работы с NetBox в Python <https://github.com/digitalocean/pynetbox>`_
* `Документация по API <http://netbox.linkmeup.ru:45127/api/docs/>`_
* `Mailing list <https://groups.google.com/forum/#!forum/netbox-discuss>`_
* `Канал в Slack NetworkToCode <https://networktocode.slack.com/>`_
* `Что такое REST <https://linkmeup.ru/blog/530.html>`_
* `Инсталляция NetBox для нужд АДСМ <http://netbox.linkmeup.ru:45127/>`_