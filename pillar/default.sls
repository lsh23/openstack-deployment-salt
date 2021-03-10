{% set management_interface_name = 'eth1' %}

provider_interface_name: eth0
provider_network_cider: 192.168.0.0/24
provider_network_gateway: 192.168.0.1

management_interface_name: {{ management_interface_name }}
management_network_cider: 10.0.0.0/24
management_network_gateway: 10.0.0.1

controller_m_ip: 10.0.0.11
mysql_m_ip: 10.0.0.11
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