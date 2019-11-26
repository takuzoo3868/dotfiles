# Nerd Fonts font patcher

NEED: `fontforge`

1. DL [Cica font](https://github.com/miiton/Cica/releases) to `.local/font`

1. DL [Glyphs](https://github.com/ryanoasis/nerd-fonts/tree/master/src/glyphs) to `make_font/src/glyphs`

2. 'fontforge -script font-patcher -c PATH_TO_FONT --out dist'