# NixOS + Home Manager

Flake-based NixOS config for my ThinkPad, using:

- **NixOS** for system configuration.
- **Home Manager** (as a NixOS module) for the user environment (`mngt`).
- **Niri** Wayland compositor + **Noctalia** shell.
- External dotfiles from <https://github.com/mngste/dotfiles>.

---

## Layout

```text
.
├── flake.nix
├── hosts/thinkpad/configuration.nix   # System (NixOS)
├── modules/noctalia.nix               # Noctalia package from flake input
└── home/thinkpad
    ├── home.nix                       # Home Manager entrypoint
    ├── packages.nix                   # User apps
    ├── zsh.nix                        # Shell config
    ├── dotfiles.nix                   # ~/.config from external dotfiles repo
    ├── noctalia.nix                   # Noctalia HM module
    ├── fonts.nix                      # JetBrains Nerd Font + Bibata cursor
    └── nb.nix                         # nb CLI installation
```

---

## First-time setup on this machine

1. **Clone the repository**

   ```bash
   git clone https://github.com/mngste/dotfiles-nix.git
   cd dotfiles-nix
   ```

2. **Copy or update `hardware-configuration.nix`**

   - From an existing NixOS system, you can reuse `/etc/nixos/hardware-configuration.nix`:

     ```bash
     cp /etc/nixos/hardware-configuration.nix hosts/thinkpad/
     ```

   - Or generate a new one from a live ISO:

     ```bash
     sudo nixos-generate-config --root /mnt
     sudo cp /mnt/etc/nixos/hardware-configuration.nix hosts/thinkpad/
     ```

3. **Build and switch to this configuration**

   From the root of the repo:

   ```bash
   sudo nixos-rebuild switch --flake .#thinkpad
   ```

   This applies both:

   - `hosts/thinkpad/configuration.nix` (NixOS system)
   - `home/thinkpad/home.nix` via the Home Manager NixOS module.

---

## Updating the system

- **Rebuild with the same flake lock:**

  ```bash
  sudo nixos-rebuild switch --flake .#thinkpad
  ```

- **Update inputs (`nixpkgs`, `home-manager`, `dotfiles`, `noctalia`) and then rebuild:**

  ```bash
  nix flake update
  sudo nixos-rebuild switch --flake .#thinkpad
  ```

---

## Customising

- Add/remove apps: edit `home/thinkpad/packages.nix`.
- Change shell behaviour: edit `home/thinkpad/zsh.nix`.
- Modify Niri / Noctalia / other apps: edit your external `dotfiles` repo; `dotfiles.nix` will sync them into `~/.config`.

For more background:

- Flakes: <https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled> 
- Home Manager: <https://nixos.wiki/wiki/Home_Manager> 
- Niri: <https://wiki.nixos.org/wiki/niri>
- Noctalia on NixOS: <https://docs.noctalia.dev/v5/getting-started/nixos/>
