{ config, pkgs, ... }:

{
  nixpkgs.config.cudaSupport = true;
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = "nix-command flakes";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "continuity";
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 80 443 6600 8000 11434 7777 ];
  };

  time.timeZone = "America/Vancouver";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };
  services.blueman.enable = true;

  virtualisation.docker.enable = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "caps:escape";
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
  };
  services.udisks2.enable = true;

  services.kanata = {
    enable = true;
  };
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
  ];

  users.users.preston = {
    isNormalUser = true;
    description = "Preston Pan";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    curl
    git
    groff
    nixd
    cudatoolkit
    restic
    cudaPackages.cudnn
    cudaPackages.libcublas
    linuxPackages.nvidia_x11
  ];

  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  system.stateVersion = "23.11";
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.15.3"
  ];

  services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.platformio-core.udev
    pkgs.openocd
  ];
  services.calibre-server = {
    enable = true;
    host = "0.0.0.0";
    port = 7777;
    user = "preston";
    group = "preston";
  };
  services.calibre-web = {
    enable = true;
    user = "preston";
    group = "preston";
    listen.port = 7777;
    listen.ip = "0.0.0.0";
    openFirewall = true;
    options = {
      enableBookUploading = true;
      enableKepubify = true;
      enableBookConversion = true;
      calibreLibrary = "/home/preston/books/";
    };
  };
}
