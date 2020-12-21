---
pagetitle: Using Letters As Arrow Keys on Linux and Mac
---

# Using Letters As Arrow Keys on Linux and Mac

This summer I found myself sitting at a computer writing code for 40 hours a week for the first time, and I started looking for ways to make my computer work more comfortable and efficient. One day it dawned on me that my right hand was constantly jumping between the home row and the arrow keys, so I set out to find a better way to move around my text. After a bit of research, I figured out how to remap a modifier key (e.g., `Ctrl`, `Alt`, etc.) plus `i`/`j`/`k`/`l` to the arrow keys, and what an improvement it was!

I run Linux with the Plasma desktop environment at home and use a Mac at work, so I've included instructions for both.

## Linux with Plasma

The Plasma desktop environment is insanely configurable (that's why I love it!), so I figured I could remap some keys without much trouble. Sure enough, it's possible to do right from the System Settings GUI. 

1. Go to *System Settings* > *Input Devices* > *Keyboard* > *Advanced*
2. Go to *System Settings* > *Shortcuts* > *Custom Shortcuts*
3. Choose *Edit* > *New* > *Global Shortcut* > *Send Keyboard Input*
4. Give the new shortcut a name
5. In the *Trigger* tab, click the button to set the shortcut and then press your desired key combination. (I used `Alt` + `i`/`j`/`k`/`l`.)
6. In the *Action* tab enter `Up` as the action (top box)
7. Click *Apply*
8. Repeat steps 3-7 for the remaining shortcuts, substituting `Down`, `Left`, and `Right` for `Up` in step 6.

> If you want to use `Shift` + modifier + `i`/`j`/`k`/`l` (or some other key combo) as Home, End, Page Up, and Page Down, the action names for those are `Home`, `End`, `PgUp`, and `PgDown`, respectively.

## MacOS

Unfortunately MacOS isn't all that configurable without some help from third-party applications. To remap keys, I used [Karabiner Elements](https://pqrs.org/osx/karabiner/?target=_blank).

1. Open Karabiner Elements
3. Under the *Complex Modifications* tab, click *Add rule* and import a rule from the Internet
4. On the website, find the rule called "Change Modifier key + i/j/k/l to arrow keys" and import it
    > I use the Colemak keyboard layout, so I was actually looking to use `u`/`n`/`e`/`l` as my arrow keys, but this still worked. It must somehow get the original key code.
5. Enable the rule called "Change Alt + i/j/k/l to Arrows" (or whichever modifier you prefer).

MacOS automatically sets `ctrl` + arrows to Home, End, Page Up, and Page Down, so `ctrl` + *modifier* + `i`/`j`/`k`/`l` should work for those now. 

*[Last updated September 16, 2019]*
