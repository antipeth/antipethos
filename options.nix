# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  # THINGS YOU NEED TO CHANGE
  username = "antipeth";
  hostname = "antipeth";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/antipethos";
  waybarStyle = "slickbar-num"; # simplebar, slickbar, slickbar-num, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  gitUsername = "antipeth";
  gitEmail = "test@test.com";
  theme = "tokyo-night-storm";
  slickbar = if waybarStyle == "slickbar" then true else false;
  slickbar-num = if waybarStyle == "slickbar-num" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  browser = "brave";
  wallpaperGit = "https://github.com/antipeth/mywallpaper.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.antipethos-previous";
  flakeBackup = "${userHome}/.antipethos-backup";
  terminal = "kitty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = false;
  theLocale = "zh_CN.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "";
  theKBDVariant = "";
  theLCVariables = "zh_CN.UTF-8";
  theTimezone = "Asia/Shanghai";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "xanmod"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "wayland"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "intel";
  gpuType = "nvidia";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  distrobox = false;
  flatpak = false;
  kdenlive = true;
  blender = true;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = false;
  kitty = true;

  # Enable Python & PyCharm
  python = false;
  
  # Enable SyncThing
  syncthing = false;

}
