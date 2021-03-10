install_neutron-server_packages:
  pkg.installed:
    - pkgs:
      - neutron-server
      - neutron-plugin-ml2

neutron-server:
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