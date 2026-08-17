#!/bin/sh

ip addr add 10.1.1.1/30 dev eth0
ip addr add 10.1.1.5/30 dev eth1
ip addr add 10.1.1.9/30 dev eth2

# Assignation IP globale loopback
ip addr add 1.1.1.1/32 dev lo

# -- router ospf
# Defintion des reseaux OSPF
#
# -- router bgp 1
# Delcaration des routeurs distants via leur loopbacks
#
# -- address-family l2vpn evpn
# Utilisation d'EVPN pour le partage de la carte reseau
# Activation des route reflectors
vtysh << EOF
	conf t
	router ospf
	network 1.1.1.1/32 area 0
	network 10.1.1.0/30 area 0
	network 10.1.1.4/30 area 0
	network 10.1.1.8/30 area 0

	router bgp 1
	neighbor 1.1.1.2 remote-as 1
	neighbor 1.1.1.2 update-source lo

	neighbor 1.1.1.3 remote-as 1
	neighbor 1.1.1.3 update-source lo

	neighbor 1.1.1.4 remote-as 1
	neighbor 1.1.1.4 update-source lo

	address-family l2vpn evpn
	neighbor 1.1.1.2 activate
	neighbor 1.1.1.2 route-reflector-client
	neighbor 1.1.1.3 activate
	neighbor 1.1.1.3 route-reflector-client
	neighbor 1.1.1.4 activate
	neighbor 1.1.1.4 route-reflector-client
	exit-address-family
EOF
