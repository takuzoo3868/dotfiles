# dotfiles
Author: takuzoo  
Date: 12/Jan/2017  

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
$ sh ./setup.sh
```

#### Tips

- nvim install
```bash
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository ppa:neovim-ppa/unstable
$ sudo apt-get update
$ sudo apt-get install neovim
$ sudo apt-get install python-dev python-pip python3-dev python3-pip
$ sudo pip2 install --upgrade neovim
$ sudo pip3 install --upgrade neovim
$ sudo apt install xclip xsel
```

- powerline tmux
```bash
$ sudo pip install --user git+git://github.com/powerline/powerline
$ sudo pip install psutil
$ cp -R ~/.local/lib/python2.7/site-packages/powerline/config_files/* ~/.config/powerline/
$ ln -s ~/.dotfiles/.config/powerline/themes/tmux/default.json ~/.dotfiles/.config/tmux/
$ ln -s ~/.dotfiles/.config/powerline/themes/powerline.json ~/.dotfiles/.config/tmux/
```

- font patch
```bash
$ git clone https://github.com/ryanoasis/nerd-fonts.git
$ sudo add-apt-repository ppa:fontforge/fontforge
$ sudo apt-get update
$ sudo apt-get install fontforge
$ cd nerd-fonts
$ fontforge -script ./font-patcher <path/to/font-file> -w  --fontawesome --fontawesomeextension --fontlinux  --octicons --powersymbols --pomicons
```

- istall with non-manager authority
```bash
$ mkdir scr
$ cd scr | wget hoge | cd
$ mkdir opt
$ ./configure --prefix=$HOME/.local
$ make
$ make isntall
```
