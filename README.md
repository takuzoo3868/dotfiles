# dotfiles
![](https://img.shields.io/badge/works%20on-Ubuntu-DD4814.svg)
![](https://img.shields.io/badge/works%20on-ArchLinux-00AAD4.svg)
![](https://img.shields.io/badge/works%20on-MacOS-lightgrey.svg)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

![img01](./doc/misc/Screenshot_2018-11-26_00-49-36.png)

Author: takuzoo3868  
Date: 26/Nov/2018 

This is a repository with my configuration files, those are verified on Linux / MacOS.

```
dotfiles/
 ├── .bashrc 
 ├── .bashrc_prompt
 ├── bin/            --> Useful scripts
 ├── .config/
 │   ├── cpp
 │   ├── fish
 │   ├── git
 │   ├── nvim
 │   ├── nyaovim
 │   ├── ranger
 │   ├── tmux
 │   └── fonts/      --> Store local font [unstage]
 ├── doc/            --> Other files (img/md) 
 ├── etc/
 │   ├── init        --> Setup & Install scripts
 │   └── test        --> OS,env,shell tests [not yet upload]
 ├── Makefile
 ├── .radare2rc
 ├── .vimrc          --> Check nvim/init.vim
 └── .weechat/
```

## requirements
I recommend the introduction of [Cica](https://github.com/miiton/Cica) or [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) to display graphical icons on terminal. 


I'll add a script about fonts and other environment variables, as well as language environment maintenance in `etc/init`.

## setup
Just copy and execute this !!!
```bash
$ bash -c "`curl -fsSL https://raw.githubusercontent.com/takuzoo3868/dotfiles/master/etc/init/init `"
```

It is almost the same as the command below except for executing through a Web site directly.
```bash
$ make install
```
Incidentally, `make install` will perform the following tasks.

- `make update` Updating dotfiles repository
- `make deploy` Deploying dot files
- `make init` Initializing some settings 

## screenshot

![img02](doc/misc/Screenshot_2018-11-26_00-52-06.png)

![img03](doc/misc/Screenshot_2018-11-26_00-53-13.png)
