use this function on alacritty's default shell, script syntax for zsh or bash, place it on bashrc or zshrc (/home/user/->), Then change transparency on alacritty's config file (/home/user/.config/alacritty/alacritty.yml) Its a kwinScript so kde plasma desktop will be nedded!

if [[ $(ps --no-header -p $PPID -o comm) =~ '^alacritty$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

