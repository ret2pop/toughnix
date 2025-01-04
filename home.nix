{ pkgs, wallpapers, scripts, ... }:
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "preston";
    homeDirectory = "/home/preston";
    stateVersion = "23.11";
    
    packages = with pkgs; [
      acpilight
      alsa-utils
      autobuild
      bitcoin
      bear
      bun
      cargo
      clang
      clang-tools
      curl
      electrum
      ffmpeg
      fira-code
      font-awesome_6
      fswebcam
      gdb
      ghostscript
      git
      gnumake
      gnupg
      graphviz
      grim
      helvum
      imagemagick
      inkscape
      # kicad
      krita
      libnotify
      miniserve
      monero-gui
      monero-cli
      mpc-cli
      mu
      nixd
      nil
      nixfmt-rfc-style
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      octaveFull
      openscad
      openscad-lsp
      passExtensions.pass-otp
      pandoc
      pavucontrol
      pfetch
      pinentry
      poetry
      python3
      python312Packages.jedi
      rsync
      rust-analyzer
      rustfmt
      solc
      sox
      swww
      texliveFull
      typescript
      tor-browser
      torsocks
      vesktop
      vim
      vscode-langservers-extracted
      x11_ssh_askpass
      xdg-utils
      nodejs
      yarn
      jq
      (aspellWithDicts
        (dicts: with dicts; [ en en-computers en-science ]))
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      (pass.withExtensions (ext: with ext; [
        pass-otp
        pass-import
        pass-genphrase
        pass-update
        pass-tomb
      ]))
    ];
  };

  services = {
    mako = {
      enable = true;
      backgroundColor = "#11111bf8";
      textColor = "#cdd6f4";
      borderColor = "#89b4faff";
      borderRadius = 1;
      font = "Fira Code 10";
      defaultTimeout = 3000;
      extraConfig = ''
on-notify=exec mpv /home/preston/sounds/notification.wav --no-config --no-video
'';
    };

    gpg-agent = {
      pinentryPackage = pkgs.pinentry-emacs;
      enable = true;
      extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    };

    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 49.282730;
      longitude = -123.120735;
      
      temperature = {
        day = 5000;
        night = 3000;
      };

      settings = {
        general = {
          adjustment-method = "wayland";
        };
      };
    };

    mpd = {
      enable = true;
      dbFile = "/home/preston/.config/mpd/db";
      dataDir = "/home/preston/.config/mpd/";
      network.port = 6600;
      musicDirectory = "/home/preston/music";
      playlistDirectory = "/home/preston/.config/mpd/playlists";
      network.listenAddress = "0.0.0.0";
      extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire output"
      }
      audio_output {
	      type		"httpd"
      	name		"My HTTP Stream"
      	encoder		"opus"		# optional
      	port		"8000"
     #	quality		"5.0"			# do not define if bitrate is defined
       	bitrate		"128000"			# do not define if quality is defined
      	format		"48000:16:1"
      	always_on       "yes"			# prevent MPD from disconnecting all listeners when playback is stopped.
       	tags            "yes"			# httpd supports sending tags to listening streams.
      }
    '';
    };
  };

  programs = {
    chromium = {
      package = pkgs.chromium;
      enable = true;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock-origin lite
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        "oicakdoenlelpjnkoljnaakdofplkgnd" # tree style tabs
        "nkbihfbeogaeaoehlefnkodbefgpgknn" # metamask
      ];
    };

    mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
      };
    };

    yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        embed-subs = true;
        sub-langs = "all";
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };

    wofi = {
      enable = true;
      settings = {
        location = "bottom-right";
        allow_markup = true;
        show = "drun";
        width = 750;
        height = 400;
        always_parse_args = true;
        show_all = false;
        term = "kitty";
        hide_scroll = true;
        print_command = true;
        insensitive = true;
        prompt = "Run what, Commander?";
        columns = 2;
      };

      style = ''
      @define-color	rosewater  #f5e0dc;
      @define-color	rosewater-rgb  rgb(245, 224, 220);
      @define-color	flamingo  #f2cdcd;
      @define-color	flamingo-rgb  rgb(242, 205, 205);
      @define-color	pink  #f5c2e7;
      @define-color	pink-rgb  rgb(245, 194, 231);
      @define-color	mauve  #cba6f7;
      @define-color	mauve-rgb  rgb(203, 166, 247);
      @define-color	red  #f38ba8;
      @define-color	red-rgb  rgb(243, 139, 168);
      @define-color	maroon  #eba0ac;
      @define-color	maroon-rgb  rgb(235, 160, 172);
      @define-color	peach  #fab387;
      @define-color	peach-rgb  rgb(250, 179, 135);
      @define-color	yellow  #f9e2af;
      @define-color	yellow-rgb  rgb(249, 226, 175);
      @define-color	green  #a6e3a1;
      @define-color	green-rgb  rgb(166, 227, 161);
      @define-color	teal  #94e2d5;
      @define-color	teal-rgb  rgb(148, 226, 213);
      @define-color	sky  #89dceb;
      @define-color	sky-rgb  rgb(137, 220, 235);
      @define-color	sapphire  #74c7ec;
      @define-color	sapphire-rgb  rgb(116, 199, 236);
      @define-color	blue  #89b4fa;
      @define-color	blue-rgb  rgb(137, 180, 250);
      @define-color	lavender  #b4befe;
      @define-color	lavender-rgb  rgb(180, 190, 254);
      @define-color	text  #cdd6f4;
      @define-color	text-rgb  rgb(205, 214, 244);
      @define-color	subtext1  #bac2de;
      @define-color	subtext1-rgb  rgb(186, 194, 222);
      @define-color	subtext0  #a6adc8;
      @define-color	subtext0-rgb  rgb(166, 173, 200);
      @define-color	overlay2  #9399b2;
      @define-color	overlay2-rgb  rgb(147, 153, 178);
      @define-color	overlay1  #7f849c;
      @define-color	overlay1-rgb  rgb(127, 132, 156);
      @define-color	overlay0  #6c7086;
      @define-color	overlay0-rgb  rgb(108, 112, 134);
      @define-color	surface2  #585b70;
      @define-color	surface2-rgb  rgb(88, 91, 112);
      @define-color	surface1  #45475a;
      @define-color	surface1-rgb  rgb(69, 71, 90);
      @define-color	surface0  #313244;
      @define-color	surface0-rgb  rgb(49, 50, 68);
      @define-color	base  #1e1e2e;
      @define-color	base-rgb  rgb(30, 30, 46);
      @define-color	mantle  #181825;
      @define-color	mantle-rgb  rgb(24, 24, 37);
      @define-color	crust  #11111b;
      @define-color	crust-rgb  rgb(17, 17, 27);

      * {
        font-family: 'Iosevka Nerd Font', monospace;
        font-size: 14px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.16em solid @lavender;
        border-radius: 0.1em;
        background-color: @base;
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: none;
        border-radius: 0.1em;
        color: @text;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: @red;
      }

      #input * {
        outline: 4px solid @red!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: @text;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        background-color: @base;
      }

      #entry arrow {
        border: none;
        color: @lavender;
      }

      /* Selected Entry */
      #entry:selected {
        border: 0.11em solid @lavender;
      }

      #entry:selected #text {
        color: @mauve;
      }

      #entry:drop(active) {
        background-color: @lavender!important;
      }
    '';
    };

    kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        font_family = "Iosevka Nerd Font";
        font_size = 14;
        confirm_os_window_close = 0;
        background_opacity = "0.9";
        # Catppuccin theme
        foreground = "#cdd6f4";
        background = "#1e1e2e";
        selection_foreground = "#1e1e2e";
        selection_background = "#f5e0dc";
        cursor = "#f5e0dc";
        cursor_text_color = "#1e1e2e";
        url_color = "#f5e0dc";
        active_border_color = "#B4BEFE";
        inactive_border_color = "#6C7086";
        bell_border_color = "#F9E2AF";
        wayland_titlebar_color = "#1E1E2E";
        macos_titlebar_color = "#1E1E2E";
        active_tab_foreground = "#11111B";
        active_tab_background = "#CBA6F7";
        inactive_tab_foreground = "#CDD6F4";
        inactive_tab_background = "#181825";
        tab_bar_background = "#11111B";
        mark1_foreground = "#1E1E2E";
        mark1_background = "#B4BEFE";
        mark2_foreground = "#1E1E2E";
        mark2_background = "#CBA6F7";
        mark3_foreground = "#1E1E2E";
        mark3_background = "#74C7EC";
        color0 = "#45475A";
        color8 = "#585B70";
        color1 = "#F38BA8";
        color9 = "#F38BA8";
        color2 = "#A6E3A1";
        color10 = "#A6E3A1";
        color3 = "#F9E2AF";
        color11 = "#F9E2AF";
        color4 = "#89B4FA";
        color12 = "#89B4FA";
        color5 = "#F5C2E7";
        color13 = "#F5C2E7";
        color6 = "#94E2D5";
        color14 = "#94E2D5";
        color7 = "#BAC2DE";
        color15 = "#A6ADC8";
      };
    };

    firefox = {
      policies = {
        EnableTrackingProtection = true;
        OfferToSaveLogins = false;
      };

      package = pkgs.firefox-wayland;
      enable = true;

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            tree-style-tab
            firefox-color
            vimium
            metamask
          ];

          settings = {
            media = {
              memory_cache_max_size = 65536;
              cache_readahead_limit = 7200;
              cache_resume_threshold = 3600;
              peerconnection.ice = {
                proxy_only_if_behind_proxy = true;
                default_address_only = true;
              };
            };

            gfx = {
              content.skia-font-cache-size = 20;
              canvas.accelerated = {
                cache-items = 4096;
                cache-size = 512;
              };
            };

            network = {
              http = {
                max-connections = 1800;
                max-persistent-connections-per-server = 10;
                max-urgent-start-excessive-connections-per-host = 5;
                referer.XOriginTrimmingPolicy = 2;
              };

              buffer.cache = {
                size = 262144;
                count = 128;
              };

              dns = {
                max_high_priority_threads = 8;
                disablePrefetch = true;
              };

              pacing.requests.enabled = false;
              dnsCacheExpiration = 3600;
              ssl_tokens_cache_capacity = 10240;
              prefetch-next = false;
              predictor.enabled = false;
              cookie.sameSite.noneRequiresSecure = true;
              IDN_show_punycode = true;
              auth.subresource-http-auth-allow = 1;
              captive-portal-service.enabled = false;
              connectivity-service.enabled = false;
            };

            browser = {
              download = {
                always_ask_before_handling_new_types = true;
                manager.addToRecentDocs = false;
                open_pdf_attachments_inline = true;
                start_downloads_in_tmp_dir = true;
              };

              urlbar = {
                suggest.quicksuggest.sponsored = false;
                suggest.quicksuggest.nonsponsored = false;
                suggest.calculator = true;
                update2.engineAliasRefresh = true;
                unitConversion.enabled = true;
                trending.featureGate = false;
              };

              search = {
                separatePrivateDefault.ui.enabled = true;
                suggest.enabled = false;
              };

              newtabpage.activity-stream = {
                feeds = {
                  topsites = false;
                  section.topstories = false;
                  telemetry = false;
                };
                asrouter.userprefs.cfr = {
                  addons = false;
                  features = false;
                };
                telemetry = false;
              };

              privatebrowsing = {
                vpnpromourl = "";
                forceMediaMemoryCache = true;
              };

              display = {
                focus_ring_on_anything = true;
                focus_ring_style = 0;
                focus_ring_width = 0;
              };

              cache.jsbc_compression_level = 3;
              helperApps.deleteTempFileOnExit = true;
              uitour.enabled = false;
              sessionstore.interval = 60000;
              formfill.enable = false;
              xul.error_pages.expert_bad_cert = true;
              contentblocking.category = "strict";
              ping-centre.telemetry = false;
              discovery.enabled = false;
              shell.checkDefaultBrowser = false;
              preferences.moreFromMozilla = false;
              tabs.tabmanager.enabled = false;
              aboutConfig.showWarning = false;
              aboutwelcome.enabled = false;
              bookmarks.openInTabClosesMenu = false;
              menu.showViewImageInfo = true;
              compactmode.show = true;
              safebrowsing.downloads.remote.enabled = false;
              tabs.crashReporting.sendReport = false;
              crashReports.unsubmittedCheck.autoSubmit2 = false;
              privateWindowSeparation.enabled = false;
            };

            security = {
              mixed_content = {
                block_display_content = true;
                upgrade_display_content = true;
              };
              insecure_connection_text = {
                enabled = true;
                pbmode.enabled = true;
              };
              OCSP.enabled = 0;
              remote_settings.crlite_filters.enabled = true;
              pki.crlite_mode = 2;
              ssl.treat_unsafe_negotiation_as_broken = true;
              tls.enable_0rtt_data = false;
            };

            toolkit = {
              telemetry = {
                unified = false;
                enabled = false;
                server = "data:,";
                archive.enabled = false;
                newProfilePing.enabled = false;
                shutdownPingSender.enabled = false;
                updatePing.enabled = false;
                bhrPing.enabled = false;
                firstShutdownPing.enabled = false;
                coverage.opt-out = true;
              };
              coverage = {
                opt-out = true;
                endpoint.base = "";
              };
              legacyUserProfileCustomizations.stylesheets = true;
            };

            dom = {
              security = {
                https_first = true;
                https_first_schemeless = true;
                sanitizer.enabled = true;
              };
              enable_web_task_scheduling = true;
            };

            layout = {
              css = {
                grid-template-masonry-value.enabled = true;
                has-selector.enabled = true;
                prefers-color-scheme.content-override = 2;
              };
              word_select.eat_space_to_next_word = false;
            };

            urlclassifier = {
              trackingSkipURLs = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
              features.socialtracking.skipURLs = "*.instagram.com, *.twitter.com, *.twimg.com";
            };

            privacy = {
              globalprivacycontrol.enabled = true;
              history.custom = true;
              userContext.ui.enabled = true;
            };

            full-screen-api = {
              transition-duration = {
                enter = "0 0";
                leave = "0 0";
              };
              warning = {
                delay = -1;
                timeout = 0;
              };
            };

            permissions.default = {
              desktop-notification = 2;
              geo = 2;
            };

            signon = {
              formlessCapture.enabled = false;
              privateBrowsingCapture.enabled = false;
            };

            datareporting = {
              policy.dataSubmissionEnabled = false;
              healthreport.uploadEnabled = false;
            };

            extensions = {
              pocket.enabled = false;
              getAddons.showPane = false;
              htmlaboutaddons.recommendations.enabled = false;
              postDownloadThirdPartyPrompt = false;
            };

            app = {
              shield.optoutstudies.enabled = false;
              normandy.enabled = false;
              normandy.api_url = "";
            };

            image.mem.decode_bytes_at_a_time = 32768;
            editor.truncate_user_pastes = false;
            pdfjs.enableScripting = false;
            geo.provider.network.url = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
            permissions.manager.defaultsUrl = "";
            webchannel.allowObject.urlWhitelist = "";
            breakpad.reportURL = "";
            captivedetect.canonicalURL = "";
            cookiebanners.service.mode = 1;
            findbar.highlightAll = true;
            content.notify.interval = 100000;
          };
        };
      };
    };
    waybar = {
      enable = true;
      style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: Iosevka Nerd Font, FontAwesome, Noto Sans CJK;
          font-size: 14px;
          font-style: normal;
          min-height: 0;
      }

      window#waybar {
          background: rgba(30, 30, 46, 0.5);
          border-bottom: 1px solid #45475a;
          color: #cdd6f4;
      }

      #workspaces {
        background: #45475a;
        margin: 5px 5px 5px 5px;
        padding: 0px 5px 0px 5px;
        border-radius: 16px;
        border: solid 0px #f4d9e1;
        font-weight: normal;
        font-style: normal;
      }
      #workspaces button {
          padding: 0px 5px;
          border-radius: 16px;
          color: #a6adc8;
      }

      #workspaces button.active {
          color: #f4d9e1;
          background-color: transparent;
          border-radius: 16px;
      }

      #workspaces button:hover {
      	background-color: #cdd6f4;
      	color: black;
      	border-radius: 16px;
      }

      #custom-date, #clock, #battery, #pulseaudio, #network, #custom-randwall, #custom-launcher {
      	background: transparent;
      	padding: 5px 5px 5px 5px;
      	margin: 5px 5px 5px 5px;
        border-radius: 8px;
        border: solid 0px #f4d9e1;
      }

      #custom-date {
      	color: #D3869B;
      }

      #custom-power {
      	color: #24283b;
      	background-color: #db4b4b;
      	border-radius: 5px;
      	margin-right: 10px;
      	margin-top: 5px;
      	margin-bottom: 5px;
      	margin-left: 0px;
      	padding: 5px 10px;
      }

      #tray {
          background: #45475a;
          margin: 5px 5px 5px 5px;
          border-radius: 16px;
          padding: 0px 5px;
          /*border-right: solid 1px #282738;*/
      }

      #clock {
          color: #cdd6f4;
          background-color: #45475a;
          border-radius: 0px 0px 0px 24px;
          padding-left: 13px;
          padding-right: 15px;
          margin-right: 0px;
          margin-left: 10px;
          margin-top: 0px;
          margin-bottom: 0px;
          font-weight: bold;
          /*border-left: solid 1px #282738;*/
      }

      #battery {
          color: #89b4fa;
      }

      #battery.charging {
          color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
          background-color: #f7768e;
          color: #f38ba8;
          border-radius: 5px 5px 5px 5px;
      }

      #backlight {
          background-color: #24283b;
          color: #db4b4b;
          border-radius: 0px 0px 0px 0px;
          margin: 5px;
          margin-left: 0px;
          margin-right: 0px;
          padding: 0px 0px;
      }

      #network {
          color: #f4d9e1;
          border-radius: 8px;
          margin-right: 5px;
      }

      #pulseaudio {
          color: #f4d9e1;
          border-radius: 8px;
          margin-left: 0px;
      }

      #pulseaudio.muted {
          background: transparent;
          color: #928374;
          border-radius: 8px;
          margin-left: 0px;
      }

      #custom-randwall {
          color: #f4d9e1;
          border-radius: 8px;
          margin-right: 0px;
      }

      #custom-launcher {
          color: #e5809e;
          background-color: #45475a;
          border-radius: 0px 24px 0px 0px;
          margin: 0px 0px 0px 0px;
          padding: 0 20px 0 13px;
          /*border-right: solid 1px #282738;*/
          font-size: 20px;
      }

      #custom-launcher button:hover {
          background-color: #FB4934;
          color: transparent;
          border-radius: 8px;
          margin-right: -5px;
          margin-left: 10px;
      }

      #custom-playerctl {
      	background: #45475a;
      	padding-left: 15px;
        padding-right: 14px;
      	border-radius: 16px;
        /*border-left: solid 1px #282738;*/
        /*border-right: solid 1px #282738;*/
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 0px;
        font-weight: normal;
        font-style: normal;
        font-size: 16px;
      }

      #custom-playerlabel {
          background: transparent;
          padding-left: 10px;
          padding-right: 15px;
          border-radius: 16px;
          /*border-left: solid 1px #282738;*/
          /*border-right: solid 1px #282738;*/
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
      }

      #window {
          background: #45475a;
          padding-left: 15px;
          padding-right: 15px;
          border-radius: 16px;
          /*border-left: solid 1px #282738;*/
          /*border-right: solid 1px #282738;*/
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
      }

      #custom-wf-recorder {
          padding: 0 20px;
          color: #e5809e;
          background-color: #1E1E2E;
      }

      #cpu {
          background-color: #45475a;
          /*color: #FABD2D;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #memory {
          background-color: #45475a;
          /*color: #83A598;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #disk {
          background-color: #45475a;
          /*color: #8EC07C;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #custom-hyprpicker {
          background-color: #45475a;
          /*color: #8EC07C;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 11px 0px 9px;
          font-weight: bold;
      }
    '';
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 50;

          output = [
            "HDMI-A-1"
            "eDP-1"
            "DP-2"
            "DP-3"
          ];

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "battery" "clock" ];

          battery = {
            format = "{icon}  {capacity}%";
            format-icons = ["" "" "" "" "" ];
          };

          clock = {
            format = "⏰ {:%a %d, %b %H:%M}";
          };
        };
      };
    };

    zsh = {
      enable = true;
      initExtra = ''
    umask 0077
    export EXTRA_CCFLAGS="-I/usr/include"
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    export QT_QPA_PLATFORM="wayland"
    '';

      localVariables = {
        EDITOR = "emacsclient --create-frame --alternate-editor=vim";
        INPUT_METHOD = "fcitx";
        QT_IM_MODULE = "fcitx";
        GTK_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        XIM_SERVERS = "fcitx";
        WXSUPPRESS_SIZER_FLAGS_CHECK = "1";
      };

      shellAliases = {
        c = "clear";
        g = "git";
        v = "vim";
        py = "python3";
        rb = "doas nixos-rebuild switch";
        nfu = "cd ~/src/hyprnixmacs && git add . && git commit -m \"new flake lock\" && cd /etc/nixos/ && doas nix flake update";
        usite
        = "cd ~/src/publish-org-roam-ui && bash local.sh && rm -rf ~/website_html/graph_view; cp -r ~/src/publish-org-roam-ui/out ~/website_html/graph_view && rsync -azvP --chmod=\"Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r\" ~/website_html/ root@nullring.xyz:/usr/share/nginx/ret2pop/";
        sai = "eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/id_ed25519 && ssh-add -l";
        i3 = "exec ${pkgs.i3-gaps}/bin/i3";
      };
      loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ];then
          exec Hyprland
      fi
    '';
    };

    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraConfig = ''
      (setq debug-on-error t)
      (org-babel-load-file
        (expand-file-name "~/org/website/config/emacs.org"))'';
      extraPackages = epkgs: [
        epkgs.all-the-icons
        epkgs.auctex
        epkgs.catppuccin-theme
        epkgs.chatgpt-shell
        epkgs.company
        epkgs.counsel
        epkgs.dashboard
        epkgs.doom-modeline
        epkgs.irony-eldoc
        epkgs.elfeed
        epkgs.elfeed-org
        epkgs.ellama
        epkgs.elpher
        epkgs.ement
        epkgs.emmet-mode
        epkgs.emms
        epkgs.enwc
        epkgs.unicode-fonts
        epkgs.evil
        epkgs.evil-collection
        epkgs.evil-commentary
        epkgs.evil-org
        epkgs.f
        epkgs.general
        epkgs.gptel
        epkgs.gruvbox-theme
        epkgs.htmlize
        epkgs.ivy
        epkgs.ivy-pass
        epkgs.latex-preview-pane
        epkgs.lsp-ivy
        epkgs.lsp-mode
        epkgs.lyrics-fetcher
        epkgs.magit
        epkgs.magit-delta
        epkgs.mu4e
        epkgs.nix-mode
        epkgs.org-fragtog
        epkgs.org-journal
        epkgs.org-roam
        epkgs.org-roam-ui
        epkgs.org-superstar
        epkgs.page-break-lines
        epkgs.password-store
        epkgs.pdf-tools
        epkgs.pinentry
        epkgs.projectile
        epkgs.platformio-mode
        epkgs.rustic

        epkgs.flycheck
        epkgs.solidity-mode
        epkgs.solidity-flycheck
        epkgs.company-solidity

        epkgs.scad-mode
        epkgs.simple-httpd
        epkgs.sudo-edit
        epkgs.treemacs
        epkgs.treemacs-evil
        epkgs.treemacs-magit
        epkgs.treemacs-projectile
        epkgs.treesit-auto
        epkgs.typescript-mode
        epkgs.use-package
        epkgs.vterm
        epkgs.writeroom-mode
        epkgs.web-mode
        epkgs.websocket
        epkgs.which-key
        epkgs.writegood-mode
        epkgs.yasnippet
        epkgs.yasnippet-snippets
      ];
    };

    mbsync = {
      enable = true;
      # CHANGEME
      extraConfig = ''
      IMAPAccount ret2pop
      Host imap.gmail.com
      User ret2pop@gmail.com
      PassCmd "pass Mail"
      Port 993
      TLSType IMAPS
      AuthMechs *
      CertificateFile /etc/ssl/certs/ca-certificates.crt

      IMAPStore ret2pop-remote
      Account ret2pop

      MaildirStore ret2pop-local
      Path ~/email/ret2pop/
      Inbox ~/email/ret2pop/INBOX
      SubFolders Verbatim

      Channel ret2pop 
      Far :ret2pop-remote:
      Near :ret2pop-local:
      Patterns *
      Create Near
      Sync All
      Expunge None
      SyncState *
    '';
    };

    msmtp = {
      enable = true;
      extraConfig = ''
      # CHANGEME
      # Set default values for all following accounts.
      defaults
      auth           on
      tls            on
      tls_trust_file /etc/ssl/certs/ca-certificates.crt
      tls_certcheck  off
      logfile        ~/.msmtp.log

      # Gmail
      account        preston
      host           smtp.gmail.com
      port           587
      from           ret2pop@gmail.com
      user           ret2pop@gmail.com
      passwordeval   "pass Mail"


      # Set a default account
      account default : preston
    '';
    };

    bash = {
      enable = true;
    };

    git = {
      enable = true;
      # CHANGEME name and email
      userName = "Preston Pan";
      userEmail = "ret2pop@gmail.com";
      signing = {
        # CHANGEME GIT SIGNING KEY
        key = "AEC273BF75B6F54D81343A1AC1FE6CED393AE6C1";
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
      };

      aliases = {
        co = "checkout";
        c = "commit";
        a = "add";
        s = "switch";
        b = "branch";
      };
    };
    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
        "swww-daemon --format xrgb"
        "swww img ${wallpapers}/imagination.png"
        "fcitx5-remote -r"
        "fcitx5 -d --replace"
        "fcitx5-remote -r"
        "emacs"
        "firefox"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
      blurls = [
        "waybar"
      ];
      monitor = [
        "Unknown-1,disable"
      ];
      windowrule = [
        "workspace 1, ^(.*emacs.*)$"
        "workspace 2, ^(.*firefox.*)$"
        "workspace 2, ^(.*Tor Browser.*)$"
        "workspace 2, ^(.*Chromium-browser.*)$"
        "workspace 2, ^(.*chromium.*)$"
        "workspace 3, ^(.*discord.*)$"
        "workspace 3, ^(.*vesktop.*)$"
        "workspace 3, ^(.*fluffychat.*)$"
        "workspace 3, ^(.*element-desktop.*)$"
        "workspace 4, ^(.*qpwgraph.*)$"
        "workspace 5, ^(.*Monero.*)$"
        "workspace 5, ^(.*org\.bitcoin\..*)$"
        "workspace 5, ^(.*Bitcoin Core - preston.*)$"
        "workspace 5, ^(.*org\.getmonero\..*)$"
        "workspace 5, ^(.*Monero - preston.*)$"
        "workspace 5, ^(.*electrum.*)$"
        "pseudo,fcitx"
      ];
      bind = [
        "$mod, F, exec, firefox"
        "$mod, T, exec, tor-browser"
        "$mod, Return, exec, kitty"
        "$mod, E, exec, emacs"
        "$mod, B, exec, bitcoin-qt"
        "$mod, M, exec, monero-wallet-gui"
        "$mod, V, exec, vesktop"
        "$mod, D, exec, wofi --show run"
        "$mod, P, exec, bash ${scripts}/powermenu.sh"
        "$mod, Q, killactive"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        ", XF86AudioPlay, exec, mpc toggle"
        ", Print, exec, grim"
      ]
      ++ (
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
            in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
          )
          10)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioNext, exec, mpc next"
        ", XF86AudioPrev, exec, mpc prev"
        ", XF86MonBrightnessUp , exec, xbacklight -inc 10"
        ", XF86MonBrightnessDown, exec, xbacklight -dec 10"
      ];
      decoration = {
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
        rounding = 5;
      };
      input = {
        kb_options = "caps:swapescape";
        repeat_delay = 300;
        repeat_rate = 50;
        natural_scroll = true;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
        };
      };
      cursor = {
        no_hardware_cursors = true;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };

  gtk = {
    enable = true;
    theme = null;
    iconTheme = null;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-rime
    ];
  };

  fonts.fontconfig.enable = true;
  nixpkgs.config.cudaSupport = false;
}

