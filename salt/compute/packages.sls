install_compute_packages:
  pkg.installed:
    - pkgs:
      - nova-compute
      - neutron-linuxbridge-agent

nova-compute:
  file.managed:
    - names:
      - /etc/nova/nova.conf:
        - source: salt://compute/conf/nova.conf
{% set kvm_available = salt['cmd.run']("egrep -c '(vmx|svm)' /proc/cpuinfo") %}
{% if kvm_available is equalto('0') %}
      - /etc/nova/nova-compute.conf:
        - source: salt://compute/conf/nova-compute.conf
{% endif %}
    - template: jinja
  service.running:
    - watch:
      - file: /etc/nova/*



neutron-linuxbridge-agent-conf:
  file.managed:
    - names: 
      - /etc/neutron/plugins/ml2/linuxbridge_agent.ini:
        - source: salt://compute/conf/linuxbridge_agent.ini
      - /etc/neutron/neutron.conf:
        - source: salt://compute/conf/neutron.conf
    - template: jinja