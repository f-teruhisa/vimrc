# Description
- My personal `~/.vimrc` file

# Introduction
## 1. Copy `.vimrc`
- Copy `.vimrc` from this repository to `~/.vimrc` on machine
- If you already have `~/.vimrc` on machine, make a backup

```
cp .vimrc ~/.vimrc
```

## 2. Install the `vim-plug` plugin
- Open vim and run `:PlugInstall` command
- All `vim-plug` plugin will be installed automatically
- Reopen vim, the settings will be reloaded

```
:PlugInstall
```

## 3. Install Powerline
- Run the following command to install powerline-status
- It is assumed that already have `python3` and `pip` installed on machine

```
python3 -m pip install powerline-status
```

