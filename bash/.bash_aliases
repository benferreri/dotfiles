alias music="mpd && yams && mpdcron && ncmpcpp"
alias rm="rm -i"
alias mv="mv -i"
alias vpn="sudo restart-vpn"
#alias sm="rsync -av --progress --delete /home/ben/music/beets/ pi@jams.local:/media/pi/music/ && rsync -av --progress --delete /home/ben/music/playlists/ pi@jams.local:/media/pi/playlists/"
alias findpkg="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias casevpn="forticlientsslvpn_cli --server vpn2.case.edu:443 --vpnuser bjf89"
alias src_lx106='export PATH="$PATH:$HOME/esp/xtensa-lx106-elf/bin"'
