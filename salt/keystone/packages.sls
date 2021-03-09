install_keystone_packages:
  pkg.installed:
    - pkgs:
      - keystone
      - apache2 
      - libapache2-mod-wsgi

keystone:
  file.managed:
    - names:
      - /etc/keystone/keystone.conf:
        - source: salt://keystone/conf/keystone.conf
    - template: jinja

apache2:
  file.managed:
    - names:
      - /etc/apache2/apache2.conf:
        - source: salt://keystone/conf/apache2.conf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/apache2/apache2.conf

create-db:
  mysql_database.present:
    - name: keystone

grant-localhost:
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: localhost

grant-anyhost:
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: '%'

  