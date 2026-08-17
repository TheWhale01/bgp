#!/bin/bash

# Declaration du VXLAN (CF. Partie 2)
ip addr add 10.1.1.6/30 dev eth0
ip addr add 1.1.1.3/32 dev lo
ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 local 1.1.1.3 dstport 4789 nolearning
ip link set dev vxlan10 up
brctl addif br0 vxlan10
brctl addif br0 eth1

# -- router ospf
# Defintion des reseaux OSPF
#
# -- router bgp 1
# Delcaration des routeurs distants via leur loopbacks
#
# -- address-family l2vpn evpn
# Declaration du route reflector -> Reception de la carte reseau
vtysh << EOF
	conf t
	router ospf
	network 1.1.1.3/32 area 0
	network 10.1.1.4/30 area 0
	router bgp 1
	neighbor 1.1.1.1 remote-as 1
	neighbor 1.1.1.1 update-source lo
	address-family l2vpn evpn
	neighbor 1.1.1.1 activate
	advertise-all-vni
	exit-address-family
EOF
