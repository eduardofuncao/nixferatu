# Nixferatu

NixOS/Stylix black-metal configuration using NiriWM

![showcase](https://github.com/user-attachments/assets/c4ca4bd6-07ce-464e-bba0-49f1b28a7cf7)

[Reddit post](https://www.reddit.com/r/unixporn/comments/1o5xhp2/niri_infinite_workspaces_with_niri/)

## Setup Guide
- Install Nixos basic configuration (here you could use the GUI installer and select no DE option or manually  create and mount partitions, generate the nixos config with nixos-generate-config, and install the system with nixos-install - [here is a great video by tony explaining the manual setup](https://www.youtube.com/watch?v=2QjzI5dXwDY))

- Once you `reboot` into the installed system, you can proceed with the next steps

- enter a nix shell with git and vim available to help setup
```bash
nix-shell -p git vim
```

- clone the repo in the $HOME directory
```bash
git clone --branch nixos-from-scratch https://github.com/eduardofuncao/dotfiles
```

- copy needed config files to `$HOME/.config/`
```bash
mkdir ~/.config
cd ~/dotfiles
cp -r fish/ niri/ nvim/ ripgrep/ scripts/ swayidle/ wallpapers/ ~/.config
sudo cp kanata/kanata.kbd /etc/
```
ps. kitty, tmux and waybar config files are managed directly through nix

- copy the nixos config files in `$HOME/dotfiles/nixos` directory into `/etc/nixos/`,
keeping only your automatically generated `hardware-configuration.nix` file
```bash
# backup the current hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix /tmp/

# remove everything from /etc/nixos
sudo rm -rf /etc/nixos/*

# copy everything from your dotfiles/nixos to /etc/nixos
sudo cp -rT ~/dotfiles/nixos /etc/nixos

# restore the hardware-configuration.nix file
sudo mv /tmp/hardware-configuration.nix /etc/nixos/nixos
```

- replace every instance of user "eduardo" with your username (in `/etc/nixos/nixos/configuration.nix`,
`/etc/nixos/home-manager/home.nix` and `/etc/nixos/flake.nix`)

- change localization settings to your preferred language, timezone and keyboard layout in `/etc/nixos/nixos/configuration.nix`

- if you want, change hostname in `/etc/nixos/nixos/configuration.nix` and `/etc/nixos/flake.nix` from `nixos` to something else

- build the system (we have to explicitly allow flakes on the first build. For next rebuilds,
just use `sudo nixos-rebuild switch --flake .#hostname`)
```bash
cd /etc/nixos
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-rebuild switch --flake .#nixos
```
> this will take a while ⏳

- run home-manager switch to setup user level config (similarly, on the first build we need to explicitly install home-manager.
for the next runs, just use `home-manager switch --flake .#user@hostname)
```bash
cd /etc/nixos
nix-shell -p home-manager
home-manager switch --flake .#eduardo@nixos
```

> this will take an even longer while 😴

- just `sudo reboot`, login to your system and everything should work!

Done 🥳


## Tips and Quirks
- On Every startup, Niri sets a random wallpaper from `~/.config/wallpapers`
- Meta+Space will open up Vicinae, which is used as the app launcher. Most of the other Niri keybinds are default
- You can change the system colorscheme easily by editing the option `stylix.base16Scheme` in  `/etc/nixos/modules/home-manager/stylix`. Most of the themes from [tinted theming](https://tinted-theming.github.io/tinted-gallery/) should be available. Run `home-manager switch --flake .#user@hostnae` to apply changes
- There is a systemd kanata service running that swaps CapsLock and Esc. The Caps key will work as Esc on press, and as Ctrl on hold as per the config in `/etc/kanata.kbd`
- tmux uses Ctrl+a as the leader key. Since caps lock acts as ctrl on hold, you can use your pinky and ring figers to type ctrl+a more naturally
- nvim has a pretty barebones config using the nightly v0.12 build. I don't recommend using it, as it is pretty opinionated for my uses. I would recommend using your own neovim config or creating a neovim config from scratch using [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- The nixos config uses flake.nix as the entrypoint. The main config files are in `/etc/nixos/nixos/configuration.nix` and `/etc/nixos/home-manager/home.nix`. Everything else is imported from these two files
- the default programs I use are:
  - imv: images and gifs
  - mpv: videos
  - zathura: pdfs
  - neovim: editor
  - kitty: terminal
  - zen-browser
  - yazi: file manager
  - ncdu: disk usage
  - btop: system monitor
  - zoxide: cd with superpowers
  - pavucontrol: volume mixer
  - light: control screen brightness
  - bluetoothctl
  - nmtui: wifi

Hope you like it! 😉
