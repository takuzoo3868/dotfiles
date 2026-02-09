# tmux setup

For MacOS you may need a retouching wrapper to draw the status line.

```
$ brew install reattach-to-user-namespace
```

## tpm

- Installing plugins

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugin.

You're good to go! The plugin was cloned to `~/.tmux/plugins/` dir and sourced.

- Key bindings

`prefix` + <kbd>I</kbd>
- Installs new plugins from GitHub or any other git repository
- Refreshes TMUX environment

`prefix` + <kbd>U</kbd>
- updates plugin(s)

`prefix` + <kbd>alt</kbd> + <kbd>u</kbd>
- remove/uninstall plugins not on the plugin list


## Layout Check

`tmux list-windows`


## Keybinding Cheat Sheet

Prefix key is **`Ctrl-a`** (GNU Screen compatible).

---

### General

| Key | Action |
|----|----|
| `Ctrl-a Ctrl-a` | Send prefix |
| `Ctrl-a e` | Edit `~/.tmux.conf.local` and reload |
| `Ctrl-a r` | Reload `~/.tmux.conf` |
| `Ctrl-l` | Clear screen and history |

---

### Sessions

| Key | Action |
|----|----|
| `Ctrl-a Ctrl-c` | Create new session |
| `Ctrl-a Ctrl-f` | Find and switch session |

---

### Windows

| Key | Action |
|----|----|
| `Ctrl-h` | Previous window |
| `Ctrl-l` | Next window |
| `Tab` | Switch to last window |

---

## Panes – Split

| Key | Action |
|----|----|
| `Ctrl-a -` | Split pane horizontally |
| `Ctrl-a _` | Split pane vertically |
| `Ctrl-a +` | Toggle maximize pane |

---

## Panes – Navigation

| Key | Action |
|----|----|
| `Ctrl-a h` | Move to left pane |
| `Ctrl-a j` | Move to lower pane |
| `Ctrl-a k` | Move to upper pane |
| `Ctrl-a l` | Move to right pane |

---

## Panes – Swap

| Key | Action |
|----|----|
| `Ctrl-a >` | Swap with next pane |
| `Ctrl-a <` | Swap with previous pane |

---

## Panes – Resize

| Key | Action |
|----|----|
| `Ctrl-a H` | Resize left |
| `Ctrl-a J` | Resize down |
| `Ctrl-a K` | Resize up |
| `Ctrl-a L` | Resize right |

---

### Mouse

| Key | Action |
|----|----|
| `Ctrl-a m` | Toggle mouse mode |

---

### Copy Mode (vi style)

| Key | Action |
|----|----|
| `Ctrl-a Enter` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl-v` | Rectangle selection |
| `y` | Copy and exit |
| `H` | Move to start of line |
| `L` | Move to end of line |
| `Esc` | Cancel |

Clipboard integration is Automatically detected:
- macOS: `pbcopy`, `reattach-to-user-namespace`
- Linux: `xsel`, `xclip`
- Windows: `clip.exe`
- Other: `/dev/clipboard`

---

### Buffers

| Key | Action |
|----|----|
| `Ctrl-a b` | List buffers |
| `Ctrl-a p` | Paste buffer |
| `Ctrl-a P` | Choose buffer to paste |

---

### Utilities

| Key | Action |
|----|----|
| `Ctrl-a U` | Open URL via urlview |
| `Ctrl-a F` | Run Facebook PathPicker |

---

### Notes

- Window and pane index start from **1**
- Status line refresh interval: **10 seconds**
- Powerline fonts recommended


## Status Line: Weather script

1. Register the [OpenWeatherMap](https://openweathermap.org/api) API.

2. Add `export WEATHER_API="INPUT_YOUR_API_KEY"` to `.bashrc`.