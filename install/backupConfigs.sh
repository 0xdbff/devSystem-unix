#!/usr/bin/env fish
#@db
#your backup path here
set backup_path ~/dev/devConfig_files_GNU-Linux
cd $backup_path

if not test -d $backup_path
    mkdir ~/dev/
    cd ~/dev/
    git clone https://github.com/Db-Dev2002/devConfig_files_GNU-Linux
    cd ./devConfig_files_GNU-Linux
end

#to avoid merge conflicts
echo "git pull"
git pull
echo ""
echo "Replacing files:"

cp -rf ~/.config/alacritty/* ~/dev/devConfig_files_GNU-Linux/alacritty/
cp -rf ~/.config/fontconfig/* ~/dev/devConfig_files_GNU-Linux/fonts/
cp -rf ~/.config/yakuakerc ~/dev/devConfig_files_GNU-Linux/more_terminals/Yakuake/
cp -rf ~/.config/nvim/ ~/dev/devConfig_files_GNU-Linux/
cp -rf ~/.bashrc ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.fzf.bash ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.zshrc ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.fzf.zsh ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.gitconfig ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.tmux.conf ~/dev/devConfig_files_GNU-Linux/tmux/
cp -rf ~/.config/starship.toml ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.config/zsh/ ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.config/fish/ ~/dev/devConfig_files_GNU-Linux/shells/
cp -rf ~/.vscode/* ~/dev/devConfig_files_GNU-Linux/vsCode

echo "Config files backed up on --> $backup_path"

