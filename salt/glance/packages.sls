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
