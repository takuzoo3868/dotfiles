# tmux setup

For MacOS you may need a retouching wrapper to draw the status line.

```
$ brew install reattach-to-user-namespace
```

## tpm

### Installing plugins

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugin.

You're good to go! The plugin was cloned to `~/.tmux/plugins/` dir and sourced.

### Key bindings

`prefix` + <kbd>I</kbd>
- Installs new plugins from GitHub or any other git repository
- Refreshes TMUX environment

`prefix` + <kbd>U</kbd>
- updates plugin(s)

`prefix` + <kbd>alt</kbd> + <kbd>u</kbd>
- remove/uninstall plugins not on the plugin list

### tmux weather!!!

1. Register the [OpenWeatherMap](https://openweathermap.org/api) API.

2. Add `export WEATHER_API="INPUT_YOUR_API_KEY"` to `.bashrc`.

enjoy :)

## layout check

`tmux list-windows`