{ pkgs, inputs, config, lib, ...}:

let
  palette=config.colorScheme.palette;
  inherit (import ../../options.nix) appLauncher;
in lib.mkIf (appLauncher == "anyrun") {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        # randr
        #  rink
        shell
        symbols
        #  translate
      ];

      width.fraction = 0.3;
      x.fraction = 0.5;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    # custom css for anyrun, based on catppuccin-mocha
    extraCss = ''
      @define-color bg-col #${palette.base00};
      @define-color bg-col-light #${palette.base0C};
      @define-color border-col #${palette.base00};
      @define-color selected-col #${palette.base0C};
      @define-color fg-col #${palette.base05};
      @define-color fg-col2 #${palette.base01};

      * {
        transition: 200ms ease;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 1.3rem;
      }

      #window {
        background: transparent;
      }

      #plugin,
      #main {
        border: 3px solid @border-col;
        color: @fg-col;
        background-color: @bg-col;
      }
      /* anyrun's input window - Text */
      #entry {
        color: @fg-col;
        background-color: @bg-col;
      }

      /* anyrun's ouput matches entries - Base */
      #match {
        color: @fg-col;
        background: @bg-col;
      }

      /* anyrun's selected entry - Red */
      #match:selected {
        color: @fg-col2;
        background: @selected-col;
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #entry, #plugin:hover {
        border-radius: 16px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid @border-col;
        border-radius: 15px;
        padding: 5px;
      }
    '';
  };
}
