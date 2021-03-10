install_nova-api_packages:
  pkg.installed:
    - pkgs:
      - nova-api
      - nova-conductor
      - nova-consoleauth 
      - nova-novncproxy 
      - nova-scheduler 
      - nova-placement-api

nova:
  file.managed:
    - names:
      - /etc/nova/nova.conf:
        - source: salt://nova-api/conf/nova.conf
    - template: jinja