{ config, pkgs, ... }:
{
  home.username = "preston";
  home.homeDirectory = "/home/preston";
  home.packages = [
    pkgs.vim
    pkgs.git
    pkgs.curl
    pkgs.wget
    pkgs.neofetch
    pkgs.cowsay
    pkgs.kitty
    pkgs.ffmpeg
    pkgs.hyprland
    pkgs.grim
    pkgs.acpilight
    pkgs.light
    pkgs.gnupg
    pkgs.pass
    pkgs.fira-code
    pkgs.croc
    pkgs.nixpkgs-fmt
    pkgs.mu
    pkgs.rust-analyzer
    pkgs.rustc
    pkgs.cargo
    pkgs.rnix-lsp
    pkgs.clang
    pkgs.bear
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.gammastep
    pkgs.pinentry
    pkgs.texliveFull
    pkgs.helvum
    pkgs.xdg-utils
    pkgs.ncmpcpp
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.autobuild
    pkgs.rsync
    pkgs.pavucontrol
    pkgs.swww
    pkgs.fswebcam
    pkgs.nmap
    pkgs.mpc-cli
    pkgs.yt-dlp
    pkgs.mpv
    pkgs.python3
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    pkgs.ungoogled-chromium
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
      prompt = "";
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
      font_family = "Fira Code";
      font_size = 12;
      confirm_os_window_close = -1;
      background_opacity = "0.9";
    };
    extraConfig = ''
      # The basic colors
      foreground              #CDD6F4
      background              #1E1E2E
      selection_foreground    #1E1E2E
      selection_background    #F5E0DC

      # Cursor colors
      cursor                  #F5E0DC
      cursor_text_color       #1E1E2E

      # URL underline color when hovering with mouse
      url_color               #F5E0DC

      # Kitty window border colors
      active_border_color     #B4BEFE
      inactive_border_color   #6C7086
      bell_border_color       #F9E2AF

      # OS Window titlebar colors
      wayland_titlebar_color  #1E1E2E
      macos_titlebar_color    #1E1E2E

      # Tab bar colors
      active_tab_foreground   #11111B
      active_tab_background   #CBA6F7
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #181825
      tab_bar_background      #11111B

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1E1E2E
      mark1_background #B4BEFE
      mark2_foreground #1E1E2E
      mark2_background #CBA6F7
      mark3_foreground #1E1E2E
      mark3_background #74C7EC

      # The 16 terminal colors

      # black
      color0 #45475A
      color8 #585B70

      # red
      color1 #F38BA8
      color9 #F38BA8

      # green
      color2  #A6E3A1
      color10 #A6E3A1

      # yellow
      color3  #F9E2AF
      color11 #F9E2AF

      # blue
      color4  #89B4FA
      color12 #89B4FA

      # magenta
      color5  #F5C2E7
      color13 #F5C2E7

      # cyan
      color6  #94E2D5
      color14 #94E2D5

      # white
      color7  #BAC2DE
      color15 #A6ADC8
    '';
  };
  programs.firefox = {
    policies = {
      EnableTrackingProtection = true;
      OfferToSaveLogins = false;
    };
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
        ];
        extraConfig = ''
          //
          /* You may copy+paste this file and use it as it is.
           *
           * If you make changes to your about:config while the program is running, the
           * changes will be overwritten by the user.js when the application restarts.
           *
           * To make lasting changes to preferences, you will have to edit the user.js.
           */

          /****************************************************************************
           * Betterfox                                                                *
           * "Ad meliora"                                                             *
           * version: 122                                                             *
           * url: https://github.com/yokoffing/Betterfox                              *
          ****************************************************************************/

          /****************************************************************************
           * SECTION: FASTFOX                                                         *
          ****************************************************************************/
          /** GENERAL ***/
          user_pref("content.notify.interval", 100000);

          /** GFX ***/
          user_pref("gfx.canvas.accelerated.cache-items", 4096);
          user_pref("gfx.canvas.accelerated.cache-size", 512);
          user_pref("gfx.content.skia-font-cache-size", 20);

          /** DISK CACHE ***/
          user_pref("browser.cache.jsbc_compression_level", 3);

          /** MEDIA CACHE ***/
          user_pref("media.memory_cache_max_size", 65536);
          user_pref("media.cache_readahead_limit", 7200);
          user_pref("media.cache_resume_threshold", 3600);

          /** IMAGE CACHE ***/
          user_pref("image.mem.decode_bytes_at_a_time", 32768);

          /** NETWORK ***/
          user_pref("network.buffer.cache.size", 262144);
          user_pref("network.buffer.cache.count", 128);
          user_pref("network.http.max-connections", 1800);
          user_pref("network.http.max-persistent-connections-per-server", 10);
          user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
          user_pref("network.http.pacing.requests.enabled", false);
          user_pref("network.dnsCacheExpiration", 3600);
          user_pref("network.dns.max_high_priority_threads", 8);
          user_pref("network.ssl_tokens_cache_capacity", 10240);

          /** SPECULATIVE LOADING ***/
          user_pref("network.dns.disablePrefetch", true);
          user_pref("network.prefetch-next", false);
          user_pref("network.predictor.enabled", false);

          /** EXPERIMENTAL ***/
          user_pref("layout.css.grid-template-masonry-value.enabled", true);
          user_pref("dom.enable_web_task_scheduling", true);
          user_pref("layout.css.has-selector.enabled", true);
          user_pref("dom.security.sanitizer.enabled", true);

          /****************************************************************************
           * SECTION: SECUREFOX                                                       *
          ****************************************************************************/
          /** TRACKING PROTECTION ***/
          user_pref("browser.contentblocking.category", "strict");
          user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
          user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
          user_pref("network.cookie.sameSite.noneRequiresSecure", true);
          user_pref("browser.download.start_downloads_in_tmp_dir", true);
          user_pref("browser.helperApps.deleteTempFileOnExit", true);
          user_pref("browser.uitour.enabled", false);
          user_pref("privacy.globalprivacycontrol.enabled", true);

          /** OCSP & CERTS / HPKP ***/
          user_pref("security.OCSP.enabled", 0);
          user_pref("security.remote_settings.crlite_filters.enabled", true);
          user_pref("security.pki.crlite_mode", 2);

          /** SSL / TLS ***/
          user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
          user_pref("browser.xul.error_pages.expert_bad_cert", true);
          user_pref("security.tls.enable_0rtt_data", false);

          /** DISK AVOIDANCE ***/
          user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
          user_pref("browser.sessionstore.interval", 60000);

          /** SHUTDOWN & SANITIZING ***/
          /** L **/
          user_pref("privacy.history.custom", true);

          /** SEARCH / URL BAR ***/
          user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
          user_pref("browser.urlbar.update2.engineAliasRefresh", true);
          user_pref("browser.search.suggest.enabled", false);
          user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
          user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
          user_pref("browser.formfill.enable", false);
          user_pref("security.insecure_connection_text.enabled", true);
          user_pref("security.insecure_connection_text.pbmode.enabled", true);
          user_pref("network.IDN_show_punycode", true);

          /** HTTPS-FIRST POLICY ***/
          user_pref("dom.security.https_first", true);
          user_pref("dom.security.https_first_schemeless", true);

          /** PASSWORDS ***/
          user_pref("signon.formlessCapture.enabled", false);
          user_pref("signon.privateBrowsingCapture.enabled", false);
          user_pref("network.auth.subresource-http-auth-allow", 1);
          user_pref("editor.truncate_user_pastes", false);

          /** MIXED CONTENT + CROSS-SITE ***/
          user_pref("security.mixed_content.block_display_content", true);
          user_pref("security.mixed_content.upgrade_display_content", true);
          user_pref("security.mixed_content.upgrade_display_content.image", true);
          user_pref("pdfjs.enableScripting", false);
          user_pref("extensions.postDownloadThirdPartyPrompt", false);

          /** HEADERS / REFERERS ***/
          user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

          /** CONTAINERS ***/
          user_pref("privacy.userContext.ui.enabled", true);

          /** WEBRTC ***/
          user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
          user_pref("media.peerconnection.ice.default_address_only", true);

          /** SAFE BROWSING ***/
          user_pref("browser.safebrowsing.downloads.remote.enabled", false);

          /** MOZILLA ***/
          user_pref("permissions.default.desktop-notification", 2);
          user_pref("permissions.default.geo", 2);
          user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
          user_pref("permissions.manager.defaultsUrl", "");
          user_pref("webchannel.allowObject.urlWhitelist", "");

          /** TELEMETRY ***/
          user_pref("datareporting.policy.dataSubmissionEnabled", false);
          user_pref("datareporting.healthreport.uploadEnabled", false);
          user_pref("toolkit.telemetry.unified", false);
          user_pref("toolkit.telemetry.enabled", false);
          user_pref("toolkit.telemetry.server", "data:,");
          user_pref("toolkit.telemetry.archive.enabled", false);
          user_pref("toolkit.telemetry.newProfilePing.enabled", false);
          user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
          user_pref("toolkit.telemetry.updatePing.enabled", false);
          user_pref("toolkit.telemetry.bhrPing.enabled", false);
          user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
          user_pref("toolkit.telemetry.coverage.opt-out", true);
          user_pref("toolkit.coverage.opt-out", true);
          user_pref("toolkit.coverage.endpoint.base", "");
          user_pref("browser.ping-centre.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.telemetry", false);

          /** EXPERIMENTS ***/
          user_pref("app.shield.optoutstudies.enabled", false);
          user_pref("app.normandy.enabled", false);
          user_pref("app.normandy.api_url", "");

          /** CRASH REPORTS ***/
          user_pref("breakpad.reportURL", "");
          user_pref("browser.tabs.crashReporting.sendReport", false);
          user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

          /** DETECTION ***/
          user_pref("captivedetect.canonicalURL", "");
          user_pref("network.captive-portal-service.enabled", false);
          user_pref("network.connectivity-service.enabled", false);

          /****************************************************************************
           * SECTION: PESKYFOX                                                        *
          ****************************************************************************/
          /** MOZILLA UI ***/
          /** format on save please? **/
          user_pref("browser.privatebrowsing.vpnpromourl", "");
          user_pref("extensions.getAddons.showPane", false);
          user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
          user_pref("browser.discovery.enabled", false);
          user_pref("browser.shell.checkDefaultBrowser", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
          user_pref("browser.preferences.moreFromMozilla", false);
          user_pref("browser.tabs.tabmanager.enabled", false);
          user_pref("browser.aboutConfig.showWarning", false);
          user_pref("browser.aboutwelcome.enabled", false);

          /** THEME ADJUSTMENTS ***/
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.display.focus_ring_on_anything", true);
          user_pref("browser.display.focus_ring_style", 0);
          user_pref("browser.display.focus_ring_width", 0);
          user_pref("layout.css.prefers-color-scheme.content-override", 2);
          user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

          /** COOKIE BANNER HANDLING ***/
          user_pref("cookiebanners.service.mode", 1);
          user_pref("cookiebanners.service.mode.privateBrowsing", 1);

          /** FULLSCREEN NOTICE ***/
          user_pref("full-screen-api.transition-duration.enter", "0 0");
          user_pref("full-screen-api.transition-duration.leave", "0 0");
          user_pref("full-screen-api.warning.delay", -1);
          user_pref("full-screen-api.warning.timeout", 0);

          /** URL BAR ***/
          user_pref("browser.urlbar.suggest.calculator", true);
          user_pref("browser.urlbar.unitConversion.enabled", true);
          user_pref("browser.urlbar.trending.featureGate", false);

          /** NEW TAB PAGE ***/
          user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
          user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

          /** POCKET ***/
          user_pref("extensions.pocket.enabled", false);

          /** DOWNLOADS ***/
          user_pref("browser.download.always_ask_before_handling_new_types", true);
          user_pref("browser.download.manager.addToRecentDocs", false);

          /** PDF ***/
          user_pref("browser.download.open_pdf_attachments_inline", true);

          /** TAB BEHAVIOR ***/
          user_pref("browser.bookmarks.openInTabClosesMenu", false);
          user_pref("browser.menu.showViewImageInfo", true);
          user_pref("findbar.highlightAll", true);
          user_pref("layout.word_select.eat_space_to_next_word", false);
        '';
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
    shellAliases = {
      c = "clear";
      g = "git";
      v = "vim";
      h = "Hyprland";
    };
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
      epkgs.circe
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
      logfile        ~/.msmtp.log

      # Gmail
      account        preston
      host           mail.nullring.xyz
      port           587
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

  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      g = "https://www.google.com/search?hl=en&amp;q={}";
      DEFAULT = "https://www.google.com/search?hl=en&amp;q={}";
    };
    settings = { };
    extraConfig = ''
      import os
      from urllib.request import urlopen

      if not os.path.exists(config.configdir / "theme.py"):
          theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
          with urlopen(theme) as themehtml:
              with open(config.configdir / "theme.py", "a") as file:
                  file.writelines(themehtml.read().decode("utf-8"))

      if os.path.exists(config.configdir / "theme.py"):
          import theme
          theme.setup(c, 'mocha', True)
    '';
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
        "swww init"
        "swww img /home/preston/wallpapers/bigrobot.png"
      ];
      blurls = [
        "waybar"
      ];
      bind = [
        "$mod, F, exec, firefox"
        "$mod, Return, exec, kitty"
        "$mod, E, exec, emacs"
        "$mod, v, exec, vencorddesktop"
        "$mod, d, exec, wofi --show run"
        ", Print, exec, grimblast copy area"
        "$mod, Q, killactive"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
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
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioPlay, exec, mpc toggle"
        ", XF86AudioNext, exec, mpc next"
        ", XF86AudioPrev, exec, mpc prev"
      ];
    };
  };
  programs.home-manager.enable = true;
}

