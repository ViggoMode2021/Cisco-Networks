---

# 📡 Connecticut Town Public Network Infrastructure

## Overview

This topology simulates a realistic network architecture for **town, Connecticut**, incorporating:

* **Town Public Schools (7 schools)**
* **Town Hall**
* **Town Police Department**
* **CEN (Connecticut Education Network)** as the Internet uplink and regional core

The design includes both **wired and wireless connectivity**, **VLAN segmentation**, centralized management via a **Wireless LAN Controller (WLC)**, and municipal integration.
---

## 🏫 Sites Included

### 📘 Town Public Schools (K-12)

* **Town High School**
* **Town Middle School**
* **Town Elementary School**
* **Town Elementary School**
* **Town Elementary School**
* **Town Elementary School**
* **Town Elementary School**

Each school includes:

* 1 router with multiple VLANs
* 1 access switch stack
* 5 Wi-Fi access points (centrally managed)
* Connectivity to the CEN Core via trunk or routed uplink

---

### 🏛️ Municipal Sites

#### Town Hall

* Public Wi-Fi
* Internal government systems
* Management and IT VLANs

#### Police Department

* Admin systems
* Surveillance network
* CJIS (secure justice information systems)

---

## 🌐 Network Topology

```
[School Routers x7]
         |
     [CEN Core L3 Switch] ---- [Wireless LAN Controller]
         |
     +---+---------------------------+
     |                               |
[Town Hall Router]          [Police Dept Router]
         |                               |
[Admin, Guest VLANs]      [Admin, CJIS, Surveillance]
         |
     [CEN Edge Router] === INTERNET (via BGP/NAT)
```
---

## 🧱 VLAN and Subnet Plan

| VLAN ID | Name                | Subnet (Example) | Used By                 |
| ------- | ------------------- | ---------------- | ----------------------- |
| 10      | Faculty             | 10.10.X.0/24     | Schools (X = School ID) |
| 20      | Students            | 10.20.X.0/24     | Schools                 |
| 30      | IT                  | 10.30.X.0/24     | Schools, Town           |
| 40      | User Devices        | 10.40.X.0/24     | Schools                 |
| 50      | Infrastructure      | 10.50.X.0/24     | Switch/Router Links     |
| 60      | WLC Management      | 10.60.0.0/24     | WLC Only                |
| 70      | AP Management       | 10.70.0.0/24     | All Access Points       |
| 100     | Town Hall Admin     | 10.100.0.0/24    | Town Hall               |
| 101     | Town Hall Guest     | 10.101.0.0/24    | Town Hall               |
| 110     | Police Admin        | 10.110.0.0/24    | PD                      |
| 111     | Police CJIS         | 10.111.0.0/24    | PD (Secure Systems)     |
| 112     | Police Surveillance | 10.112.0.0/24    | PD (Cameras, NVRs)      |

---

## 🔒 Security Design

* **VRF Separation** (optional):

  * `VRF-K12` – for school networks
  * `VRF-PD` – for police department
  * `VRF-TOWN` – for town hall
* **Access Control Lists (ACLs)** on edge interfaces
* **NAT** and **public IP** handled at the CEN edge router
* **DHCP relays** on core for centralized IP assignment

---

## 📶 Wireless Design

* Centralized **WLC at CEN Core**
* 5 APs per school, centrally managed
* WLAN-to-VLAN mappings:
  
  * `PS-Staff` → VLAN 10
  * `PS-Student` → VLAN 20
  * `Town-Public` → VLAN 101
---

## 🔁 Routing

* **OSPF** between routers and the CEN core switch
* **BGP** at the CEN edge with ISP (AS 22742)
* Static routes from edge devices where applicable
* NAT overload for school/private IP ranges
