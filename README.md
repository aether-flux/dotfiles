# Everforest x Hyprland Rice - Aether's Dotfiles

These are my dotfiles for my main working Arch (EndeavourOS) setup.
I am using these tools:
- Hyprland
- Waybar
- Dunst
- Rofi
- Nautilus
- Zen Browser
- Kitty
- Zsh (& tmux)
- NeoVim
- Fonts => GeistMono Nerd Font, Iosevka Nerd Font
- Custom bash scripts

## Installation and Usage
Simply clone this repo in your home directory. Then, `cd` into `~/dotfiles` directory, and run `stow` for every directory like `stow kitty`, `stow dunst`, etc. <br/>
Don't stow the `assets/` directory though.

Run the following commands for a straightforward installation:
```sh
git clone https://github.com/aether-flux/dotfiles
cd dotfiles
stow hypr waybar dunst rofi kitty zsh tmux scripts
```

## Lore
Nothing much for now. Just this:
- AetherOS (name of my Linux system) is a continent
- Kigusai (name of my Hyprland setup) is a place on AetherOS

## Screenshots
### Homescreen
![homescreen_default](/assets/images/desktop_blank.png)
![homescreen_showcase](/assets/images/desktop_showcase.png)

### Waybar
![waybar](/assets/images/waybar.png)

### App Launcher (Artefacts)
The main Rofi launcher for apps.
![app-launcher](/assets/images/app_launcher.png)

### Power Menu
The Rofi launcher for power menu with options to lock, suspend, shut down, restart, etc.
![power-menu](/assets/images/powermenu.png)

### Command Palette (`Kigusai Central Pagoda`)
This is a custom script that lets you choose from a variety of tasks like taking a screenshot, displaying a random message, restarting services like waybar, hyprland, etc. on reload, and so on.
![command-palette](/assets/images/command_palette.png)

### Project Launcher (Pagodas)
Choose from a list of Pagodas (Projects) to enter, and it will create a new tmux session with two panes. By default, it scans all directories inside `~/Projects/`, but you can change that manually in `~/dotfiles/scripts/.scripts/zsh/project_launcher.sh`.
![project-launcher](/assets/images/project_launcher.png)

### Notifications
I am using Dunst to display notifications.

#### Low Urgency (Example from random quote displayer, available to run in Command Palette, and also through a keybinding (see bindings below))
![low-notification](/assets/images/low_urgency/notif.png)

#### Normal Urgency (Example from taking a screenshot)
![normal-notification](/assets/images/normal_urgency_notif.png)

## Key Bindings
I have the following keybindings on this setup:
- `SUPER + RETURN`: Open kitty
- `SUPER + B`: Open Zen Browser
- `SUPER + Q`: Kill active window
- `SUPER + E`: Open Nautilus
- `SUPER + PrtScn`: Screenshot (full screen)
- `SUPER + SHIFT + PrtScn`: Screenshot (selection)
- `SUPER + A`: Open emoji list (Rofi)
- `SUPER + SPACE`: Open app launcher (Rofi)
- `SUPER + X`: Open power menu (Rofi)
- `SUPER + M`: Logout
- `SUPER + C`: Color picker (hyprpicker)
- `SUPER + W`: Display random message (from `fortune`) in a notification
- `SUPER + P`: Project launcher (Rofi)
- `SUPER + SHIFT + P`: Command Palette (Rofi)

## Credits and Inspirations
- Everforest theme by [@sainnhe](https://github.com/sainnhe/)
- GeistMono Nerd Font & Iosevka Nerd Font
- Rofi base setup from [@adi1090x](https://github.com/adi1090x)
- Inspirations from numerous dotfiles like [@lgaboury](https://github.com/lgaboury/Sway-Waybar-Install-Script) and [@cxOrz](https://github.com/cxOrz/dotfiles-hyprland/)

## License
This repo is licensed under the MIT license. Use and modify it freely as you wish to.

