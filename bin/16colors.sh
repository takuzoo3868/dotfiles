#!/bin/sh

/bin/echo -e "
# General text attributes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed

# Foreground coloring codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white

# Background coloring codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

Display status
\033[00m default   00 \033[00m
\033[01m bold      01 \033[00m
\033[04m underline 04 \033[00m
\033[05m blink     05 \033[00m
\033[07m reverse   07 \033[00m
\033[08m hidden    08 \033[00m(invis    08)

Coloring
\033[30m black   30 \033[00m \033[40m 40 \033[00m \033[31;40m 31;40 \033[00m \033[32;00;40m 32;00;40 \033[00m
\033[31m red     31 \033[00m \033[41m 41 \033[00m \033[32;41m 32;41 \033[00m \033[33;01;41m 33;01;41 \033[00m
\033[32m green   32 \033[00m \033[42m 42 \033[00m \033[33;42m 33;42 \033[00m \033[34;04;42m 34;04;42 \033[00m
\033[33m yellow  33 \033[00m \033[43m 43 \033[00m \033[34;43m 34;43 \033[00m \033[35;05;43m 35;05;43 \033[00m
\033[34m blue    34 \033[00m \033[44m 44 \033[00m \033[35;44m 35;44 \033[00m \033[36;07;44m 36;07;44 \033[00m
\033[35m magenta 35 \033[00m \033[45m 45 \033[00m \033[36;45m 36;45 \033[00m \033[37;00;45m 37;00;45 \033[00m
\033[36m cyan    36 \033[00m \033[46m 46 \033[00m \033[37;46m 37;46 \033[00m \033[30;01;46m 30;01;46 \033[00m
\033[37m white   37 \033[00m \033[47m 47 \033[00m \033[30;47m 30;47 \033[00m \033[31;04;47m 31;04;47 \033[00m
"
