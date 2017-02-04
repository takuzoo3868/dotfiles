# dotfiles
![](https://img.shields.io/badge/works%20on-Ubuntu-DD4814.svg)
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
$ mkdir $HOME/.dotfiles
$ git clone https://github.com/takuzoo3868/dotfiles $HOME/.dotfiles
$ ./setup.sh
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
