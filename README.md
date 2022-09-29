# Dynamic Island on macOS using SketchyBar
Dynamic Island on iPhone 14 Pro implementation on Mac using SketchyBar

***NOTE: Majority of the code are hardcoded. This is my first time making a project using Shell Scripts. Some features require constantly rewriting a file instead of relying on a event system. With that being said, I have yet experienced a large impact on performance on my machine.***

## Installation

### Requirements
- [Homebrew](https://brew.sh/)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- sf-symbols (`brew install --cask sf-symbols`)

### Getting Started
Clone the repository inside your `~/.config/sketchybar/` folder
```bash
cd ~/.config/sketchybar
git clone https://github.com/crissNb/Dynamic-Island-Sketchybar.git
```
*if you have just installed sketchybar, sketchybar folder in your config may not be present. If this is the case, make a folder on your own:*
```bash
mkdir ~/.config/sketchybar
```

### Setting up notifications
In order for Dynamic Island configuration to deliver the notifications to you, a notification database has to be provided. The database's file location is unique to every computer, however.


### For existing SketchyBar users
Add this line of code to your `sketchybarrc` file.
```bash
source "$HOME/.config/sketchybar/items/dynamic_island.sh"
```
You may have to adjust default settings with `sketchybar --default`. See `sketchybarrc` of this repository for details.

### Optimal Setup
I highly suggest you to use SketchyBar and the dynamic island config files with Yabai.

## Configuration
For some variables, they can be adjusted by changing the variables in {module_name}_settings.sh file. However, it is not yet recommended to do so, as I have not organized the configuration files properly just yet. Refactoring is needed.

## Features / Working Islands
The following table describes the capabilities of this dynamic island project. Some islands do not work properly just yet. Thus, you may experience some glitches when using them.

|               | General Notifications | Volume  | Music | Pause/Resume | App Switch |
| ------------- |:-------------:| :-----: | :---------: | :------: | :--------: |
| **Cache File**      | yes | yes | yes* | yes | no |
| **Event System?**      | no      |   no | yes | yes | yes |
| **How well does it work?** | 5/5      |    1/5 | 5/5 | 3/5 | 5/5 |
| **Known Bugs** | None | - Animation bug when volume changes multiple times while the UI is active | None | - Animation bug when play / pause happens multiple times while the UI is active | None |

*saves the artwork temporarily to display it on the dynamic island.

Some features (islands) rely on a script that gets called every second instead of using NSDistributedNotficationCenter. In other words, these islands will have slower response times compared to those using the event system.

Some features (islands) rely on making a "cache" file inside of a SketchyBar config directory.

### Recommended Features
*For the best experience, I suggest you to use the following features (for now):*
- General Notifications
- Music

## Todo
- Make GitHub Wiki
- More configuration options
- Fix dynamic island to behave incorrectly when there's something is already being displayed.
- Less hardcoded system...

### Upcoming Features / Upcoming Islands
- Lock / Unlock
- Bluetooth status
- Do not disturb
- ...and more!

## Tested devices
- 2021 MacBook Pro 14

## FAQ
**Q:** Can I use this on MacBook without a notch?

**A:** Yes, it should work, using this config will create a notch on your device.
##

**Q:** Can I use this with multi monitors?

**A:** It's possible, but there will be a notch on all displays. The dynamic island will only appear on one active display, though. This project is not intended to be used with multiple monitors.
##

## Credits
Base sketchybarrc was taken from FelixKratz's [dotfiles](https://github.com/FelixKratz/dotfiles).

[Python script](https://github.com/ydkhatri/MacForensics) to get all notifications from the macOS's database.
