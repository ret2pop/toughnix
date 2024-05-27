{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = "nix-command flakes";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "continuity";
  # networking.wireless.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Vancouver";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  virtualisation.docker.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "caps:escape";
  };

  services.ollama = {
    enable = true;
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.xserver.windowManager.qtile = {
    enable = true;
    backend = "wayland";
    #backend = "x11";
    extraPackages = python3Packages: with python3Packages; [
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
  };

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
  ];

  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde ];
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

  # security.apparmor.enable =  true;
  # security.apparmor.policies = pkgs.apparmor-profiles;
  # security.apparmor.killUnconfinedConfinables = true;
#  boot.kernelParams = [
    # Slab/slub sanity checks, redzoning, and poisoning
#    "slub_debug=FZP"

    # Overwrite free'd memory
#    "page_poison=1"

    # Enable page allocator randomization
#    "page_alloc.shuffle=1"
#  ];

  # Disable bpf() JIT (to eliminate spray attacks)
#  boot.kernel.sysctl."net.core.bpf_jit_enable" =  false;

  # Disable ftrace debugging
#  boot.kernel.sysctl."kernel.ftrace_enabled" =  false;

  # boot.kernel.sysctl."net.ipv4.conf.all.log_martians" =  true;
  # boot.kernel.sysctl."net.ipv4.conf.all.rp_filter" =  "1";
  # boot.kernel.sysctl."net.ipv4.conf.default.log_martians" =  true;
  # boot.kernel.sysctl."net.ipv4.conf.default.rp_filter" =  "1";

  # boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" =  true;

  # boot.kernel.sysctl."net.ipv4.conf.all.accept_redirects" =  false;
  # boot.kernel.sysctl."net.ipv4.conf.all.secure_redirects" =  false;
  # boot.kernel.sysctl."net.ipv4.conf.default.accept_redirects" =  false;
  # boot.kernel.sysctl."net.ipv4.conf.default.secure_redirects" =  false;
  # boot.kernel.sysctl."net.ipv6.conf.all.accept_redirects" =  false;
  # boot.kernel.sysctl."net.ipv6.conf.default.accept_redirects" =  false;

  # boot.kernel.sysctl."net.ipv4.conf.all.send_redirects" = false;
  # boot.kernel.sysctl."net.ipv4.conf.default.send_redirects" = false;
}
