upgrade_apt:
  module.run:
    - name: pkg.upgrade
    - dist_upgrade: True

install_common_packages:
  pkg.installed:
    - pkgs:
      - python-openstackclient
      - ifupdown
      - chrony

chrony:
  file.managed:
    - names:
      - /etc/chrony/chrony.conf:
{% if grains['role'][0] == 'controller' %}
        - source: salt://common/conf/controller-chrony.conf
{% else %}
        - source: salt://common/conf/chrony.conf
{% endif %}
    - template: jinja
  service.running:
    - watch:
      - file: /etc/chrony/chrony.conf
