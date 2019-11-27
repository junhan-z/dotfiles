## Swag
set -g default-terminal "screen-256color"

# messaging
set -g message-command-style fg=white,bg=black

# The modes {
setw -g clock-mode-colour colour135
setw -g mode-style fg=white,bg=black,bold
# }

# The panes {
set -g pane-border-style bg=black,fg=black
set -g pane-active-border-style bg=black,fg=green
# }

# The statusbar {
set -g status-justify left
set -g status-interval 10
set -g status-position bottom
set -g status-style bg=black
set -g status-left '#[fg=colour196,bold,dim][#S]'
set -g status-right '#[fg=colour248,bold][#(whoami)]@#[fg=colour196]#h #[fg=white]| %H:%M'
set -g status-right-length 50
set -g status-left-length 40
# yellow

# The window-status {
setw -g window-status-style fg=white,bg=black,none
setw -g window-status-format ' #I: #W '
setw -g window-status-current-style bg=white
setw -g window-status-current-format '#[fg=colour196,bold] #I-#P: #W#F '
# }

# The messages {
set -g message-style fg=white,bg=black,bold
# }
