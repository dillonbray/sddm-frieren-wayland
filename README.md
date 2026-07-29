# Frieren Wayland - SDDM Theme

An elegant, responsive, and Qt6-native SDDM login theme inspired by *Frieren: Beyond Journey's End*. Built specifically for modern Wayland environments.

![Frieren Wayland Preview](preview.png)

## Features
* **Fully Responsive:** UI elements dynamically scale to perfectly fit anything from 720p laptop screens to 4K monitors.
* **Modern Architecture:** Written for pure Qt6 and Wayland compositors (no legacy Qt5 or X11 bloat).
* **Unified Layout:** Left-aligned, overlapping-proof component stack for flawless readability.

## Dependencies
Because this is a modern Qt6 theme, you must ensure your system has the Qt6 version of SDDM and the Qt6 compatibility modules installed for the visual drop-shadow effects.

* `sddm` (Qt6 build)
* `qt6-5compat`

**For Arch Linux / CachyOS:**
`sudo pacman -S sddm qt6-5compat`

## Installation
1. Clone or Download this repository.

2. Move the folder to your SDDM themes directory:
```
sudo cp -r frieren-wayland /usr/share/sddm/themes/
```
3. Set the theme by creating or editing your SDDM configuration file:
```
echo -e "[Theme]\nCurrent=frieren-wayland" | sudo tee /etc/sddm.conf.d/10-theme.conf
```
4. Test the theme (optional, requires you to be logged into a Wayland session):
```
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/frieren-wayland
```
5. Restart SDDM (Warning: This will close your current session):
```
sudo systemctl restart sddm
```

## Configuration
You can easily change the background image by replacing image.png in the theme folder, or by editing the theme.conf file to point to a different filename.

## Credits & Acknowledgements
- Background Art: The background wallpaper was generated/edited by nano banana, utilizing AI tools based on the original Frieren artwork by kuroha.

- Franchise: Frieren: Beyond Journey's End (Sōsō no Frieren) and its characters are the intellectual property of Kanehito Yamada and Tsukasa Abe / Shogakukan.

- Codebase: Built on the KDE Breeze Wayland scaffolding (LGPL v2.0).

- Fonts: Includes open-source fonts from Google Fonts (Cinzel, EB Garamond) distributed under the SIL Open Font License.
