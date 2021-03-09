install_glance_packages:
  pkg.installed:
    - pkgs:
      - glance

glance-api:
  file.managed:
    - names:
      - /etc/glance/glance-api.conf:
        - source: salt://glance/conf/glance-api.conf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/glance/glance-api.conf

glance-registry:
  file.managed:
    - names:
      - /etc/glance/glance-registry.conf:
        - source: salt://glance/conf/glance-registry.conf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/glance/glance-registry.conf

create_db:
  mysql_database.present:
    - name: glance

grant_localhost:
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_dbpass'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - host: localhost

grant_anyhost:
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_dbpass'] }}
    - host: '%'
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - host: '%'