install_neutron-server_packages:
  pkg.installed:
    - pkgs:
      - neutron-server
      - neutron-plugin-ml2

create neutron db:
  mysql_database.present:
    - name: neutron

neutron grant_localhost:
  mysql_user.present:
    - name: neutron
    - password: {{ pillar['neutron_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - host: localhost

neutron grant_anyhost:
  mysql_user.present:
    - name: neutron
    - password: {{ pillar['neutron_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - host: '%'

neutron neutron-server:
  file.managed:
    - names:
      - /etc/neutron/neutron.conf:
        - source: salt://neutron-server/conf/neutron.conf
      - /etc/neutron/plugins/ml2/ml2_conf.ini:
        - source: salt://neutron-server/conf/ml2_conf.ini
    - template: jinja
  service.running:
    - watch:
      - file: /etc/neutron/*