# Dotfiles
![](https://img.shields.io/badge/works%20on-Ubuntu-DD4814.svg)
![](https://img.shields.io/badge/works%20on-ArchLinux-00AAD4.svg)
![](https://img.shields.io/badge/works%20on-MacOS-lightgrey.svg)
![](https://img.shields.io/badge/license-MIT-blue.svg)

```
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

*** WHAT THIS SCRIPT DOES ***
1. Download dotfiles repository
2. Deploy dotfile symlinks to your HOME directory
3. Optionally initialize develop packages via apt/pacman/brew, mise
4. Optionally build fonts (Cica patched by nerd-fonts) 

```

Author: takuzoo3868  

This is a repository with my configuration files, those are verified on Linux / MacOS.

```
dotfiles/
 ├── bin/            --> Useful command scripts
 ├── config/         --> Package config files
 │   ├── bash
 │   ├── git
 │   ├── mise
 │   ├── nvim
 │   ├── nyaovim
 │   ├── radare2
 │   ├── sqlite
 │   ├── tmux
 │   ├── vim
 │   ├── weechat
 │   └── yazi
 ├── doc/            --> Document files (img/md) 
 ├── etc/
 │   ├── init        --> Setup & Install scripts
 │   └── lib         --> Library scripts
 └── Makefile
```

## Setup

Requirements: `bash`, `curl`, `tar`, `git`.  
Just copy and execute this !!!
```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/takuzoo3868/dotfiles/master/etc/setup)"
```

If you want to install a [dev-packages](https://github.com/takuzoo3868/dotfiles/tree/master/etc/scripts/install.d), add `init` as an optional argument.
```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/takuzoo3868/dotfiles/master/etc/setup)" -s init
```

### Setup using Makefile

```bash
$ git clone https://github.com/takuzoo3868/dotfiles.git $HOME/.dotfiles
$ cd $HOME/.dotfiles
$ make install
```

`make install` will perform the following tasks.  
- `make deploy` Deploy dotfile symlinks to $HOME
- `make init` Install development packages & setup settings

Other options can be checked with `make help`.

## Recommend
I recommend installing [Cica](https://github.com/miiton/Cica) or [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) to display graphical icons on terminal. 

A script to automate the installation is placed in `etc/scripts/deep.d/10_font.sh`. 
Requirements: `bash`, `fontforge`, `unzip`, `git`.  

## Screenshot

![img01](doc/misc/Screenshot_from_2026-02-12_22-50-56.png)

## References

- [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles)
