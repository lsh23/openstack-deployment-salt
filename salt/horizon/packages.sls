install_horizon_packages:
  pkg.installed:
    - pkgs:
      - python-pip
      - openstack-dashboard

install_django:
  pip.installed:
    - name: django == 1.11

horizon-conf:
  file.managed:
    - names:
      - /etc/openstack-dashboard/local_settings.py:
        - source: salt://horizon/conf/controller-horizon-local_settings.py
    - template: jinja

apache2:
  service.running:
    - watch:
      - file: /etc/openstack-dashboard/local_settings.py