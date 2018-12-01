# init weechat sheet

```
/set irc.look.server_buffer independent
/set irc.look.new_channel_position near_server
/set irc.look.new_pv_position near_server
/set weechat.look.save_layout_on_exit all
/mouse disable

/server add root_me irc.root-me.org/6667
/set irc.server.root_me.autoconnect on
/set irc.server.root_me.autojoin "#root-me"

/server add 0x00sec irc.0x00sec.org
/set irc.server.0x00sec.autoconnect on
/set irc.server.0x00sec.autojoin "#0x00sec"

/server add freenode irc.freenode.net/6697

/script install iset.pl
/script install buffer_autoset.py
/script install go.py
/script install emoji_aliases.py

/key bind ctrl-B /bar toggle buflist
/key bind ctrl-G /go
/set alias.cmd.b = "/buffer"
```