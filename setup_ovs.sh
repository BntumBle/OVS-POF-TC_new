set -e

mkdir -p /usr/local/etc/openvswitch
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db \
	    vswitchd/vswitch.ovsschema
mkdir -p /usr/local/var/run/openvswitch
sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
	    --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
	        --pidfile --detach --log-file
sudo ovs-vsctl --no-wait init
sudo ovs-vswitchd --pidfile --detach --log-file

sudo ovs-vsctl add-br br0 
sudo ovs-vsctl add-port br0 eth4
sudo ovs-vsctl add-port br0 eth5
sudo ovs-vsctl set bridge br0 other-config:datapath-id=0000000000000001
