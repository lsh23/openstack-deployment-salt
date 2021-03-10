install_mysql_packages:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - python-pymysql

mysql:
  file.managed:
    - names:
      - /etc/mysql/mariadb.conf.d/99-openstack.cnf:
        - source: salt://controller/conf/99-openstack.cnf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/mysql/mariadb.conf.d/99-openstack.cnf

keystone create db:
  mysql_database.present:
    - name: keystone

keystone grant localhost:
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: localhost

keystone grant anyhost:
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: '%'

glance create db:
  mysql_database.present:
    - name: glance

glance grant localhost:
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - host: localhost

glance grant anyhost:
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - host: '%'

neutron create db:
  mysql_database.present:
    - name: neutron

neutron grant localhost:
  mysql_user.present:
    - name: neutron
    - password: {{ pillar['neutron_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - host: localhost

neutron grant anyhost:
  mysql_user.present:
    - name: neutron
    - password: {{ pillar['neutron_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - host: '%'

nova-api create db:
  mysql_database.present:
    - name: nova_api

nova-api grant localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova_api.*
    - user: nova
    - host: localhost

nova-api grant anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova_api.*
    - user: nova
    - host: '%'

nova create db:
  mysql_database.present:
    - name: nova

nova grant localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - host: localhost

nova grant anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - host: '%'

nova cell create db:
  mysql_database.present:
    - name: nova_cell0

nova cell grant localhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: nova_cell0.*
    - user: nova
    - host: localhost

nova cell grant anyhost:
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: nova_cell0.*
    - user: nova
    - host: '%'