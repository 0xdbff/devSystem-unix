#change to system's package manager
set package_manager sudo pacman 
#if yay is installed, will be default after setup
set install_args -S
set update_args -Syu

if not command -v starship &> /dev/null
    if $package_manager $install_args starship
    else 
        echo "installing starship from source"
        #TODO
    end
end

#powerline
#source /opt/homebrew/lib/python3.9/site-packages/powerline/bindings/fish/powerline-setup.fish
#powerline-setup

#prompt
starship init fish | source

#IF ANY ABBRV conflits with an important command, an issue would be appreciated
#main-util shortcuts
abbr -a f fg
abbr -a z zsh
abbr -a t touch
abbr -a sus suspend
abbr -a nv 'nvidia-settings'
abbr -a d 'rm'
abbr -a dd 'rm -rf'

#Directories abbr and setup
#make working dirs if not found
if not test -d ~/dev
        mkdir ~/dev
        if not test -d ~/dev/bin
                mkdir ~/dev/bin
        end
end 
#quick access to development dir
abbr -a cdd ~/dev
#quick access dev or beta bins
abbr -a cdb ~/dev/bin 
if not test -d ~/sh
        mkdir ~/sh
end 
#quick access to user scripts dir
abbr -a cds ~/sh
if not test -d ~/logs
        mkdir ~/logs
end 
#quick access logs performed by user
abbr -a cdl ~/logs
#quick change to software installation dirs
abbr -a cdlb ~/.local/bin
abbr -a cdB /bin/
#/opt/ better for "independent" software that doest not follow linux "rules",""
abbr -a cdo /opt/
abbr -a cdU /usr/
abbr -a cdUb /usr/bin/
abbr -a cdu /usr/local/
abbr -a cdub /usr/local/bin/
abbr -a cdul /usr/local/lib/
abbr -a cdus /usr/local/src/

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

set RE (uname -r)

#tmux commands
abbr -a Tmn  'tmux new -s'
abbr -a Tmnd 'tmux new -s dev@Darwin-$RE'
abbr -a Tmny 'tmux new -s Yakuake@$USER'
abbr -a Tmnc 'tmux new -s cli@$USER'
abbr -a Tma  'tmux attach -t'
abbr -a Tmad 'tmux attach -t dev@$USER'
abbr -a Tmay 'tmux attach -t Yakuake@$USER'
abbr -a Tmac 'tmux attach -a cli@$USER'
abbr -a Tmk  'tmux kill-session -t'
abbr -a Tmkd 'tmux kill-session -t dev@$USER'
abbr -a Tmky 'tmux kill-session -t Yakuake@$USER'
abbr -a Tmkc 'tmux kill-session -t cli@$USER'
abbr -a Tmks 'tmux kill-server'

#Git Commands
abbr -a g git
abbr -a ga 'git add -p'
abbr -a gaa 'git add -p *'

function git_test_ssh
    ssh -T git@gitlab.com
    ssh -T git@github.com
    #TODO private gitlab
end

function git_add_ssh
    ssh-add ~/.ssh/gitlab
    ssh-add ~/.ssh/github
    #TODO
    if git_test_ssh
            echo ""
            echo "all set and ready for commits"
    end
end

# add all remotes to a public repo
# gitlab, personal gitlab && github
function git_add_all_remotes
    # add url remotes
    if git remote add origin git@gitlab.com:dev-db/$argv.git
            echo "origin added as remote under ssh git@gitlab.com:dev-db/$argv.git"

            if git remote add origin_hub git@github.com:Db-Dev2002/$argv.git
                    echo "origin_hub added as remote under ssh git@github.com:Db-Dev2002/$argv.git"
                    
                    #if git remote add dblab #TODO
                            echo ""
                            echo "public remotes are ready"
                            echo ""

                            git push --set-upstream origin main
                    #   else
                    #       echo "dblab remote not added"
                    #end
                else 
                    echo "github remote not added"
            end
        else
            echo "gitlab remote not added"
    end
end

# add only gitlab & github
function git_add_public_remotes
    # add url remotes
    if git remote add origin git@gitlab.com:dev-db/$argv.git
            echo "gitlab added as remote under ssh git@gitlab.com:dev-db/$argv.git"

            if git remote add origin_hub git@github.com:Db-Dev2002/$argv.git
                    echo "github added as remote under ssh git@github.com:Db-Dev2002/$argv.git"
                    echo ""
                    echo "public remotes are ready"
                    echo ""
                    
                    git push --set-upstream origin main
                else 
                    echo "github remote not added"
            end
        else
            echo "gitlab remote not added"
    end
end

function git_delete_added_remotes
    #test if the remote exists, then remove it
    if git remote get-url origin &> /dev/null 
            if git remote remove origin
                    echo "remote gitlab removed"
            end
    end
    if git remote get-url origin_hub &> /dev/null
            if git remote remove origin_hub
                    echo "remote github removed"
            end
    end
    if git remote get-url origin_db &> /dev/null
            if git remote remove origin_db
                    echo "remote dblab removed"
            end
    end
end

# add to .gitignore on the current path
# function atgi $argv

function mkcd 
    if test -d $argv
            echo "dir already exits"
            cd ./$argv
            exit 0
        else
            if mkdir -p $argv
                    cd ./$argv
            else
                    echo "mkdir failed"
            end
    end
end 

abbr -a mkd 'mkdir -p' 
# abbr -a mkdp 'mkdir -p -m a=rwx'

abbr -a graa 'git_add_all_remotes'
abbr -a grap 'git_add_public_remotes'
abbr -a grd  'git_delete_added_remotes'
abbr -a gas  'git_add_ssh'
abbr -a gts  'git_test_ssh'
abbr -a gb   'git branch'
abbr -a gs   'git status'
abbr -a gch  'git checkout'
abbr -a gcb  'git checkout branch '
abbr -a clo  'git clone'
abbr -a gcl  'git clean'
abbr -a gcm  'git commit -a -m "'
abbr -a gfe  'git fetch'
abbr -a gi   'git init'
abbr -a gil  'git logs'
abbr -a gm   'git merge'
#push public repos to all remotes
abbr -a gpa 'git push -u origin & git push origin_hub main'
abbr -a gpp  'git push -u origin_dblab'
abbr -a gp   'git push'

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

# complete --command yay --wraps pacman

if command -v yay > /dev/null
	abbr -a p 'yay -S'
	abbr -a up 'yay -Syu'
    else
        abbr -a p '$package_manager $install_args'
	abbr -a up '$package_manager $update_args' 
end

if command -v exa > /dev/null
        alias Ltg  'exa -laFTS --no-permissions --octal-permissions --group-directories-first --time-style iso'
        alias Lt   'exa -laFTS -I .git --no-permissions --octal-permissions --group-directories-first --time-style iso'
        alias L    'exa -laFS --no-permissions --octal-permissions --group-directories-first --time-style iso'
        alias llt  'exa -1aFT --group-directories-first'
        alias ll   'exa -1aF --group-directories-first'
        alias lt   'exa -1FT --group-directories-first'
        alias l    'exa -1F --group-directories-first'
    else
	    abbr -a l  'ls'
	    abbr -a ll 'ls -l'
	    abbr -a L  'ls -la'
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end


function fish_greeting
	echo
	echo -e (uname -rs | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime  | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
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
