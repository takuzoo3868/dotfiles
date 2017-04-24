# dotfiles
![](https://img.shields.io/badge/works%20on-Ubuntu-DD4814.svg)
![](https://img.shields.io/badge/works%20on-ArchLinux-00AAD4.svg)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Author: takuzoo3868  
Date: 25/Apr/2017 

![shot01](https://raw.githubusercontent.com/takuzoo3868/dotfiles/media/Screenshot%20from%202017-04-21%2001-30-47.png)

my configuration files
- .vimrc -> init.vim
- .bashrc
- .gitconfig
- .gitignore
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
