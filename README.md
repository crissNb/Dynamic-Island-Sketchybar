# Dynamic Island on macOS using SketchyBar
Dynamic Island on iPhone 14 Pro implementation on Mac using SketchyBar

***NOTE: Majority of the code are hardcoded. This is my first time making a project using Shell Scripts. Some features require constantly rewriting a file instead of relying on a event system. With that being said, I have yet experienced a large impact on performance on my machine.***

## Installation / Getting Started
coming soon

## Features / Working Islands
The following table describes the capabilities of this dynamic island project. Some islands do not work properly just yet. Thus, you may experience some glitches when using them.

|               | General Notifications           | Volume  | Music |
| ------------- |:-------------:| :-----:| ---------: |
| **Cache File**      | yes | yes | yes |
| **Event System?**      | no      |   no | yes |
| **How well does it work?** | 5/5      |    1/5 | 5/5 |

Some features (islands) rely on a script that gets called every second, instead of using NSDistributedNotficationCenter. In other words, these islands will have slower response times compared to those using the event system.

Some features (islands) rely on making a "cache" file inside of a SketchyBar config directory.

### Recommended Features
*For the best experience, I suggest you to use the following features (for now):*
- General Notifications
- Music

## Upcoming Features / Upcoming Islands
- Pause / Resume
- App switch
- Lock / Unlock
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
