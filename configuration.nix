{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [
      "snd-seq"
      "snd-rawmidi"
      "xhci_hcd"
    ];
    kernelParams = [
      "usbcore.autosuspend=-1"
      "usbcore.quirks=0763:0015:i"
    ];
    # kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
  };

  networking = {
    hostName = "continuity";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 80 443 6600 8000 8080 18080 37889 11434 7777 ];
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opengl = {
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
    dbus = {
      apparmor = "enabled";
    };

    xserver = {
      displayManager = {
        startx.enable = true;
      };

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };
      };

      desktopManager = {
        runXdgAutostartIfNone = true;
      };

      xkb = {
        layout = "us";
        variant = "";
        options = "caps:escape";
      };

      videoDrivers = [ "nvidia" ];
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire-pulse."92-low-latency" = {
        "context.properties" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = { };
          }
        ];
        "pulse.properties" = {
          "pulse.min.req" = "32/48000";
          "pulse.default.req" = "32/48000";
          "pulse.max.req" = "32/48000";
          "pulse.min.quantum" = "32/48000";
          "pulse.max.quantum" = "32/48000";
        };
        "stream.properties" = {
          "node.latency" = "32/48000";
          "resample.quality" = 1;
        };
      };
    };

    kanata = {
      enable = true;
    };

    # External
    calibre-web = {
      enable = true;
      user = "preston";
      openFirewall = true;

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

    monero = {
      enable = true;
    };

    tor = {
      enable = true;
      openFirewall = true;
    };

    i2pd = {
      enable = true;
      address = "0.0.0.0";
      inTunnels = {
      };
      outTunnels = {
      };
    };

    ollama = {
      enable = true;
      acceleration = "cuda";
      # host = "0.0.0.0";
    };

    # Email Service
    dovecot2 = {
      enable = true;
      enableImap = true;
      enablePop3 = true;
    };

    postfix = {
      enable = true;
      config = {
      };
    };

    # Git server
    gitDaemon = {
      enable = true;
      exportAll = true;
      listenAddress = "0.0.0.0";
      basePath = "/srv/git";
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "preston" ];
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = false;
      };
    };

    nginx = {
      enable = true;

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
      
      appendHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Adding this header to HTTP requests is discouraged
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;

      # Enable CSP for your services.
      #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # This might create errors
      proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    '';

      virtualHosts = {
        "ret2pop.net" = {
          # addSSL = true;
          # enableACME = true;
          root = "/home/preston/ret2pop-website/";
        };
      };
    };

    # xmrig = {
    #   enable = true;
    #   package = pkgs.xmrig-mo;
    #   settings = {
    #     autosave = true;
    #     cpu = true;
    #     opencl = false;
    #     cuda = false;
    #     pools = [
    #       {
    #         url = "pool.supportxmr.com:443";
    #         user = "49Yyj1PBXSefihA88bm8RzaKiaBizrDoWTnQy4kKVRWU5vnnqx7CfWbEe9ioKTozYWBMa9Am81q9uMgBdhj8iAriF47TQnM";
    #         keepalive = true;
    #         tls = true;
    #       }
    #     ];
    #   };
    # };

    # Misc.
    udev.packages = with pkgs; [ 
      platformio-core
      platformio-core.udev
      openocd
    ];

    printing.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
  };

  programs = {
    # nix-autobahn.enable = true;
    nix-ld.enable = true;

    nix-ld.libraries = with pkgs; [

      # Add any missing dynamic libraries for unpackaged programs

      # here, NOT in environment.systemPackages

    ];
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

  security = {
    # acme = {
    #   acceptTerms = true;
    #   defaults.email = "ret2pop@gmail.com";
    # };

    pam.loginLimits = [
      { domain = "*"; item = "nofile"; type = "-"; value = "32768"; }
      { domain = "*"; item = "memlock"; type = "-"; value = "32768"; }
    ];
    rtkit.enable = true;

    lockKernelModules = true;
    protectKernelImage = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal xdg-desktop-portal-hyprland ];
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

  users = {
    users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
      ];

      git = {
        isSystemUser = true;
        home = "/srv/git";
        shell = "${pkgs.git}/bin/git-shell";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
        ];
      };

      preston = {
        isNormalUser = true;
        description = "Preston Pan";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" "jackaudio" ];
        shell = pkgs.zsh;
        packages = [
        ];
      };
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  virtualisation.docker.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  system = {
    stateVersion = "23.11";
    nixos = {
      tags = [ "fixing-hammer88" ];
    };
  };
}
