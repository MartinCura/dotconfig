# dotconfig

My configuration files.


Clone with
```bash
git clone --bare <git-repo-url> $HOME/.home
echo "alias dotconfig='/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME'" >> $HOME/.bashrc
. ~/.bashrc
dotconfig config --local status.showUntrackedFiles no
dotconfig checkout
```

Of course this last step will fail if it may overwrite something (such as an existing `.bashrc`).

Uses ["bare repo and alias" method](https://news.ycombinator.com/item?id=11070797).
