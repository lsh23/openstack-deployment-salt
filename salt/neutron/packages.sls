install_neutron_packages:
  pkg.installed:
    - pkgs:
      - neutron-plugin-ml2
      - neutron-linuxbridge-agent
      - neutron-l3-agent
      - neutron-dhcp-agent
      - neutron-metadata-agent

neutron-conf:
  file.managed:
    - names:
      - /etc/neutron/neutron.conf:
        - source: salt://neutron/conf/neutron.conf
      - /etc/neutron/plugins/ml2/ml2_conf.ini:
        - source: salt://neutron/conf/ml2_conf.ini
    - template: jinja

neutron-linuxbridge-agent:
  file.managed:
    - names:
      - /etc/neutron/plugins/ml2/linuxbridge_agent.ini:
        - source: salt://neutron/conf/linuxbridge_agent.ini
    - template: jinja
  service.running:
    - watch:
      - file: /etc/neutron/plugins/ml2/linuxbridge_agent.ini

neutron-l3-agent:
  file.managed:
    - names:
      - /etc/neutron/l3_agent.ini :
        - source: salt://neutron/conf/l3_agent.ini
    - template: jinja
  service.running:
    - watch:
      - file: /etc/neutron/l3_agent.ini 

neutron-dhcp-agent:
  file.managed:
    - names:
      - /etc/neutron/dhcp_agent.ini:
        - source: salt://neutron/conf/dhcp_agent.ini
    - template: jinja
  service.running:
    - watch:
      - file: /etc/neutron/dhcp_agent.ini

neutron-metadata-agent:
  file.managed:
    - names:
      - /etc/neutron/metadata_agent.ini:
        - source: salt://neutron/conf/metadata_agent.ini
    - template: jinja
  service.running:
    - watch:
      - file: /etc/neutron/metadata_agent.ini