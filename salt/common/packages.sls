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

{% if grains['role'][0] == 'controller' %}
chrony-conf:
  file.managed:
    - names:
      - /etc/chrony/chrony.conf:
        - source: salt://common/conf/controller-chrony.conf
    - template: jinja
{% else %}
chrony-conf:
  file.managed:
    - names:
      - /etc/chrony/chrony.conf:
        - source: salt://common/conf/chrony.conf
    - template: jinja
{% endif %}
