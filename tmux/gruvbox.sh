## COLORSCHEME: gruvbox dark
set-option -g status "on"

# default statusbar color
set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

# default window title colors
set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

# default window with an activity alert
set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

# active window title colors
set-window-option -g window-status-current-style bg=default,fg=colour237 # fg=bg1

# pane border
set-option -g pane-active-border-style fg=colour250 #fg2 fg=214
set-option -g pane-border-style fg=colour237 #bg1 fg=237

# message infos
set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

# writing commands inactive
set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

# pane number display
set-option -g display-panes-active-colour colour250 #fg2
set-option -g display-panes-colour colour237 #bg1

# clock
set-window-option -g clock-mode-colour colour109 #blue

# bell
set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
set -g status-interval 100

set-option -g status-position top
set-option -g status-style none
set-option -g status-justify centre

set-option -g status-left-style none
set-option -g status-left-length "80"
set-option -g status-right-style none
set-option -g status-right-length "80"
set-window-option -g window-status-activity-style none
set-window-option -g window-status-style none
set-window-option -g window-status-separator ""

set-option -g status-left "#[fg=colour248, bg=colour241]#{prefix_highlight}"
set-option -g status-right "#[fg=colour248, bg=colour241] #S "

set-window-option -g window-status-current-format "#[fg=colour239, bg=colour248, :nobold, noitalics, nounderscore]#[fg=colour239, bg=colour214] #I |#[fg=colour239, bg=colour214, bold] #W #{?window_zoomed_flag,[Z] ,}#[fg=colour214, bg=colour237, nobold, noitalics, nounderscore]"
set-window-option -g window-status-format "#[fg=colour237,bg=colour235,noitalics]#[fg=colour223,bg=colour237] #I |#[fg=colour223, bg=colour237] #W #{?window_zoomed_flag,[Z] ,}#[fg=colour239, bg=colour237, noitalics]"
