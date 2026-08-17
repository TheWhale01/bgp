# BADASS (Bgp at Doors of Autonomous System is Simple)

Ce projet a pour but de nous faire decouvrir le protocol BGP qui permet a internet de fonctionner.

## Acronymes

BGP: Border Gateway Protocol -> Permet de trouver le chemin le plus court pour connecter deux reseaux
OSPF: Open Sortest Path First -> Protocol de routage intra-reseau
IS-IS: Intermediate System to Intermediate System -> Protocol de routage intra-reseau
VXLAN: Virtual eXtensible Local Area Network -> Permet de merger deux reseaux locaux distants en un seul
EVPN: Ethernet Virtual Private Network -> Construction et distribution d'un annuaire d'adresse MAC
RR: Route Reflection -> Appareil reseau permettant la distribution d'un annuaire a destination des routeurs
VTEP: VXLAN Tunnel Endpoint -> Appareil appartenant a un reseau VXLAN

## Part 2

Cette partie nous permet d'implementer VXLAN. Le principe est simple, encapsuler une trame ethernet (Layer 2) dans un paquet (Layer 3).

### Static

Dans ce mode chaque routeur distant est declare via son adresse IP dans la configuration VXLAN (remote 10.1.1.X)

### Dynamic

Dans ce mode toutes les requetes sont envoyees au groupe VXLAN (239.1.1.1) cela nous evite d'avoir a manuellement declarer les routeurs VXLAN a la main.

## Part 3

Utilisation de BGP EVPN pour eviter le probleme de flood reseau impose par VXLAN. Le principe est simple:
cartographier le reseau et partager cette carte a tous les routeurs pour eviter le flood.
