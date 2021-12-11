#!/usr/bin/env bash
#@db
if tmux has
then
    declare -a WORKSPACE_NAME
    mapfile -t WORKSPACE_NAME < dev_default_workspaces.cfg
    
    SESSION="dev@$USER"

    for WINDOW in {1..9}
    do
        tmux new-window -t $SESSION:$WINDOW -n ${WORKSPACE_NAME[$WINDOW]}
    done
fi
