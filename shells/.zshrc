[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/db/.config/zsh/zsh_abbr/zsh-abbr.zsh
source /usr/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

eval "$(starship init zsh)"

function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

if [[ $(ps --no-header -p $PPID -o comm) =~ '^alacritty$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

