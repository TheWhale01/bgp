#!/bin/sh

ip addr add 10.1.1.1/30 dev eth0
ip addr add 10.1.1.5/30 dev eth1
ip addr add 10.1.1.9/30 dev eth2
ip addr add 1.1.1.1/32 dev lo

vtysh << EOF
	conf t
	router ospf
	network 1.1.1.1/32 area 0
	network 10.1.1.0/30 area 0
	network 10.1.1.4/30 area 0
	network 10.1.1.8/30 area 0
EOF
