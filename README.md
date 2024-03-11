<div align="center">

## AntipethOS 🟰 My ❄️ NixOS Configs

AntipethOS is a folk from [https://gitlab.com/Zaney/zaneyos](https://gitlab.com/Zaney/zaneyos) . This includes my wallpaper, scripts, applications, config files, and more.

<img align="center" width="80%" src="https://github.com/antipeth/antipethos/blob/main/config/home/files/demo/desktop.png" />

<img align="center" width="80%" src="https://github.com/antipeth/antipethos/blob/main/config/home/files/demo/apps.png" />


</div>

#### 🍖 Requirements
- You must be running on NixOS.
- Must have installed using GPT & UEFI.
- Change settings by manually editing options.nix file.


#### 📦 How To Install Packages?
- You can search the [Nix Packages](https://search.nixos.org/packages?) & [Options](https://search.nixos.org/options?) pages for what a package may be named or if it has options available that take care of configuration hurdles you may face.
- To add a package there are the packages.nix files located in config/system and config/home folders. One is for programs available system wide and the other for your users environment only.

### ⬇️ Install


#### 🦽 Manual:

Run this command to ensure Git & Vim are installed:

```
nix-shell -p git vim
```

Clone this repo & enter it:

```
git clone https://github.com/antipethos/antipethos.git
cd zaneyos
```

- *You should stay in this folder for the rest of the install*

**🪧🪧🪧 Edit options.nix 🪧🪧🪧**

Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hardware.nix
```

Run this to enable flakes and install the flake replacing hostname with whatever you put in the options.nix file:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#hostname
```

This Flake's user will have the password be set for them as *password*. If you want to change it run a command replacing password with whatever you want to be your password. You then need to copy the output that it gives you like below into your hashedPassword in the system.nix file.

```
  mkpasswd -m sha-512 password

$6$YdPBODxytqUWXCYL$AHW1U9C6Qqkf6PZJI54jxFcPVm2sm/XWq3Z1qa94PFYz0FF.za9gl5WZL/z/g4nFLQ94SSEzMg5GMzMjJ6Vd7.
```

Now when you want to rebuild the configuration you have access to an alias called flake-rebuild that will rebuild the flake based of the flakeDir variable you set in options.nix!

Hope you enjoy!
