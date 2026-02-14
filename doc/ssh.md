# SSH Key Update

```bash
# Enter the email address you use for GitHub in "your_email@example.com"
$ ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/github/`whoami`-github-`date +%Y-%m-%d`

# Copy FingerPrint in Public Key
$ ssh-keygen -l -f "your_new_public_key" 
```

Access https://github.com/settings/ssh/, enter easily identifiable information in `Title`, and paste the public key into `Key`.  
Specify Authentication Key for `Key type`.

Create symbolic links.

```bash
$ ln -fs ~/.ssh/github/`whoami`-github-`date +%Y-%m-%d` ~/.ssh/github/`whoami`-github
```

Configure `~/.ssh/config`.  
Additional: If you are using a macOS, set `HostKeyAlgorithms +ssh-dss` to `~/.ssh/config`.

```bash
Host github.com
  Hostname github.com
  User "your username"
  IdentityFile "your Secret Key path"
```

Execute the following command in the terminal to verify the connection.

```bash
$ ssh -T git@github.com
```
gi