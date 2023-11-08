-- R1 --

en
sh run
sh ip int br
conf t
no int g0/0.10
no int g0/0.20
no int g0/0.30
do sh ip int br
int g0/0
ip add 10.0.0.194 255.255.255.192

-- SW 2 --
en
sh run
conf t
default int g1/0/2
int g1/0/2
no switchport
ip add 10.0.0.193 255.255.255.252
exit
do sh ip route
ip routing
ip route 0.0.0.0 0.0.0.0 10.0.0.194
do sh ip route
do sh vlan br
int vlan 10
ip add 10.0.0.62 255.255.255.192
int vlan 20
ip add 10.0.0.126 255.255.255.192
int vlan 30
ip add 10.0.0.190 255.255.255.192
exit
do sh ip int br
