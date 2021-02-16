#                  ___
#   ___======____=---=)
# /T            \_--===)
# [ \ (0)   \~    \_-==)
#  \      / )J~~    \-=)
#   \\___/  )JJ~~~   \)
#    \_____/JJJ~~~~    \
#    / \  , \J~~~~~     \
#   (-\)\=|\\\~~~~       L__
#   (\\)  (\\\)_           \==__
#    \V    \\\) ===_____   \\\\\\
#           \V)     \_) \\\\JJ\J\)
#                       /J\JT\JJJJ)
#                       (JJJ| \UUU)
#                        (UU)

### settings
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -g theme_show_exit_status yes
set -g theme_color_scheme zenburn

## Hooks
test -d $XDG_DATA_HOME/fish/generated_completions; or fish_update_completions

## fish for root
function su
    /bin/su --shell=/usr/bin/fish $argv
end

## load local config file
if [ -f ~/.config/fish/config.local.fish ]
    source ~/.config/fish/config.local.fish
end

### alias

### functions
function up
  ping 8.8.8.8
end