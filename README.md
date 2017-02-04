# dotfiles
[![Build Status](https://travis-ci.org/dtan4/terraforming.svg?branch=master)](https://travis-ci.org/takuzoo3868/dotfiles)
[![Code Climate](https://codeclimate.com/github/dtan4/terraforming/badges/gpa.svg)](https://codeclimate.com/github/takuzoo3868/dotfiles)
[![Coverage Status](https://coveralls.io/repos/github/dtan4/terraforming/badge.svg?branch=increase-test-cov-160528)](https://coveralls.io/github/takuzoo3868/dotfiles)

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
