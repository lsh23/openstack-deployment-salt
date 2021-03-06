base:
  '*':
    - common
  'sh-controller':
    - controller
    - mysql
    - nova-api
    - neutron-server
    - cinder-api
    - keystone
    - glance
  'sh-horizon':
    - horizon
  'sh-compute*':
    - compute
  'sh-neutron*':
    - neutron
  'sh-storage*':
    - cinder