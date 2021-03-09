install_nova-api_packages:
  pkg.installed:
    - pkgs:
      - nova-api
      - nova-conductor
      - nova-consoleauth 
      - nova-novncproxy 
      - nova-scheduler 
      - nova-placement-api

create nova_api db:
  mysql_database.present:
    - name: nova_api

nova_api grant_localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova_api.*
    - user: nova
    - host: localhost

nova_api grant_anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova_api.*
    - user: nova
    - host: '%'

create nova db:
  mysql_database.present:
    - name: nova

nova grant_localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - host: localhost

nova grant_anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - host: '%'

create nova cell db:
  mysql_database.present:
    - name: nova_cell0

nova cell grant_localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova_cell0.*
    - user: nova
    - host: localhost

nova cell grant_anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova_cell0.*
    - user: nova
    - host: '%'

nova:
  file.managed:
    - names:
      - /etc/nova/nova.conf:
        - source: salt://nova-api/conf/nova.conf
    - template: jinja