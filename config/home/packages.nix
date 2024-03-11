{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}" libvirt swww grim slurp kitty 
    swaynotificationcenter rofi-wayland imv transmission-gtk 
    audacity pavucontrol tree 
    font-awesome swayidle swaylock firefox-devedition
    betterbird-unwrapped brave nodejs rustc cargo jdk17 python3 go lldb rust-analyzer 
    vscode-extensions.vadimcn.vscode-lldb.adapter anytype bitwarden vscode
    telegram-desktop element-desktop libreoffice marktext keepassxc maven
    
    discord obs-studio gnome.file-rollerimv mpv element-desktop gimp 
    
    
# nodejs  rustc cargo are needed by nvim plugins
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    # (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    # (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
