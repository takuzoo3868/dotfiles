# dotfiles
![](https://img.shields.io/badge/works%20on-Ubuntu-DD4814.svg)
![](https://img.shields.io/badge/works%20on-ArchLinux-00AAD4.svg)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Author: takuzoo3868  
Date: 05/Feb/2017  

my configuration files
- .vimrc -> init.vim
- .bashrc
- .gitconfig
- .gitmodules
- .config/
  - nvim/
  - tmux/
  - fonts/
    - Ubuntu Mono derivative Nerd Font
  - powerline/

## setup
```bash
$ sh -c "`curl -fsSL https://raw.githubusercontent.com/takuzoo3868/dotfiles/master/setup.sh `"
```

## Tips
- font patch
```bash
$ git clone https://github.com/ryanoasis/nerd-fonts.git
$ sudo add-apt-repository ppa:fontforge/fontforge
$ sudo apt-get update
$ sudo apt-get install fontforge
$ cd nerd-fonts
$ fontforge -script ./font-patcher <path/to/font-file> -w  --fontawesome --fontawesomeextension --fontlinux  --octicons --powersymbols --pomicons
```
