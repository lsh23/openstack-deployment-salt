## SaltStack OpenStack Deployment

### Pillar Setting
Input your network envs 
- management_interface_name
- provider_interface_name
- provider_network_cider
- provider_network_gateway
- management_network_cider
- management_network_gateway
- controller_m_ip
- mysql_m_ip
```
{% set management_interface_name = 'enp0s8' %}    // input your network envs

provider_interface_name: enp0s3
provider_network_cider: 172.30.1.0/24
provider_network_gateway: 172.30.1.254

management_interface_name: {{ management_interface_name }}
management_network_cider: 10.0.0.0/24 
management_network_gateway: 10.0.0.1  

controller_m_ip: 10.0.0.5
mysql_m_ip: 10.0.0.5
my_m_ip: {{ grains['ip4_interfaces'][management_interface_name][0] }}

rabbit_pass: 1234
admin_pass: 1234
demo_pass: 1234

nova_pass: 1234
neutron_pass: 1234
glance_pass: 1234

metadata_secret: 1234
glance_dbpass: 1234
neutron_dbpass: 1234
nova_dbpass: 1234
placement_pass: 1234
keystone_dbpass: 1234
```

### Mysql node Setting
For using saltstack mysql module,
On controller minion
Put 'mysql.default_file: '/etc/mysql/debian.cnf' on /etc/salt/minion

```
vi /etc/salt/minion


...
...

mysql.default_file: '/etc/mysql/debian.cnf'

```

### Highstate Run (e.g.)
```
base:
  '*':
    - common
  'controller':
    - controller
    - mysql
    - nova-api
    - neutron-server
    - keystone
    - glance
    - horizon
    - neutron
  'compute':
    - compute
```

```
salt '*' state.apply
```