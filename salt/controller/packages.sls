install_controller_packages:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - python-pymysql
      - rabbitmq-server
      - memcached
      - python-memcache
      - etcd

mysql:
  file.managed:
    - names:
      - /etc/mysql/mariadb.conf.d/99-openstack.cnf:
        - source: salt://controller/conf/99-openstack.cnf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/mysql/mariadb.conf.d/99-openstack.cnf

rabbitmq:
  rabbitmq_user.present:
    - name: openstack
    - password: {{ pillar['rabbit_pass'] }}
    - force: True
    - perms:
      - '/':
        - '.*'
        - '.*'
        - '.*'

memcached:
  file.managed:
    - names:
      - /etc/memcached.conf:
        - source: salt://controller/conf/memcached.conf
    - template: jinja
  service.running:
    - watch:
      - file: /etc/memcached.conf

etcd:
  file.managed:
    - names:
      - /etc/default/etcd:
        - source: salt://controller/conf/etcd
    - template: jinja
  service.running:
    - enable: True
    - watch:
      - file: /etc/default/etcd