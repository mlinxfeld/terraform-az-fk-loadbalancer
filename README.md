# terraform-az-fk-loadbalancer

This repository contains a reusable **Terraform / OpenTofu module** and
progressive examples for deploying **Azure Load Balancers** and attaching
them to **Virtual Machines** and **Virtual Machine Scale Sets (VMSS)** in a
clean, explicit, and architecture-aware way.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed as
a dedicated **traffic distribution layer** for Azure compute workloads.

---

## 🎯 Purpose

The goal of this repository is to provide a **clear, educational, and
composable reference implementation** for **Azure Load Balancer (Standard)**
using Infrastructure as Code.

It focuses on:

- Azure Load Balancer as a **first-class networking resource**
- Explicit frontend, backend pool, probe, and rule modeling
- Clear separation between **traffic entry**, **health validation**, and **backend attachment**
- Clean integration with **VM-based** and **VMSS-based** compute layers
- Terraform/OpenTofu patterns that reflect Azure’s real networking model

This is **not** a landing zone, platform framework, or full application
stack. It is a **learning-first building block** designed to integrate
cleanly with other FoggyKitchen modules.

---

## ✨ What the module does

Depending on configuration and example used, the module can:

- Create an **Azure Standard Load Balancer**
- Create and attach a **public frontend IP**
- Define **backend address pools**
- Configure **health probes**
- Configure **load balancing rules**
- Attach backend pools to:
  - Individual Virtual Machines (NIC-based)
  - Virtual Machine Scale Sets (VMSS)

The module intentionally does **not** create or manage:

- Virtual Networks or subnets
- Network Security Groups
- Virtual Machines themselves
- VM Scale Sets themselves
- Bastion hosts
- Application Gateways
- NAT Gateways
- TLS termination or certificates

Each of those concerns belongs in its own dedicated module.

---

## 📂 Repository Structure

```bash
terraform-az-fk-loadbalancer/
├── examples/
│   ├── 01_public_lb_multiple_vms/
│   ├── 02_public_lb_vmss/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

---

## 🚀 Example Usage

```hcl
module "loadbalancer" {
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-loadbalancer.git?ref=v1.0.0"

  name                = "fk-public-lb"
  location            = "westeurope"
  resource_group_name = "fk-rg"

  public_lb     = true
  frontend_name = "PublicLBIP"

  backend_pool_name = "fk-backend-pool"

  probe = {
    name                = "http-probe"
    protocol            = "Tcp"
    port                = 80
    interval_in_seconds = 5
    number_of_probes    = 2
  }

  rule = {
    name           = "http"
    protocol       = "Tcp"
    frontend_port  = 80
    backend_port   = 80
  }

  tags = {
    project = "foggykitchen"
    env     = "dev"
  }
}
```

---

## 📤 Outputs

| Output | Description |
|------|-------------|
| `lb_id` | Load Balancer resource ID |
| `lb_name` | Load Balancer name |
| `frontend_ip_configuration_name` | Frontend IP configuration name |
| `public_ip_id` | Public IP resource ID (if public_lb=true) |
| `public_ip_address` | Public IP address (if public_lb=true) |
| `backend_pool_id` | Backend Address Pool ID |
| `probe_id` | ID of the health probe |
| `rule_id` | ID of the load balancing rule |

---

## 🧠 Design Philosophy

- Traffic entry must be **explicit**
- Health probes are not optional — they define backend validity
- Load Balancer rules should be **simple and observable**
- One module = one responsibility
- Networking should be modeled the way Azure actually works
- Compute scaling (VM vs VMSS) is a **separate concern**

This repository intentionally avoids abstractions that hide Azure Load
Balancer mechanics behind “magic” defaults.

---

## 🧩 Related Modules & Training

- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)
- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)
- [terraform-az-fk-nsg](https://github.com/mlinxfeld/terraform-az-fk-nsg)
- [terraform-az-fk-disk](https://github.com/mlinxfeld/terraform-az-fk-disk)
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com — Cloud. Code. Clarity.
