{ config, pkgs, lib, inputs, desktop, ... }:

{
  ########## base system ##########

  imports = [
    ./hardware-configuration.nix
  ]
  ++ lib.optionals (desktop == "niri") [ ./desktops/niri.nix ]
  ++ lib.optionals (desktop == "kde") [ ./desktops/kde.nix ];

  networking.hostName = "thinkpad";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
  };

  # boot - kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # user
  users.users.mngt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
    shell = pkgs.zsh;
  };

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ########## systemd ##########

  # delete old config
  systemd.services.nix-gc = {
    description = "Nix garbage collection";
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 15d
    '';
  };

  systemd.timers.nix-gc = {
    description = "Weekly Nix garbage collection";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      Unit = "nix-gc.service";
    };
  };

  ########## virtualisation ##########

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ########## network - device ##########

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  ########## audio - printer ##########

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  ########## misc services ##########

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  ########## pkgs ##########

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    nautilus
    virt-manager
    virt-viewer
    qemu
    libvirt
    OVMF
    swtpm
    spice
    spice-gtk
    nano
  ];

  programs.zsh.enable = true;

  system.stateVersion = "26.05";
}
