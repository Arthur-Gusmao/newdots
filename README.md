# Dotfiles

Plan 9 rc + Make. No Stow or Python.
Requires `rc`, `cleanname` (from plan9port), Make, and standard Unix utilities.

## Install

```sh
cd ~/dotfiles
make install
```

Already installed? Running it again is safe.
Use `make check` to preview or `make uninstall` to remove the links.
Existing files are never overwritten; move conflicting files aside first.

## Add dotfiles

Each directory is a package. Put files inside it using their paths from home:

```text
shell/.profile                  -> ~/.profile
swindle/.config/swindle/config.lua -> ~/.config/swindle/config.lua
```

For example, to add an existing Foot configuration:

```sh
mkdir -p ~/dotfiles/foot/.config
mv ~/.config/foot ~/dotfiles/foot/.config/
cd ~/dotfiles
make install PACKAGES=foot
```

New packages are discovered automatically. No script changes needed.
Edit files in the repository or through their links; both edit the same file.

## Options

```sh
make install PACKAGES="swindle waybar"
make check TARGET=/another/home
```

Links point directly to files in this repository. Keep it at `~/dotfiles`.
Relative links from earlier installations continue to work.
Uninstall removes only this repository's links and keeps the files.

Without Make: `rc link.rc install "$HOME"`.
If needed: `make install RC=/path/to/rc`.
