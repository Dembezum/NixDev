# 🐧 NixOs flake

[![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org/)
[![License](https://img.shields.io/github/license/dembezum/nix?style=flat-square)](./LICENSE)
[![Stars](https://img.shields.io/github/stars/dembezum/nix?style=flat-square)](https://github.com/dembezum/nix/stargazers)
[![Issues](https://img.shields.io/github/issues/dembezum/nix?style=flat-square)](https://github.com/dembezum/nix/issues)

A **declarative** and **reproducible** NixOS configuration using flakes, home-manager, and more.

---

## Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Directory Structure](#-directory-structure)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Customization](#-customization)

---

## Features

- **Flakes Support**: Leveraging the power of Nix flakes for reproducible configurations.
- **Home Manager Integration**: Manage user environments seamlessly.
- **Multi-Platform Support**: Configurations for different hardware platforms.
- **Custom Modules**: Extend functionality with custom Nix modules.

---

## Screenshots

*Coming soon!*

---

## Directory Structure

```plaintext
├── flake.nix
├── hosts
│   ├── host1
│   │   ├── configuration.nix
│   │   ├── disko-config.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   ├── host2
│   │   ├── configuration.nix
│   │   ├── disko-config.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
├── modules
│   ├── services/
│   ├── system/
│   └── user/
└── universal.nix

```

---

## Prerequisites

- **NixOS** installed
- **Git**
- **Enable Nix flakes**:

---

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/dembezum/nix
   ```

2. **Enter the Directory**

   ```bash
   cd nix
   ```

3. **Apply the Configuration**

> Make sure to select the proper host in flake.nix

   ```bash
   sudo nixos-rebuild switch --flake .#system
   ```

---

## Usage

To use this flake, you need to have Nix with [flakes](https://nixos.wiki/wiki/Flakes) enabled. You will
also make sure to generate a hardware-config.nix and replace it with the one in
the flake. The beauty is that you can decide what you want included in the build by
just en -disabling the modules in the `configuration.nix`, and `home.nix`.

You will want to install [home-manager](https://nix-community.github.io/home-manager/) as well.

### Building the System

To build the NixOS configuration:

```bash
sudo nixos-rebuild switch --flake .#system
```

### Managing Home Manager

To apply `home-manager` configurations:

```bash
home-manager switch --flake .#user
```

### Updating the System

```bash
nix flake update && sudo nixos-rebuild switch --flake .#system
home-manager switch --flake .#user
```

---

## Customization

- **Adding a New Host**

  - Create a new folder in `hosts/` named after your hostname.
  - add configuration.nix, home.nix, hardware-configuration.nix, and disko-config.nix files.
  - Define your host-specific configurations.

---
