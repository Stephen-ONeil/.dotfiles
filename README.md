# .dotfiles

Collection of misc. dotfiles I use, with symlinks managed locally using [Stow](https://www.gnu.org/software/stow/).

These are currently all from an Arch Linux install running on a Dell XPS 13. I did try to keep my configurations portable, so that this would be useful to set up future machines and not just as a backup, but there are likely to be some things like keybinding choices that won't make sense on arbitrary machines.

I got around to organizing these files late, so I'm missing documentation here that probably would have been nice-to-have. Would have been good to list any configuration-specific package dependencies in here (e.g it's clear I'm using i3 as a window manager, but it isn't immediatly obvious that my volume hotkeys assume the PulseAudio sound server is running). There were also choices made for system-specific reasons that couldn't be avoided (e.g. my backlight control hotkeys use a custom script because I chose to disable legacy boot, which breaks backlight support on the XPS 13).  
I'm bound to add more dotfiles here, and keep tweaking away at old ones. Hopefully there will be more documenting going forward (to make this more useful to future-me if nothing else). If not, someone hold me to it next time I install a system from scratch!
