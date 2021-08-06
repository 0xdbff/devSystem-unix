#change to system's package manager
set package_manager sudo pacman 
#if yay is installed, will be default after setup
set install_args -S
set update_args -Syu

if not command -v starship > /dev/null
    if $package_manager $install_args starship
    else 
        echo "installing starship from source"

    end
end

#powerline
source /usr/lib/python3.9/site-packages/powerline/bindings/fish/powerline-setup.fish
powerline-setup

starship init fish | source

#IF ANY ABBRV conflits with an important command, an issue would be appreciated
#main-util shortcuts
abbr -a f fg
abbr -a z zsh
abbr -a t touch
abbr -a sus suspend
abbr -a nv 'nvidia-settings'
abbr -a d 'rm -r'

#make working dirs if not found
if not test -d ~/dev
    mkdir ~/dev
end #quick access to development dir
    abbr -a cdd ~/dev
if not test -d ~/sh
    mkdir ~/sh
end #quick access to user scripts dir
    abbr -a cds ~/sh
if not test -d ~/logs
    mkdir ~/logs
end #quick access logs performed by user
    abbr -a cdl ~/logs

#quick development setup if not found
#if command -v nvim and alacritty
    #    echo "fine"


#shutdown..supend..rr..cli_graphical-><-mode
abbr -a yr 'cal -y'

abbr -a c cargo
abbr -a cb 'cargo build'
abbr -a crr 'cargo run --release'
abbr -a cr 'cargo run'
abbr -a ct 'cargo t'

#tmux commands
#capital T to avoid coflicts
abbr -a Tmn 'tmux new'
abbr -a Tmnd 'tmux new -s dev@$USER'
abbr -a Tmny 'tmux new -s Yakuake@$USER'
abbr -a Tmnc 'tmux new -s cli@$USER'
abbr -a Tma 'tmux attach -t'
abbr -a Tmad 'tmux attach -t dev@$USER'
abbr -a Tmay 'tmux attach -t Yakuake@$USER'
abbr -a Tmac 'tmux attach -a cli@$USER'
abbr -a Tmk 'tmux kill-session -t'
abbr -a Tmkd 'tmux kill-session -t dev@$USER'
abbr -a Tmky 'tmux kill-session -t Yakuake@$USER'
abbr -a Tmkc 'tmux kill-session -t cli@$USER'
abbr -a Tmks 'tmux kill-server'
abbr -a Tmd 'tmux detach'
abbr -a Tm 'tmux'

#Git Commands
abbr -a g git
abbr -a ga 'git add -p'
abbr -a gaa 'git add -p .'
abbr -a gaA 'git add -p -A'
abbr -a grh 'git remote add origin_hub' #origin github, public stuff for copilot
abbr -a grl 'git remote add origin_lab' #origin gitlab, public stuff
abbr -a grll 'git remote add origin_dblab' #own gitlab server
# add all remotes to a public repo
# gitlab, personal gitlab && github
function add_all_remotes $repo_name
    if git remote add origin_lab https://gitlab.com/dev-db/$repo_name
        if git remote add origin_hub 
            if git remote add origin_dblab https
                echo "all remotes are ready!"
            else #only git lab failed at this stage
                echo "db gitlab failed! or has no repo $repo_name"
            end
        else #no info on db_gitlab, gitlab worked, github failed
            echo "github failed! or has no repo $repo_name"
        end
    else #if gitlab failed we can assume the other will as well
        echo "gitlab failed! or has no repo $repo_name, aborting"
    end
end
#git remote add all abbr
abbr -a gra 'add_all_remotes'
abbr -a gb 'git branch'
abbr -a gch 'git checkout'
abbr -a clo 'git clone'
abbr -a gcl 'git clean'
abbr -a gcm 'git commit -m "'
abbr -a gfe 'git fetch'
abbr -a gi 'git init'
abbr -a gil 'git logs'
abbr -a gm 'git merge'
#push public repos to all remotes
abbr -a gpa ' 
if git push -u origin_lab
    git push -u origin_hub
    git push -u origin_dblab
end'
abbr -a gpp 'git push -u origin_dblab'
abbr -a gp 'git push'




abbr -a vimdiff 'nvim -d'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'



#if tmux not found, yay as arch package manager



abbr -a n 'nvim .'

abbr -a cl 'clear'
abbr -a m make
abbr -a o xdg-open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a ks 'keybase chat send'
abbr -a kr 'keybase chat read'
abbr -a kl 'keybase chat list'
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'

complete --command yay --wraps pacman

if command -v yay > /dev/null
	abbr -a p 'yay -S'
	abbr -a up 'yay -Syu'
else
	abbr -a p '$package_manager $install_args'
	abbr -a up '$package_manager $update_args' 
end

if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end


function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper)' | \
		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
		paste -sd ''\
	)
	echo

	echo -e " \\e[1mNetwork:\\e[0m"
	echo
	# http://tdt.rocks/linux_network_interface_naming.html
	echo -ne (\
		ip addr show up scope global | \
			grep -E ': <|inet' | \
			sed \
				-e 's/^[[:digit:]]\+: //' \
				-e 's/: <.*//' \
				-e 's/.*inet[[:digit:]]* //' \
				-e 's/\/.*//'| \
			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
			sort | \
			column -t -R1 | \
			# public addresses are underlined for visibility \
			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
			# private addresses are not \
			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
			# unknown interfaces are cyan \
			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
			# ethernet interfaces are normal \
			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
			# wireless interfaces are purple \
			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
			# wwan interfaces are yellow \
			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
			sed 's/$/\\\e[0m/' | \
			sed 's/^/\t/' \
		)
	echo

	set r (random 0 100)
	if [ $r -lt 5 ] # only occasionally show backlog (5%)
		echo -e " \e[1mBacklog\e[0;32m"
		set_color blue
		echo "  [project] <description>"
		echo
	end

	set_color normal
	echo -e " \e[1mTODOs\e[0;32m"
	echo
	if [ $r -lt 10 ]
		# unimportant, so show rarely
		set_color cyan
		# echo "  [project] <description>"
	end
	if [ $r -lt 25 ]
		# back-of-my-mind, so show occasionally
		set_color green
		# echo "  [project] <description>"
	end
	if [ $r -lt 50 ]
		# upcoming, so prompt regularly
		set_color yellow
		# echo "  [project] <description>"
	end

	# urgent, so prompt always
	set_color red
	# echo "  [project] <description>"


	set_color normal
end
