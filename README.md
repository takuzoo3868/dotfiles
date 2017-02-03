# dotfiles
Author: takuzoo  
Date: 03/Feb/2017  

my configuration files
- .vimrc
- .gitconfig
- .config/
  - nvim/
  - tmux/
    - tmux-powerline
  - fonts/


### setup
```bash  
$ mkdir $HOME/.dotfiles
$ git clone https://github.com/takuzoo3868/dotfiles $HOME/.dotfiles
$ ./setup.sh
```

#### Tips
- font patch
```bash
$ git clone https://github.com/ryanoasis/nerd-fonts.git
$ sudo add-apt-repository ppa:fontforge/fontforge
$ sudo apt-get update
$ sudo apt-get install fontforge
$ cd nerd-fonts
$ fontforge -script ./font-patcher <path/to/font-file> -w  --fontawesome --fontawesomeextension --fontlinux  --octicons --powersymbols --pomicons
```
