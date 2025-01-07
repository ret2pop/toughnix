{
  # set your host name.
  hostName = "continuity-dell";

  # username used for unix username as well as msmtp configuration name.
  userName = "preston";

  # your full name
  fullName = "Preston Pan";

  # Create a new gpg key for this system or import your keys from another system
  gpgKey = "AEC273BF75B6F54D81343A1AC1FE6CED393AE6C1";

  # If you're not forking my website, this value doesn't matter
  websiteLocation = "root@nullring.xyz:/usr/share/nginx/ret2pop/";

  # GPG encrypted password repository (leave as default value and change later if you don't have one)
  passwordRepo = "https://git.nullring.xyz/passwords.git";

  # email used for `From` and also as your login email.
  email = "ret2pop@gmail.com";

  # IMAPS server. Must be encrypted.
  imapsServer = "imap.gmail.com";

  # SMTPS server. Must be encrypted.
  smtpsServer = "smtp.gmail.com";

  # Change to your timezone
  timeZone = "America/Vancouver";

  # After rebooting, use the command `hyprctl monitors` in order to check which monitor
  # you are using. This is so that waybar knows which monitors to appear in.
  monitors = [
    "HDMI-A-1"
    "eDP-1"
    "DP-2"
    "DP-3"
  ];

  # enable video drivers based on your system.
  # Example:
  # videoDrivers = [
  #   "nvidia"
  #   "amdgpu"
  # ]
  videoDrivers = [
  ];

  # use false if this is your first install of continuity.
  # See https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  # for more information.
  secureBoot = true;
}
