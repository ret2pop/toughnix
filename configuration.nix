{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "continuity";
  # networking.wireless.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Vancouver";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
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

  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

   
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
  ];

  users.users.preston = {
    isNormalUser = true;
    description = "Preston Pan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    rnix-lsp
    light
    curl
    git
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  system.stateVersion = "23.11";
}
