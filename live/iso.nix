{ pkgs, lib, ... }:
{
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

  networking = {
    hostName = "iso";
    wireless.enable = lib.mkForce false;
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
    graphics = {
      enable = true;
    };
    pulseaudio.enable = false;
  };

  services = {
    qemuGuest.enable = true;
    chrony = {
      enable = true;
      enableNTS = true;
      servers = [ "time.cloudflare.com" "ptbtime1.ptb.de" "ptbtime2.ptb.de" ];
    };

    jitterentropy-rngd.enable = true;
    resolved.dnssec = true;
    dbus = {
      apparmor = "enabled";
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

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "nixos" ];
        PermitRootLogin = "yes";
        KbdInteractiveAuthentication = false;
      };
    };
  };

  programs = {
    zsh.enable = true;
    ssh.enableAskPassword = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = false;
  };

  environment.systemPackages = with pkgs; [
    cryptsetup
    restic
    sbctl
    linux-manual
    man-pages
    man-pages-posix
  ];

  users.extraUsers.root.password = "nixos";
  users.extraUsers.nixos.password = "nixos";
  users.users = {
    nixos = {
      isNormalUser = true;
      description = "NixOS";
      extraGroups = [ "networkmanager" "wheel" "video" "docker" "jackaudio" "tss" "dialout" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        git
        curl
        gum
        (writeShellScriptBin "nix_installer"
          ''
#!/usr/bin/env bash
set -euo pipefail
if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR! $(basename "$0") should be run as a regular user"
  exit 1
fi
if [ ! -d "$HOME/toughnix/" ]; then
  cd $HOME
  git clone https://git.nullring.xyz/toughnix.git
fi
vim "$HOME/toughnix/desktop/vars.nix"
vim "$HOME/toughnix/desktop/sda-simple.nix"
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount "$HOME/toughnix/disko/sda-simple.nix"
cd /mnt

sudo nixos-install --flake $HOME/toughnix#continuity
'')
      ];
    };
  };


  nix.settings.experimental-features = "nix-command flakes";
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  systemd = {
    services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  system = {
    stateVersion = "24.11";
  };
}
