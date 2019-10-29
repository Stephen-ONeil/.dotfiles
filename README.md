# .dotfiles

Collection of my misc. dotfiles from multiple systems. Symlinks managed locally with stow (see `./management-scripts/*.sh`).

## Directory structure
  - `./management-scripts/`: scripts for managing dotfiles. Currently just shorthands for using stow to symlink system-specific dotfiles in to $HOME
  - `./non-stowed/`: files not managed with stow, generally because they go somewhere other than $HOME
  - `./common/`: system agnostic dotfiles
  - `./arch-linux/`: dotfiles specific to my XPS 13\* Arch Linux setup
  - `./arch-linux/`: dotfiles specific to my MacOS setup

\* the hardware's relevant, I've got some odd and poorly document things like a custom keyboard backlight script because I disabled legacy boot which had a side effect of breaking the XPS 13's specific backlight controls. Isolating or at least documenting these particularily system specifc choices is a TODO (...but don't  wait up on me actually doing it until my next fresh Arch Linux install).