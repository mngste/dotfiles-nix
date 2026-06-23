{ config, pkgs, inputs, ... }:

{
  ########## base system ##########

  imports = [
    ./hardware-configuration.nix
  ];

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

  ########## virtualisation ##########

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [
        (pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd
      ];
    };
  };

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

  ########## desktop wayland (niri + noctalia) ##########

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.niri.enable = true;

  # notifications / idle / polkit
  services.mako.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  # portals (screen‑sharing, file picker, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    # if nautilus removed
    # config.niri = {
    #   "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    # };
  };

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
  ];

  programs.zsh.enable = true;

  system.stateVersion = "26.05";
}
