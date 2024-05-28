{ config, lib, nixpkgs, pkgs, wallpapers, scripts, ... }:
{
  home.enableNixpkgsReleaseCheck = false;
  home.username = "preston";
  home.homeDirectory = "/home/preston";
  home.packages = with pkgs; [
    vim
    git
    curl
    wget
    pfetch
    cowsay
    ffmpeg
    grim
    acpilight
    light
    gnupg
    (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb]))
    passExtensions.pass-otp
    fira-code
    croc
    mu
    rust-analyzer
    cargo
    clang
    bear
    gnumake
    clang-tools
    pinentry
    texliveFull
    helvum
    xdg-utils
    noto-fonts
    noto-fonts-cjk
    autobuild
    rsync
    pavucontrol
    swww
    fswebcam
    nmap
    mpc-cli
    python3
    ghostscript
    hyprpaper
    pipes
    cmatrix
    inkscape
    nixfmt-rfc-style
    podman-desktop
    monero-gui
    electrum
    fluffychat
    iamb
    veracrypt
    imagemagick
    tor-browser
    qsynth
    poetry
    vesktop
    nixd
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
#    (discord.override {
#      withOpenASAR = true;
#      withVencord = true;
#    })
    python311Packages.python-lsp-server
  ];
  fonts.fontconfig.enable = true;
  xsession.enable = true;
  home.stateVersion = "23.11";

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "emacs";
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    temperature.day = 5000;
    temperature.night = 3000;
    settings = {
      adjustment-method = "wayland";
    };
  };
  services.mpd = {
    enable = true;
    dbFile = "/home/preston/.config/mpd/db";
    dataDir = "/home/preston/.config/mpd/";
    network.port = 6600;
    musicDirectory = "/home/preston/music";
    playlistDirectory = "/home/preston/.config/mpd/playlists";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire output"
      }
    '';
  };

  services.pantalaimon = {
    enable = true;
    settings = {
      Default = {
        LogLevel = "Debug";
        SSL = true;
      };
      local-matrix = {
        Homeserver = "https://social.nullring.xyz";
        ListenAddress = "0.0.0.0";
        ListenPort = 8008;
        SSL = false;
        UseKeyring = false;
        IgnoreVerification = true;
      };
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock-origin lite
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
    ];
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
       show_banner: false,
       completions: {
       case_sensitive: false # case-sensitive completions
       quick: true    # set to false to prevent auto-selecting completions
       partial: true    # set to false to prevent partial filling of the prompt
       algorithm: "fuzzy"    # prefix or fuzzy
       external: {
       # set to false to prevent nushell looking into $env.PATH to find more suggestions
           enable: true 
       # set to lower can improve completion performance at the cost of omitting some options
           max_results: 100 
           completer: $carapace_completer # check 'carapace_completer' 
         }
       }
      } 
      $env.PATH = ($env.PATH | 
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )
    '';
    shellAliases = {
      c = "clear";
      g = "git";
      v = "vim";
      h = "Hyprland";
      r = "gammastep -O 3000";
      ns = "nix-shell";
      n = "nix";
      nf = "nix flake";
    };
  };
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      sub-langs = "all";
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
    };
  };

  programs.wofi = {
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

  programs.kitty = {
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

  programs.firefox = {
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
          content.notify.interval = 100000;
          gfx.canvas.accelerated.cache-items = 4096;
          gfx.canvas.accelerated.cache-size = 512;
          gfx.content.skia-font-cache-size = 20;
          browser.cache.jsbc_compression_level = 3;
          media.memory_cache_max_size = 65536;
          media.cache_readahead_limit = 7200;
          media.cache_resume_threshold = 3600;
          image.mem.decode_bytes_at_a_time = 32768;
          network.buffer.cache.size = 262144;
          network.buffer.cache.count = 128;
          network.http.max-connections = 1800;
          network.http.max-persistent-connections-per-server = 10;
          network.http.max-urgent-start-excessive-connections-per-host = 5;
          network.http.pacing.requests.enabled = false;
          network.dnsCacheExpiration = 3600;
          network.dns.max_high_priority_threads = 8;
          network.ssl_tokens_cache_capacity = 10240;
          network.dns.disablePrefetch = true;
          network.prefetch-next = false;
          network.predictor.enabled = false;
          layout.css.grid-template-masonry-value.enabled = true;
          dom.enable_web_task_scheduling = true;
          layout.css.has-selector.enabled = true;
          dom.security.sanitizer.enabled = true;
          browser.contentblocking.category = "strict";
          urlclassifier.trackingSkipURLs = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          urlclassifier.features.socialtracking.skipURLs = "*.instagram.com, *.twitter.com, *.twimg.com";
          network.cookie.sameSite.noneRequiresSecure = true;
          browser.download.start_downloads_in_tmp_dir = true;
          browser.helperApps.deleteTempFileOnExit = true;
          browser.uitour.enabled = false;
          privacy.globalprivacycontrol.enabled = true;
          security.OCSP.enabled = 0;
          security.remote_settings.crlite_filters.enabled = true;
          security.pki.crlite_mode = 2;
          security.ssl.treat_unsafe_negotiation_as_broken = true;
          browser.xul.error_pages.expert_bad_cert = true;
          security.tls.enable_0rtt_data = false;
          browser.privatebrowsing.forceMediaMemoryCache = true;
          browser.sessionstore.interval = 60000;
          privacy.history.custom = true;
          browser.search.separatePrivateDefault.ui.enabled = true;
          browser.urlbar.update2.engineAliasRefresh = true;
          browser.search.suggest.enabled = false;
          browser.urlbar.suggest.quicksuggest.sponsored = false;
          browser.urlbar.suggest.quicksuggest.nonsponsored = false;
          browser.formfill.enable = false;
          security.insecure_connection_text.enabled = true;
          security.insecure_connection_text.pbmode.enabled = true;
          network.IDN_show_punycode = true;
          dom.security.https_first = true;
          dom.security.https_first_schemeless = true;
          signon.formlessCapture.enabled = false;
          signon.privateBrowsingCapture.enabled = false;
          network.auth.subresource-http-auth-allow = 1;
          editor.truncate_user_pastes = false;
          security.mixed_content.block_display_content = true;
          security.mixed_content.upgrade_display_content = true;
          pdfjs.enableScripting = false;
          extensions.postDownloadThirdPartyPrompt = false;
          network.http.referer.XOriginTrimmingPolicy = 2;
          privacy.userContext.ui.enabled = true;
          media.peerconnection.ice.proxy_only_if_behind_proxy = true;
          media.peerconnection.ice.default_address_only = true;
          browser.safebrowsing.downloads.remote.enabled = false;
          permissions.default.desktop-notification = 2;
          permissions.default.geo = 2;
          geo.provider.network.url = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          permissions.manager.defaultsUrl = "";
          webchannel.allowObject.urlWhitelist = "";
          datareporting.policy.dataSubmissionEnabled = false;
          datareporting.healthreport.uploadEnabled = false;
          toolkit.telemetry.unified = false;
          toolkit.telemetry.enabled = false;
          toolkit.telemetry.server = "data:,";
          toolkit.telemetry.archive.enabled = false;
          toolkit.telemetry.newProfilePing.enabled = false;
          toolkit.telemetry.shutdownPingSender.enabled = false;
          toolkit.telemetry.updatePing.enabled = false;
          toolkit.telemetry.bhrPing.enabled = false;
          toolkit.telemetry.firstShutdownPing.enabled = false;
          toolkit.telemetry.coverage.opt-out = true;
          toolkit.coverage.opt-out = true;
          toolkit.coverage.endpoint.base = "";
          browser.ping-centre.telemetry = false;
          browser.newtabpage.activity-stream.feeds.telemetry = false;
          browser.newtabpage.activity-stream.telemetry = false;
          app.shield.optoutstudies.enabled = false;
          app.normandy.enabled = false;
          app.normandy.api_url = "";
          breakpad.reportURL = "";
          browser.tabs.crashReporting.sendReport = false;
          browser.crashReports.unsubmittedCheck.autoSubmit2 = false;
          captivedetect.canonicalURL = "";
          network.captive-portal-service.enabled = false;
          network.connectivity-service.enabled = false;
          browser.privatebrowsing.vpnpromourl = "";
          extensions.getAddons.showPane = false;
          extensions.htmlaboutaddons.recommendations.enabled = false;
          browser.discovery.enabled = false;
          browser.shell.checkDefaultBrowser = false;
          browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons = false;
          browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features = false;
          browser.preferences.moreFromMozilla = false;
          browser.tabs.tabmanager.enabled = false;
          browser.aboutConfig.showWarning = false;
          browser.aboutwelcome.enabled = false;
          toolkit.legacyUserProfileCustomizations.stylesheets = true;
          browser.compactmode.show = true;
          browser.display.focus_ring_on_anything = true;
          browser.display.focus_ring_style = 0;
          browser.display.focus_ring_width = 0;
          layout.css.prefers-color-scheme.content-override = 2;
          browser.privateWindowSeparation.enabled = false;
          cookiebanners.service.mode = 1;
          full-screen-api.transition-duration.enter = "0 0";
          full-screen-api.transition-duration.leave = "0 0";
          full-screen-api.warning.delay = -1;
          full-screen-api.warning.timeout = 0;
          browser.urlbar.suggest.calculator = true;
          browser.urlbar.unitConversion.enabled = true;
          browser.urlbar.trending.featureGate = false;
          browser.newtabpage.activity-stream.feeds.topsites = false;
          browser.newtabpage.activity-stream.feeds.section.topstories = false;
          extensions.pocket.enabled = false;
          browser.download.always_ask_before_handling_new_types = true;
          browser.download.manager.addToRecentDocs = false;
          browser.download.open_pdf_attachments_inline = true;
          browser.bookmarks.openInTabClosesMenu = false;
          browser.menu.showViewImageInfo = true;
          findbar.highlightAll = true;
          layout.word_select.eat_space_to_next_word = false;
        };
      };
    };
  };
  programs.waybar = {
    enable = true;
    style = ''
      * {
          border: none;
          border-radius: 0px;
          /*font-family: Fira Code, Iosevka Nerd Font, Noto Sans CJK;*/
          font-family: Iosevka, FontAwesome, Noto Sans CJK;
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
        height = 30;

        output = [
          "LVDS-1"
        ];

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "battery" "clock" ];

        battery = {
          bat = "BAT0";
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        clock = {
          format = "{:%a %d, %b %H:%M}";
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    localVariables = {
      EDITOR = "emacsclient -n --alternate-editor=vim";
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
      h = "Hyprland";
      r = "gammastep -O 3000";
    };
    loginExtra = ''
if [ "$(tty)" = "/dev/tty1" ];then
  exec Hyprland
fi
    '';
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraConfig = ''
      (setq debug-on-error t)
      (org-babel-load-file
        (expand-file-name "~/org/website/config/emacs.org"))'';
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.emms
      epkgs.magit
      epkgs.vterm
      epkgs.auctex
      epkgs.use-package
      epkgs.evil
      epkgs.evil-collection
      epkgs.org-roam
      epkgs.org-journal
      epkgs.general
      epkgs.which-key
      epkgs.gruvbox-theme
      epkgs.elfeed
      epkgs.elfeed-org
      epkgs.doom-modeline
      epkgs.dashboard
      epkgs.org-superstar
      epkgs.projectile
      epkgs.lsp-mode
      epkgs.ivy
      epkgs.lsp-ivy
      epkgs.all-the-icons
      epkgs.page-break-lines
      epkgs.counsel
      epkgs.mu4e
      epkgs.yasnippet
      epkgs.company
      epkgs.pinentry
      epkgs.pdf-tools
      epkgs.ivy-pass
      epkgs.magit-delta
      epkgs.sudo-edit
      epkgs.evil-commentary
      epkgs.evil-org
      epkgs.catppuccin-theme
      epkgs.htmlize
      epkgs.web-mode
      epkgs.emmet-mode
      epkgs.ement
      epkgs.rustic
      epkgs.chatgpt-shell
      epkgs.ellama
      epkgs.latex-preview-pane
      epkgs.treemacs
      epkgs.treesit-auto
      epkgs.gptel
      epkgs.elpher
      epkgs.lyrics-fetcher
      epkgs.password-store
    ];
  };

  programs.mbsync = {
    enable = true;
    extraConfig = ''
      IMAPAccount prestonpan
      Host mail.nullring.xyz
      User preston
      PassCmd "pass Mail"
      Port 993
      SSLType IMAPS
      AuthMechs *
      CertificateFile /etc/ssl/certs/ca-certificates.crt

      IMAPStore prestonpan-remote
      Account prestonpan

      MaildirStore prestonpan-local
      Path ~/email/mbsyncmail/
      Inbox ~/email/mbsyncmail/INBOX
      SubFolders Verbatim

      Channel prestonpan
      Far :prestonpan-remote:
      Near :prestonpan-local:
      Patterns *
      Create Near
      Sync All
      Expunge None
      SyncState *
    '';
  };

  programs.msmtp = {
    enable = true;
    extraConfig = ''
      # Set default values for all following accounts.
      defaults
      auth           on
      tls            on
      tls_trust_file /etc/ssl/certs/ca-certificates.crt
      tls_certcheck  off
      logfile        ~/.msmtp.log

      # Gmail
      account        preston
      host           mail.nullring.xyz
      port           465
      from           preston@nullring.xyz
      user           preston
      passwordeval   "pass Mail"


      # Set a default account
      account default : preston
    '';
  };

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Preston Pan";
    userEmail = "preston@nullring.xyz";
    signing.key = "2B749D1FB976E81613858E490290504780B30E20";
    signing.signByDefault = true;
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
      ];
      blurls = [
        "waybar"
      ];
      windowrule = [
        "workspace 1, ^(.*emacs.*)$"
        "workspace 2, ^(.*firefox.*)$"
        "workspace 2, ^(.*Chromium-browser.*)$"
        "workspace 2, ^(.*chromium.*)$"
        "workspace 3, ^(.*discord.*)$"
        "workspace 3, ^(.*vesktop.*)$"
        "workspace 3, ^(.*fluffychat.*)$"
        "workspace 3, ^(.*element-desktop.*)$"
        "workspace 5, ^(.*Monero.*)$"
        "workspace 5, ^(.*electrum.*)$"
        "pseudo,fcitx"
      ];
      bind = [
        "$mod, F, exec, firefox"
        "$mod, W, exec, chromium-browser"
        "$mod, Return, exec, kitty"
        "$mod, E, exec, emacs"
        "$mod, B, exec, electrum"
        "$mod, M, exec, monero-wallet-gui"
        "$mod, V, exec, vesktop"
        "$mod, T, exec, veracrypt"
        "$mod, C, exec, fluffychat"
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
        ", XF86MonBrightnessUp , exec, light -A 10"
        ", XF86MonBrightnessDown, exec, light -U 10"
      ];
      decoration = {
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
        rounding = 5;
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };
      input = {
        kb_options = "caps:swapescape";
        repeat_delay = 300;
        repeat_rate = 50;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-rime
    ];
  };

  programs.home-manager.enable = true;
}

