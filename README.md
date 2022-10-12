# Dynamic Island on macOS using SketchyBar
Dynamic Island on iPhone 14 Pro implementation on Mac using SketchyBar

***NOTE: Majority of the code are hardcoded. This is my first time making a project using Shell Scripts. Some features require constantly rewriting a file instead of relying on a event system. With that being said, I have yet experienced a large impact on performance on my machine.***
***This project is yet to be used daily and be functional. It's more of a concept.***

![](images/full.png)

Table of Contents
=================

[Installation](#installation)

[Updating](#updating)

[Optimal Setup](#optimal-setup)

[Configuration](#configuration)

[Features](#features)

[Todo](#todo)

[Bugs](#bugs)

[FAQ](#faq)

[Credits](#credits)



Installation
============

### Requirements
- [Homebrew](https://brew.sh/)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- sf-symbols (`brew install --cask sf-symbols`)
- biplist (`pip3 install biplist`) (only required for notification feature)

### Getting Started
1. Clone the repository
```bash
git clone https://github.com/crissNb/Dynamic-Island-Sketchybar.git
```

2. Copy all the contents of the repository in `~/.config/sketchybar` folder
```bash
cd Dynamic-Island-Sketchybar/
cp -r . ~/.config/sketchybar/
```

You may then delete the original folder.

*if you have just installed sketchybar, sketchybar folder in your config may not be present. If this is the case, make a folder on your own:*
```bash
mkdir ~/.config/sketchybar
```


### Setting up notifications
In order for Dynamic Island configuration to deliver the notifications to you, a notification database has to be provided. The database's file location is unique to every computer, however.

1. Open `Activity Monitor`*
2. Search for `usernoted` process
3. Double-click on `usernoted` and go to `Open Files and Ports` tab.
4. Scroll through different locations and find a location that looks similar to `/private/var/folders/xx/xxxxxxxxxxxxxxxx/0/com.apple.notificationcenter/db2/db`, where x's are unique values.
5. Copy the location
6. Navigate to: `~/.config/sketchybar/plugins/dynamic_island/islands/notification`

*If you would like to do this process using Finder, you can press `Cmd + Shift + G` in Finder or `Go -> Go to Folder...`*

7. Open `init.sh` with a text editor and modify `NOTIFICATION_DATABASE` variable (replace the path in the quotes with what you've copied before).

*Alternatively, users can also find the location to the notification database by using the following command:
```bash
lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print $NF }' | grep 'db2/db$' | xargs dirname
```

##

### For existing SketchyBar users
Add this line of code to your `sketchybarrc` file.
```bash
source "$HOME/.config/sketchybar/items/dynamic_island.sh"
```
You may have to adjust default settings with `sketchybar --default`. See `sketchybarrc` of this repository for details.

Updating
=============
If you are already using my configuration files for dynamic island sketchybar and would like to update to the newer version, it is recommended to delete the entire configuration folder and follow the installation steps again. As of right now, there is no update system built in.

If you are deleting your entire folder to do an update, please note that this will delete your existing configuration files in `~/.config/sketchybar/plugins/dynamic_island/configs`. If you intend on keep using your personal configuration files, copy them temporarily to somewhere else before you delete the folder.

Optimal Setup
=============
I highly suggest you to use SketchyBar and the dynamic island config files with Yabai.

If you have been using the macOS's default menu bar, I suggest you to enable the `"Automatically hide and show the menu bar"` option (located in `System Preferences -> Dock & Menu Bar`) and completely relying on the SketchyBar to handle the macOS menu. This repository only includes the SketchyBar configuration for Dynamic Island plugin. See my [dotfiles](https://github.com/crissNb/dotfiles) or [Sketchybar setups](https://github.com/FelixKratz/SketchyBar/discussions/47) for preconfigured SketchyBar setups to fully replace macOS menu bar.
*If you are using my dotfiles for sketchybar, dynamic island is already included in the dotfiles. Otherwise, you will need to repeat the process above. Also see ["For existing SketchyBar users"](#for-existing-sketchybar-users).

Configuration
=============
All Dynamic Island configuration files can be found in `~/.config/sketchybar/plugins/dynamic_island/configs/`.

`general.sh` contains settings to adjust the notch size. As of right now, users need to manually adjust the notch size in pixels. If you have found an optimal notch size for MacBook with a notch, please let me know. Once enough data has been gathered, preset system will be implemented.

For module specific configurations (e.g. module sizes) can be configured individually (also in configs folder).

The default configuration files are meant for 2021 MacBook Pro 14.

### Disabling features
Unwanted dynamic island features can be disabled by removing their event listeners.

E.g. Disabling app switcher:
`~/.config/sketchybar/items/dynamic_island.sh`:
```bash
...
        popup.background.shadow.drawing=off \
        popup.drawing=false \
        horizontal=off \
--add event	  music_change "com.apple.Music.playerInfo" \
--add item	  musicListener\
--set musicListener	script="$PLUGIN_DIR/dynamic_island/islands/music/music_island.sh" \
--subscribe musicListener music_change \
# REMOVE START
--add item	  frontAppSwitchListener \
--set frontAppSwitchListener script="$PLUGIN_DIR/dynamic_island/islands/appswitch/handler.sh" \
--subscribe frontAppSwitchListener front_app_switched
# REMOVE END
...
```
Note that there should be a backslash after each line to append the command.

Features
========
The following table describes the capabilities of this dynamic island project (working islands). Some islands do not work properly just yet. Thus, you may experience some glitches when using them.

|               | General Notifications | Volume  | Music | Pause/Resume | App Switch |
| ------------- |:-------------:| :-----: | :---------: | :------: | :--------: |
| **Cache File**      | yes | yes | yes* | yes | no |
| **Event System?**      | no      |   no | yes | yes | yes |
| **How well does it work?** | 5/5      |    3/5 | 5/5 | 3/5 | 5/5 |
| **Known Bugs** | None | - Animation bug when volume changes multiple times while the UI is active | None | - Animation bug when play / pause happens multiple times while the UI is active | None |
| **Screenshot** | ![](images/notification.png) | ![](images/volume.png) | ![](images/music.png) | ![](images/pause.png) | ![](appswitch.png) |

*saves the artwork temporarily to display it on the dynamic island.

Some features (islands) rely on a script that gets called every second instead of using NSDistributedNotficationCenter. In other words, these islands will have slower response times compared to those using the event system.

Some features (islands) rely on making a "cache" file inside of a SketchyBar config directory.

***Volume feature has been disabled by default until a more optimal solution is found.***

### Recommended Features
*For the best experience, I suggest you to use the following features (for now):*
- General Notifications
- Music
- App Switch

For General Notification feature, I suggest you to turn on the "Do Not Disturb" on your macOS settings. This way the notifications will only be shown via the dynamic island.

Todo
====
- Make GitHub Wiki
- Hide the notch on non-notched laptops
- Less hardcoded system...

### Upcoming Features / Upcoming Islands
- Lock / Unlock
- Bluetooth status
- Do not disturb
- ...and more!

Bugs
====
If you encounter any bugs, feel free to open up an issue! Pull requests are also welcome

Tested devices
==============
- 2021 MacBook Pro 14

FAQ
===
**Q:** Can I use this on MacBook without a notch?

**A:** Yes, it should work, using this config will create a notch on your device.
##

**Q:** Can I use this with multi monitors?

**A:** It's possible, but there will be a notch on all displays. The dynamic island will only appear on one active display, though. This project is not intended to be used with multiple monitors.
##

Credits
=======
Base sketchybarrc was taken from FelixKratz's [dotfiles](https://github.com/FelixKratz/dotfiles).

[Python script](https://github.com/ydkhatri/MacForensics) to get all notifications from the macOS's database.
