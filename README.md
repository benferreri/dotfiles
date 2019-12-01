# dotfiles

config files and some shell scripts

best installed with GNU Stow. with stow installed:  
```
cd
git clone https://github.com/benferreri/dotfiles.git
cd dotfiles
stow <name of desired folder>
```
this will symlink the config files of the given program to their appropriate location in the home directory. the only exception is the firefox userChrome.css, which will not be placed in the right spot with stow.
