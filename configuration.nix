{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "continuity";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 80 443 6600 8000 11434 7777 ];
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    pulseaudio.enable = false;
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      desktopManager = {
        runXdgAutostartIfNone = true;
      };
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
        options = "caps:escape";
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      #media-session.enable = true;
    };

    kanata = {
      enable = true;
    };

    # External
    calibre-web = {
      enable = true;
      user = "preston";
      openFirewall = true;
      # group = "preston";

      listen = {
        port = 9999;
        ip = "0.0.0.0";
      };

      options = {
        enableBookUploading = true;
        enableKepubify = true;
        enableBookConversion = true;
        calibreLibrary = "/home/preston/books/physics/";
      };
    };

    ollama = {
      enable = true;
      acceleration = "cuda";
      host = "0.0.0.0";
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = false;
      };
    };

    nginx = {
      enable = true;
    };

    # Misc.
    udev.packages = [ 
      pkgs.platformio-core
      pkgs.platformio-core.udev
      pkgs.openocd
    ];

    printing.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
  };

  programs = {
    zsh.enable = true;
    light.enable = true;
    ssh.enableAskPassword = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
    permittedInsecurePackages = [
      "nix-2.15.3"
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

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

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
    ];
    preston = {
      isNormalUser = true;
      description = "Preston Pan";
      extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
      ];
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  virtualisation.docker.enable = true;
  security.rtkit.enable = true;
  # services.xserver.libinput.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  system.stateVersion = "23.11";
}
