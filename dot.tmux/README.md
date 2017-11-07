Install themes using Tmux Plugin Manager

Add plugin to the list of TPM plugins in .tmux.conf:

set -g @plugin 'jimeh/tmux-themepack'
Hit prefix + I to fetch the plugin and source it. The plugin should now be working.

You can pick and choose a theme via .tmux.conf option:

set -g @themepack 'block/blue' (default)
set -g @themepack 'block/cyan'
set -g @themepack 'default/gray'
set -g @themepack 'double/megenta'

Installation

Requirements: tmux version 1.9 (or higher), git, bash.

Clone TPM:

$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
Put this at the bottom of .tmux.conf:

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
Reload TMUX environment so TPM is sourced:

# type this in terminal
$ ln -sf ~/.tmux/tmux.conf ~/.tmux.conf
$ tmux source ~/.tmux.conf
