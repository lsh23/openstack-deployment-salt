install_compute_packages:
  pkg.installed:
    - pkgs:
      - nova-compute
      - neutron-linuxbridge-agent

nova-compute-conf:
  file.managed:
    - names:
      - /etc/nova/nova.conf:
        - source: salt://compute/nova.conf
    - template: jinja
    - require:
      - pkg: install_compute_packages

neutron-linuxbridge-agent-conf:
  file.managed:
    - names: 
      - /etc/neutron/plugins/ml2/linuxbridge_agent.ini:
        - source: salt://compute/linuxbridge_agent.ini
      - /etc/neutron/neutron.conf:
        - source: salt://compute/neutron.conf
    - template: jinja
    - require:
      - pkg: install_compute_packages