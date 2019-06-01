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

/server add freenode chat.freenode.net
/set irc.server.freenode.nicks "tak3z_0o0"
# /msg nickserv register [password] [email]
# /msg NickServ VERIFY REGISTER tak3z_0o0 [code]
/set irc.server.freenode.command "/msg nickserv identify [password]"
/set irc.server.freenode.autoconnect on
/set irc.server.freenode.autojoin "#security,#vulnhub,#r_netsec,#networking,#offsec,#metasploit,#dwarffortress"

/script install iset.pl
/script install buffer_autoset.py
/script install go.py
/script install emoji_aliases.py
/script install slack.py
/script install grep.py

/key bind ctrl-B /bar toggle buflist
/key bind ctrl-G /go
/set alias.cmd.b = "/buffer"
```

### UEC proxy

```
/proxy add <name> <protocol> hoge.uec.ac.jp 8080
```

### 設定の確認

```
/fset
```