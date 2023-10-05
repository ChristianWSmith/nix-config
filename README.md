# nix-config
Nix config files.

## Installation
My install notes are found [here](https://docs.google.com/document/d/1AH0DahjBLnj5EFFwaiUMHzl7CS2ftOybahPNlOBMhlM/edit?usp=sharing).

## Default Keybindings
IMPORTANT: My config uses keyd to swap ALT for META and vice versa.  This means that if you want a program to read ALT, you press META.  My main modifier in Hyprland is set to SUPER (meta), which means that you will press ALT on the physical keyboard.  Henceforth, key names will refer to the PHYSICAL keys on the keyboard:

### Movement
- ALT+1, ALT+2, ..., ALT+N : Go to workspace N
- ALT+SHIFT+1, ALT+SHIFT+2, ..., ALT+SHIFT+N : Move current window to workspace N and follow it
- ALT+I/J/K/L: Focus window up/left/down/right
- ALT+SHIFT+I/J/K/L: Move focused window up/left/down/right

### Essentials
- ALT+D: fuzzel (run launcher)
- ALT+Enter: footclient (terminal)
- ALT+SHIFT+E: wlogout (power menu)

### Extras
- ALT+Z: zen mode toggle (kill waybar, set all gaps to zero, turn off rounding)
- ALT+SHIFT+Q: close focused window
- ALT+E: ranger (text-based file browser)
- ALT+W: firefox (web browser)
- ALT+C: clipboard history
- ALT+O: emoji picker
- ALT+A: pulsemixer (text-based audio control)
- ALT+SHIFT+C: clear clipboard history
- ALT+F: toggle fullscreen focused window
- ALT+P: hyprpicker (color picker)
- ALT+S: screenshot
- ALT+B: btop (task manager)
- ALT+SHIFT+B: cycle wallpaper (background)

## TODO (for me):
- Figure out how to manage hitbox as a package.
