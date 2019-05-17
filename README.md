# dotfiles

Dotfile repository for making a new system feel like home.

## Getting Started

This project uses `antigen` to manage plugins for `zsh` and `stowsh` to symlink
files.

To get the repository and its dependencies

```
cd ~
git clone https://github.com/jcalbert/dotfiles.git .dotfiles
cd .dotfiles
git submodule update --init --recursive
```

If necessary, checkout the correct variant
```
git checkout i3
```

Then use `stowsh` from home directory to load packages, e.g. `PACKAGE_NAME`

```
cd ~
.dotfiles/stowsh/stowsh -vv -s PACKAGE_NAME
```

## External Dependencies

In addition to pulling in the configuration files, it is necessary to install
a few packages from the system's package manager (e.g. `apt`).

### Essentials

* `zsh` - Shell
* `pygments` - Used for syntax coloring in the terminal
* `qrencode` - Generate QR codes
* `xclip` - interact with the X11 clipboard
* `dtrx` - Human-friendly archive extractor

### Recommended

* `jq` - JSON pretty-printer
* `ag` - Source code search tool

## Notes


#### Alternatives to `man`
* eg
* bro
* tldr
* cheat.sh
