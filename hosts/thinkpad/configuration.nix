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

  # locales and keyboard
  services.xserver = {
    enable = true;
    xkb = {
      layout  = "us,us";
      variant = ",intl";
      options = "grp:win_space_toggle,ctrl:nocaps";
    };
    exportConfiguration = true;
  };
  environment.variables = {
    XKB_DEFAULT_LAYOUT  = "us,us";
    XKB_DEFAULT_VARIANT = ",intl";
    XKB_DEFAULT_OPTIONS = "grp:win_space_toggle,ctrl:nocaps";
  };

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

  #services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  ########## audio - printer ##########

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  ########## power features ##########

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
  };

  ########## misc services ##########

  services.syncthing = {
    enable = true;
    user = "mngt";
    dataDir = "/home/mngt";
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  services.trezord.enable = true;

  services.udisks2.enable = true;

  ########## pkgs ##########

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "proton-pass-cli"
    ];

  environment.systemPackages = with pkgs; [
    git
    tree
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
    nodejs
    gcc
    proton-pass-cli
  ];

  programs.zsh.enable = true;

  system.stateVersion = "26.05";
}
