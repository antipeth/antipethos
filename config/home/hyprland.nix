{ pkgs, config, lib, inputs, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../options.nix) 
    browser cpuType gpuType
    wallpaperDir borderAnim
    theKBDLayout terminal
    theSecondKBDLayout
    theKBDVariant sdl-videodriver 
    appLauncher;

in with lib; {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [
      # hyprplugins.hyprtrails
      # inputs.hy3.packages.x86_64-linux.hy3
    ];
    extraConfig = let
      mainMod = "SUPER";
    in concatStrings [ ''

      monitor=HDMI-A-1,3840x2160@60,0x0 ,1
      monitor=eDP-2,2560x1440@165,auto,1,mirror,HDMI-A-1

      #monitor=eDP-2,2560x1440@165,0x0,1
      #monitor=HDMI-A-1,3840x2160@60,3840x0 ,1
      #monitor=,preferred,auto,1
      # windowrule = float, ^(steam)$
      # windowrule = size 1080 900, ^(steam)$
      # windowrule = center, ^(steam)$
      general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(${theme.base0C}ff) rgba(${theme.base0D}ff) rgba(${theme.base0B}ff) rgba(${theme.base0E}ff) 45deg
        col.inactive_border = rgba(${theme.base00}cc) rgba(${theme.base01}cc) 45deg
        layout = hy3 
        # layout = dwindle
        resize_on_border = true
      }

      input {
        kb_layout = ${theKBDLayout}, ${theSecondKBDLayout}
        kb_options=caps:escape
        follow_mouse = 1
        touchpad {
          natural_scroll = false
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }
      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland
      env = CLUTTER_BACKEND, wayland
      env = SDL_VIDEODRIVER, ${sdl-videodriver}
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = MOZ_ENABLE_WAYLAND, 1
      env = GTK_IM_MODULE, fcitx
      env = XMODIFIERS, @im=fcitx
      env = QT_IM_MODULE, fcitx
      env = SDL_IM_MODULE, fcitx

      ${if cpuType == "vm" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
        env = WLR_RENDERER_ALLOW_SOFTWARE,1
      '' else ''
      ''}
      ${if gpuType == "nvidia" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
      '' else ''
      ''}
      # custom env
      env = EDITOR, nvim

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }
      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = false
      }
      animations {
        enabled = yes

        bezier = wind, 0.05, 0.7, 0.1, 1
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        ${if borderAnim == true then ''
          animation = borderangle, 1, 30, liner, loop
        '' else ''
        ''}
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind

      }
      decoration {

        rounding = 10
        drop_shadow = false
        blur {
            enabled = true
            size = 5
            passes = 3
            new_optimizations = on
            ignore_opacity = on
        }
      }
      plugin {
      #  hyprtrails {
      #    color = rgba(${theme.base0A}ff)
      #  }
      }

      exec-once = $POLKIT_BIN
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swww init
      exec-once = waybar
      exec-once = swaync
      exec-once = wallsetter
      exec-once = nm-applet --indicator
      exec-once = swayidle -w timeout 720 'swaylock -f' timeout 800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'

      exec-once = copyq

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      master {
        new_is_master = true
      }

      bind = ${mainMod}, Q, killactive,
      bind = ${mainMod}, W, exec, brave
      bind = ${mainMod}, RETURN, exec, ${terminal}
      bind = ${mainMod}, SPACE, exec, ${appLauncher}-launcher
      bind = ${mainMod} , y, exec, ${terminal} -e yazi
      bind = ${mainMod} , V, exec, ${terminal} -e nvim
      bind = ${mainMod} , C, exec, copyq toggle
      bind = ${mainMod} , M, exec, betterbird
      bind = ${mainMod} , N, exec, anytype
      bind = ${mainMod} SHIFT, F, togglefloating,
      bind = ${mainMod}, F, fullscreen,
      bind = ${mainMod}, X, exec, swaylock

      bind = , XF86MonBrightnessUp, exec, changebrightness up
      bind = , XF86MonBrightnessDown, exec, changebrightness down
      bind = , XF86AudioPrev, exec, playerctl prev
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioRaiseVolume, exec, changevolume up
      bind = , XF86AudioLowerVolume, exec, changevolume down
      bind = , XF86AudioMute, exec, changevolume mute

      # Screenshots
      bind = ${mainMod} SHIFT, S, exec, screenshootin

      # Move focus with mainMod + arrow keys
      bind = ${mainMod}, h, movefocus, l
      bind = ${mainMod}, l, movefocus, r
      bind = ${mainMod}, k, movefocus, u
      bind = ${mainMod}, j, movefocus, d
      bind = ${mainMod}, left, movefocus, l
      bind = ${mainMod}, down, movefocus, d
      bind = ${mainMod}, up, movefocus, u
      bind = ${mainMod}, right, movefocus, r

      # Switch workspaces with mainMod + [0-9]
      bind = ${mainMod}, 1, workspace, 1
      bind = ${mainMod}, 2, workspace, 2
      bind = ${mainMod}, 3, workspace, 3
      bind = ${mainMod}, 4, workspace, 4
      bind = ${mainMod}, 5, workspace, 5
      bind = ${mainMod}, 6, workspace, 6
      bind = ${mainMod}, 7, workspace, 7
      bind = ${mainMod}, 8, workspace, 8
      bind = ${mainMod}, 9, workspace, 9
      bind = ${mainMod}, 0, workspace, 10
      bind = ${mainMod}, F1, workspace, 11
      bind = ${mainMod}, F2, workspace, 12
      bind = ${mainMod}, F3, workspace, 13
      bind = ${mainMod}, F4, workspace, 14
      bind = ${mainMod}, F5, workspace, 15
      bind = ${mainMod}, F6, workspace, 16
      bind = ${mainMod}, F7, workspace, 17
      bind = ${mainMod}, F8, workspace, 18
      bind = ${mainMod}, F9, workspace, 19
      bind = ${mainMod}, F0, workspace, 20

      # Switch between most recent workspace
      bind = ${mainMod}, TAB, workspace, previous

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = ${mainMod} SHIFT, 1, movetoworkspace, 1
      bind = ${mainMod} SHIFT, 2, movetoworkspace, 2
      bind = ${mainMod} SHIFT, 3, movetoworkspace, 3
      bind = ${mainMod} SHIFT, 4, movetoworkspace, 4
      bind = ${mainMod} SHIFT, 5, movetoworkspace, 5
      bind = ${mainMod} SHIFT, 6, movetoworkspace, 6
      bind = ${mainMod} SHIFT, 7, movetoworkspace, 7
      bind = ${mainMod} SHIFT, 8, movetoworkspace, 8
      bind = ${mainMod} SHIFT, 9, movetoworkspace, 9
      bind = ${mainMod} SHIFT, 0, movetoworkspace, 10
      bind = ${mainMod}+SHIFT, F1, movetoworkspace, 11
      bind = ${mainMod}+SHIFT, F2, movetoworkspace, 12
      bind = ${mainMod}+SHIFT, F3, movetoworkspace, 13
      bind = ${mainMod}+SHIFT, F4, movetoworkspace, 14
      bind = ${mainMod}+SHIFT, F5, movetoworkspace, 15
      bind = ${mainMod}+SHIFT, F6, movetoworkspace, 16
      bind = ${mainMod}+SHIFT, F7, movetoworkspace, 17
      bind = ${mainMod}+SHIFT, F8, movetoworkspace, 18
      bind = ${mainMod}+SHIFT, F9, movetoworkspace, 19
      bind = ${mainMod}+SHIFT, F10,movetoworkspace, 20

      # Scroll through existing workspaces with mainMod + scroll
      bind = ${mainMod}, mouse_down, workspace, e+1
      bind = ${mainMod}, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = ${mainMod}, mouse:272, movewindow
      bindm = ${mainMod}, mouse:273, resizewindow
  '' ];
  };
}
