#!/bin/sh

ip addr add 10.1.1.1/24 dev eth0

# Declaration bridge (Switch virtuel)
ip link add br0 type bridge
ip link set dev br0 up

# Declaration du reseau VXLAN (static)
ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
ip link set dev vxlan10 up

# Assignation eth1 + vxlan10 au br0 (switch virtuel)
brctl addif br0 eth1
brctl addif br0 vxlan10
