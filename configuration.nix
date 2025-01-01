{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  environment = {
    etc = {
      securetty.text = ''
          # /etc/securetty: list of terminals on which root is allowed to login.
          # See securetty(5) and login(1).
          '';
    };
  };
  # environment = {
  #   memoryAllocator.provider = "scudo";
  #   variables.SCUDO_OPTIONS = "ZeroContents=1";
  # };

  # environment = {
  #   memoryAllocator.provider = "graphene-hardened-light";
  # };

  systemd = {
    coredump.enable = false;
    network.config.networkConfig.IPv6PrivacyExtensions = "kernel";
    tmpfiles.settings = {
      "restricthome"."/home/*".Z.mode = "~0700";

      "restrictetcnixos"."/etc/nixos/*".Z = {
        mode = "0000";
        user = "root";
        group = "root";
      };
    };
  };

  boot = {
    initrd.luks.devices."luks-30d6b69f-1ec0-4111-b5d3-c0138d485a49".device = "/dev/disk/by-uuid/30d6b69f-1ec0-4111-b5d3-c0138d485a49";

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    
    kernelModules = [
      "snd-seq"
      "snd-rawmidi"
      "xhci_hcd"
    ];

    kernelParams = [
      "debugfs=off"
      "page_alloc.shuffle=1"
      "slab_nomerge"
      "page_poison=1"

      # madaidan
      "pti=on"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "module.sig_enforce=1"
      "lockdown=confidentiality"

      # cpu
      "spectre_v2=on"
      "spec_store_bypass_disable=on"
      "tsx=off"
      "tsx_async_abort=full,nosmt"
      "mds=full,nosmt"
      "l1tf=full,force"
      "nosmt=force"
      "kvm.nx_huge_pages=force"

      # hardened
      "extra_latent_entropy"

      # mineral
      "init_on_alloc=1"
      "random.trust_cpu=off"
      "random.trust_bootloader=off"
      "intel_iommu=on"
      "amd_iommu=force_isolation"
      "iommu=force"
      "iommu.strict=1"
      "init_on_free=1"
      "quiet"
      "loglevel=0"
    ];

    blacklistedKernelModules = [
      "netrom"
      "rose"

      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    kernel.sysctl = {
      "kernel.ftrace_enabled" = false;
      "net.core.bpf_jit_enable" = false;
      "kernel.kptr_restrict" = 2;

      # madaidan
      "vm.swappiness" = 1;
      "vm.unprivileged_userfaultfd" = 0;
      "dev.tty.ldisc_autoload" = 0;
      "kernel.kexec_load_disabled" = 1;
      "kernel.sysrq" = 4;
      "kernel.perf_event_paranoid" = 3;

      # net
      "net.ipv4.icmp_echo_ignore_broadcasts" = true;

      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      "net.ipv4.conf.default.accept_redirects" = false;
      "net.ipv4.conf.default.secure_redirects" = false;
      "net.ipv6.conf.all.accept_redirects" = false;
      "net.ipv6.conf.default.accept_redirects" = false;
    };
  };

  networking = {
    hostName = "continuity-dell";
    networkmanager = {
      enable = true;
      # wifi.macAddress = "";
    };
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opengl = {
      enable = true;
    };

    pulseaudio.enable = false;
  };

  services = {
    chrony = {
      enable = true;
      enableNTS = true;
      servers = [ "time.cloudflare.com" "ptbtime1.ptb.de" "ptbtime2.ptb.de" ];
    };

    jitterentropy-rngd.enable = true;
    resolved.dnssec = true;
    # usbguard.enable = true;
    usbguard.enable = false;
    dbus = {
      apparmor = "enabled";
    };

    tor = {
      enable = true;
      openFirewall = true;
      client = {
        enable = true;
        socksListenAddress = {
          IsolateDestAddr = true;
          addr = "127.0.0.1";
          port = 9050;
        };
        dns.enable = true;
      };
      torsocks = {
        enable = true;
        server = "127.0.0.1:9050";
      };
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

      videoDrivers = [];
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

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "preston" ];
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = false;
      };
    };

    # Misc.
    udev.packages = with pkgs; [ 
      platformio-core
      platformio-core.udev
      openocd
    ];

    printing.enable = true;
    udisks2.enable = true;
  };

  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
    light.enable = true;
    ssh.enableAskPassword = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = false;
  };

  security = {
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };

    pam.loginLimits = [
      { domain = "*"; item = "nofile"; type = "-"; value = "32768"; }
      { domain = "*"; item = "memlock"; type = "-"; value = "32768"; }
    ];
    rtkit.enable = true;

    lockKernelModules = true;
    protectKernelImage = true;
    allowSimultaneousMultithreading = false;
    forcePageTableIsolation = true;

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    auditd.enable = true;
    audit.enable = true;
    chromiumSuidSandbox.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "preston" ];
        keepEnv = true;
        persist = true;
      }];
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    cryptsetup
    restic
    sbctl
    linux-manual
    man-pages
    man-pages-posix
    tree
  ];

  users = {
    users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSshvS1N/42pH9Unp3Zj4gjqs9BXoin99oaFWYHXZDJ preston@preston-arch"
      ];

      preston = {
        isNormalUser = true;
        description = "Preston Pan";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" "jackaudio" "tss" "dialout" ];
        shell = pkgs.zsh;
        packages = [
        ];
      };
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  system = {
    stateVersion = "24.11";
    nixos = {
      tags = [ "fixing-hammer88" ];
    };
  };
}
