# Setup fzf
# ---------
if [[ ! "$PATH" == */home/db/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/db/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/db/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/db/.fzf/shell/key-bindings.zsh"
