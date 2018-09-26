# =============================================================================
#                                   Functions
# =============================================================================
powerlevel9k_random_color(){
	printf "%03d" $[${RANDOM}%234+16] #random between 16-250
}

zsh_wifi_signal(){
	local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
	local color="yellow"
	[[ $signal -gt 75 ]] && color="green"
	[[ $signal -lt 50 ]] && color="red"
	echo -n "%F{$color}\uf1eb" # \uf1eb is 
}

# =============================================================================
#                                   Variables
# =============================================================================
# Common ENV variables
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export EDITOR="nvim"

# Fix Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

export FZF_DEFAULT_OPTS="--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5"

export ENHANCD_FILTER="fzf:peco:percol"
export ENHANCD_COMMAND="c"

#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
	#export CLICOLOR="YES" # Equivalent to passing -G to ls.
	#export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"
	#export LS_OPTIONS='-G'
	export CLICOLOR=true
	export LSCOLORS='exfxcxdxbxGxDxabagacad'

	#[ -d "/opt/local/bin" ] && export PATH="/opt/local/bin:$PATH"

	## Prefer GNU version, since it respects dircolors.
	#if (( $+commands[gls] )); then
	#	alias ls='() { $(whence -p gls) -Ctr --file-type --color=auto $@ }'
	#else
	#	alias ls='() { $(whence -p ls) -CFtr $@ }'
	#fi
fi

if [[ $OSTYPE = (linux)* ]]; then
	export LS_OPTIONS='--color=auto'
fi

# alias
alias rm="rm -v"
alias ls="ls $LS_OPTIONS -hFtr"
alias ll="ls $LS_OPTIONS -lAhFtr"
#alias cd..="cd .."
#alias ..="cd .."
alias dig="dig +short +noshort"

disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output

# =============================================================================
#                                   Plugins
# =============================================================================
# Check if zplug is installed

[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
#zplug 'themes/sorin', from:oh-my-zsh, as:theme

# oh-my-zsh
#zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

# Load theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, from:github, at:next, as:theme
#zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#zplug "aaronjamesyoung/aaron-zsh-theme", use:aaron.zsh-theme, from:github, as:theme
#zplug "gporrata/bklyn-zsh"

#zplug "themes/spaceship", from:oh-my-zsh, as:theme
#zplug "dracula/zsh", from:github, as:theme
#zplug "geometry-zsh/geometry", from:github, as:theme
#zplug "mafredri/zsh-async", from:github
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
#zplug "eendroroy/alien", from:github, as:theme

zplug "chrissicool/zsh-256color"
zplug "mollifier/anyframe"

# Miscellaneous commands
#zplug "andrewferrier/fzf-z"
zplug "k4rthik/git-cal", as:command
zplug "peco/peco", as:command, from:gh-r, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin
#zplug "b4b4r07/easy-oneliner", if:"which fzf", on:"junegunn/fzf-bin"

# Enhanced cd
zplug "b4b4r07/enhancd", use:init.sh

# Bookmarks and jump
zplug "jocelynmallon/zshmarks"

# Enhanced dir list with git features
zplug "supercrabtree/k"

# Jump back to parent directory
zplug "tarrasch/zsh-bd"

# Simple zsh calculator
zplug "arzzen/calc.plugin.zsh"

# Directory colors
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
zplug "pinelibg/dircolors-solarized-zsh"

zplug "plugins/common-aliase",     from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
#zplug "plugins/colorize",          from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/encode64",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/tmuxinator",        from:oh-my-zsh
zplug "plugins/urltools",          from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh
zplug "plugins/z",                 from:oh-my-zsh
zplug "plugins/fancy-ctrl-z",      from:oh-my-zsh

# Supports oh-my-zsh plugins and the like
if [[ $OSTYPE = (linux)* ]]; then
	zplug "plugins/archlinux",     from:oh-my-zsh, if:"(( $+commands[pacman] ))"
	zplug "plugins/dnf",           from:oh-my-zsh, if:"(( $+commands[dnf] ))"
	zplug "plugins/mock",           from:oh-my-zsh, if:"(( $+commands[mock] ))"
fi

if [[ $OSTYPE = (darwin)* ]]; then
	zplug "lib/clipboard",         from:oh-my-zsh
	zplug "plugins/osx",           from:oh-my-zsh
	zplug "plugins/brew",          from:oh-my-zsh, if:"(( $+commands[brew] ))"
	zplug "plugins/macports",      from:oh-my-zsh, if:"(( $+commands[port] ))"
fi

zplug "plugins/git",               from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/golang",            from:oh-my-zsh, if:"(( $+commands[go] ))"
zplug "plugins/svn",               from:oh-my-zsh, if:"(( $+commands[svn] ))"
zplug "plugins/node",              from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm",               from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/bundler",           from:oh-my-zsh, if:"(( $+commands[bundler] ))"
zplug "plugins/gem",               from:oh-my-zsh, if:"(( $+commands[gem] ))"
zplug "plugins/rvm",               from:oh-my-zsh, if:"(( $+commands[rvm] ))"
zplug "plugins/pip",               from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo",              from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"(( $+commands[gpg-agent] ))"
zplug "plugins/systemd",           from:oh-my-zsh, if:"(( $+commands[systemctl] ))"
zplug "plugins/docker",            from:oh-my-zsh, if:"(( $+commands[docker] ))"
zplug "plugins/docker-compose",    from:oh-my-zsh, if:"(( $+commands[docker-compose] ))"

#zplug "djui/alias-tips"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# =============================================================================
#                                   Options
# =============================================================================
#autoload -Uz add-zsh-hook
#autoload -Uz compinit && compinit -u
#autoload -Uz url-quote-magic
#autoload -Uz vcs_info

#zle -N self-insert url-quote-magic

setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt auto_list
setopt auto_menu
setopt auto_pushd
#setopt extended_history
setopt extended_history         # Also record time and duration of commands.
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt hist_ignore_space        # Ignore commands that start with space.
#setopt hist_ignore_all_dups
#setopt hist_ignore_dups
#setopt hist_reduce_blanks
#setopt hist_save_no_dups
#setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
#setopt rm_star_wait
setopt share_history            # Share history between multiple shells
setopt transient_rprompt

## Changing directories
#setopt auto_pushd
#setopt pushd_ignore_dups        # Dont push copies of the same dir on stack.
#setopt pushd_minus              # Reference stack entries with "-".
#
#setopt extended_glob

bindkey -v
bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete
#bindkey '^@' anyframe-widget-cd-ghq-repository
#bindkey '^r' anyframe-widget-put-history

#alias vi='vim'
#alias ll="ls -lh"
#alias la="ls -lah"

#function cd() {
#	builtin cd $@ && ls;
#}

#source ~/.zplug/init.zsh

# improved less option
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS"

# Watching other users
#WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
REPORTTIME=5          # Display usage statistics for commands running > 5 sec.

# Key timeout and character sequences
KEYTIMEOUT=1
WORDCHARS='*?_-[]~=./&;!#$%^(){}<>'

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
#bindkey "^[[C" forward-word
#bindkey "^[[D" backward-word

## Emulate tcsh's backward-delete-word
#tcsh-backward-kill-word () {
#    local WORDCHARS="${WORDCHARS:s#/#}"
#    zle backward-kill-word
#}
#zle -N tcsh-backward-kill-word

# https://github.com/sickill/dotfiles/blob/master/.zsh.d/key-bindings.zsh
tcsh-backward-word () {
local WORDCHARS="${WORDCHARS:s#./#}"
zle emacs-backward-word
}
zle -N tcsh-backward-word
bindkey '\e[1;3D' tcsh-backward-word
bindkey '\e^[[D' tcsh-backward-word # tmux

tcsh-forward-word () {
local WORDCHARS="${WORDCHARS:s#./#}"
zle emacs-forward-word
}
zle -N tcsh-forward-word
bindkey '\e[1;3C' tcsh-forward-word
bindkey '\e^[[C' tcsh-backward-word # tmux

tcsh-backward-delete-word () {
local WORDCHARS="${WORDCHARS:s#./#}"
zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey "^[^?" tcsh-backward-delete-word # urxvt

# =============================================================================
#                                   Startup
# =============================================================================

# Load SSH and GPG agents via keychain.
setup_agents() {
	[[ $UID -eq 0 ]] && return

	if (( $+commands[keychain] )); then
		local -a ssh_keys gpg_keys
		for i in ~/.ssh/**/*pub; do test -f "$i(.N:r)" && ssh_keys+=("$i(.N:r)"); done
		gpg_keys=$(gpg -K --with-colons 2>/dev/null | awk -F : '$1 == "sec" { print $5 }')
		if (( $#ssh_keys > 0 )) || (( $#gpg_keys > 0 )); then
			alias run_agents='() { $(whence -p keychain) --quiet --eval --inherit any-once --agents ssh,gpg $ssh_keys ${(f)gpg_keys} }'
			#[[ -t ${fd:-0} || -p /dev/stdin ]] && eval `run_agents`
			unalias run_agents
		fi
	fi
}

setup_agents
unfunction setup_agents

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
	printf "Install plugins? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

if zplug check "sindresorhus/pure"; then
	PURE_CMD_MAX_EXEC_TIME=0
	PURE_PROMPT_SYMBOL="%F{124}➜ %f"
	#PURE_PROMPT_SYMBOL="%F{124}⇢  %f"
fi

if zplug check "geometry-zsh/geometry"; then
	GEOMETRY_PROMPT_PLUGINS=(git exec_time)

	GEOMETRY_COLOR_EXIT_VALUE="magenta"         # prompt symbol color when exit value is != 0

	PROMPT_GEOMETRY_EXEC_TIME=true
	PROMPT_GEOMETRY_COMMAND_MAX_EXEC_TIME=0

	PROMPT_GEOMETRY_COLORIZE_ROOT=true
	PROMPT_GEOMETRY_RPROMPT_ASYNC=true
	PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
fi

if zplug check "mollifier/anyframe"; then
	# expressly specify to use peco
	#zstyle ":anyframe:selector:" use peco
	# expressly specify to use percol
	#zstyle ":anyframe:selector:" use percol
	# expressly specify to use fzf-tmux
	#zstyle ":anyframe:selector:" use fzf-tmux
	# expressly specify to use fzf
	zstyle ":anyframe:selector:" use fzf

	# specify path and options for peco, percol, or fzf
	#zstyle ":anyframe:selector:peco:" command 'peco --no-ignore-case'
	#zstyle ":anyframe:selector:percol:" command 'percol --case-sensitive'
	#zstyle ":anyframe:selector:fzf-tmux:" command 'fzf-tmux --extended'
	#zstyle ":anyframe:selector:fzf:" command 'fzf --extended'
	#zstyle ":anyframe:selector:fzf:" command 'fzf'

	#bindkey '^@' anyframe-widget-cd-ghq-repository
	#bindkey '^r' anyframe-widget-put-history
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
	zmodload zsh/terminfo
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
	bindkey "^[[1;5A" history-substring-search-up
	bindkey "^[[1;5B" history-substring-search-down
fi

if zplug check "zsh-users/zsh-syntax-highlighting"; then
	typeset -A ZSH_HIGHLIGHT_STYLES ZSH_HIGHLIGHT_PATTERNS

	ZSH_HIGHLIGHT_STYLES[cursor]='bg=yellow'
	ZSH_HIGHLIGHT_STYLES[globbing]='none'
	ZSH_HIGHLIGHT_STYLES[path]='fg=white'
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
	ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
	ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'

	#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23"
	#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=162'
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
	ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
fi

if zplug check "b4b4r07/enhancd"; then
	ENHANCD_DOT_SHOW_FULLPATH=1
	ENHANCD_DISABLE_HOME=0
fi

if zplug check "b4b4r07/zsh-history-enhanced"; then
	ZSH_HISTORY_FILE="$HISTFILE"
	ZSH_HISTORY_FILTER="fzf:peco:percol"
	ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
	ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
fi

if zplug check "denysdovhan/spaceship-prompt"; then
	SPACESHIP_PROMPT_ORDER=(
	# time        # Time stampts section (Disabled)
	user          # Username section
	dir           # Current directory section
	host          # Hostname section
	git           # Git section (git_branch + git_status)
	exec_time     # Execution time
	line_sep      # Line break
	battery       # Battery level and status
	jobs          # Background jobs indicator
	char          # Prompt character
	)

	SPACESHIP_RPROMPT_ORDER=(
	exit_code     # Exit code section
	time
	)

	SPACESHIP_TIME_SHOW=true
	SPACESHIP_EXIT_CODE_SHOW=true

	SPACESHIP_PROMPT_SEPARATE_LINE=false
	SPACESHIP_PROMPT_ADD_NEWLINE=true

	#SPACESHIP_PROMPT_SEPARATE_LINE=false
	#SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true

	#PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
	#RPROMPT='[%F{yellow}%?%f]'
fi

if zplug check "bhilburn/powerlevel9k"; then
	#DEFAULT_USER=$USER

    # Easily switch primary foreground/background colors
	#DEFAULT_FOREGROUND=038 DEFAULT_BACKGROUND=024 PROMPT_COLOR=038

    DEFAULT_FOREGROUND=006 DEFAULT_BACKGROUND=235 PROMPT_COLOR=173
	DEFAULT_FOREGROUND=198 DEFAULT_BACKGROUND=090 PROMPT_COLOR=173
	DEFAULT_FOREGROUND=235 DEFAULT_BACKGROUND=159 PROMPT_COLOR=173
	DEFAULT_FOREGROUND=123 DEFAULT_BACKGROUND=059 PROMPT_COLOR=183
	DEFAULT_FOREGROUND=159 DEFAULT_BACKGROUND=238 PROMPT_COLOR=173
	DEFAULT_FOREGROUND=159 DEFAULT_BACKGROUND=239 PROMPT_COLOR=172
    #DEFAULT_COLOR=$DEFAULT_FOREGROUND
    DEFAULT_COLOR="clear"

    P9K_MODE="nerdfont-complete"
    P9K_DIR_SHORTEN_LENGTH=1
    #P9K_SHORTEN_STRATEGY="truncate_right"

    P9K_DIR_OMIT_FIRST_CHARACTER=false

    P9K_CONTEXT_ALWAYS_SHOW=true
    P9K_CONTEXT_ALWAYS_SHOW_USER=false

    #P9K_CONTEXT_TEMPLATE="\uF109 %m"

    #P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"
    #P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"

	#P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{$DEFAULT_BACKGROUND}\ue0b0%f"
	#P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{$DEFAULT_BACKGROUND}\ue0b2%f"
	P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{232}\uE0BD%f"
	P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{232}\uE0BD%f"
	#P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{000}%f"
	#P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{000}／%f" # 
	#P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{000}／%f" #
	#P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{$(( $DEFAULT_BACKGROUND - 3 ))}／%f"
	#P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{$(( $DEFAULT_BACKGROUND - 3 ))}／%f"
	#P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{$DEFAULT_FOREGROUND}\uE0B0%f"
	#P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{$DEFAULT_FOREGROUND}\uE0B3%f"

    #P9K_LEFT_SEGMENT_SEPARATOR_ICON="\uE0B4"
    #P9K_RIGHT_SEGMENT_SEPARATOR_ICON="\uE0B6"
	P9K_LEFT_SEGMENT_SEPARATOR_ICON='▓▒░'
	P9K_RIGHT_SEGMENT_SEPARATOR_ICON='░▒▓'
	#P9K_LEFT_SEGMENT_SEPARATOR_ICON="\uE0BC\u200A"
	#P9K_RIGHT_SEGMENT_SEPARATOR_ICON="\u200A\uE0BA"
	#P9K_LEFT_SEGMENT_SEPARATOR_ICON="\uE0BC"
	#P9K_RIGHT_SEGMENT_SEPARATOR_ICON="\uE0BA"
	#P9K_LEFT_SEGMENT_SEPARATOR_ICON="%F{$DEFAULT_BACKGROUND}\uE0BC%f"
	#P9K_RIGHT_SEGMENT_SEPARATOR_ICON="%F{$DEFAULT_BACKGROUND}\uE0BA%f"

    P9K_PROMPT_ON_NEWLINE=true
    P9K_RPROMPT_ON_NEWLINE=false

    P9K_STATUS_VERBOSE=true
    P9K_STATUS_CROSS=true
    P9K_PROMPT_ADD_NEWLINE=true

	P9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON="%F{$PROMPT_COLOR}%f"
	P9K_MULTILINE_LAST_PROMPT_PREFIX_ICON="%F{$PROMPT_COLOR}➜  %f"

    # P9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir_writable dir vcs)
	# P9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time ssh)

	#P9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir_writable dir_joined vcs)
	#P9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir_joined vcs)
	#P9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator exec_time background_jobs time)
	P9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir dir_writable vcs)
	P9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time)

	P9K_MODE='nerdfont-complete'

	P9K_VCS_GIT_GITHUB_ICON=""
	P9K_VCS_GIT_BITBUCKET_ICON=""
	P9K_VCS_GIT_GITLAB_ICON=""
	P9K_VCS_GIT_ICON=""

	P9K_VCS_CLEAN_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_VCS_CLEAN_FOREGROUND="010"

	P9K_VCS_MODIFIED_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_VCS_MODIFIED_FOREGROUND="011"

	P9K_VCS_UNTRACKED_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_VCS_UNTRACKED_FOREGROUND="012"
	P9K_VCS_UNTRACKED_FOREGROUND="011"

	P9K_DIR_HOME_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_DIR_HOME_FOREGROUND="158"
	P9K_DIR_HOME_SUBFOLDER_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_DIR_HOME_SUBFOLDER_FOREGROUND="158"
	P9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
	P9K_DIR_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_DIR_DEFAULT_FOREGROUND="158"
	P9K_DIR_ETC_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_DIR_ETC_FOREGROUND="158"
	P9K_DIR_NOT_WRITABLE_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_DIR_NOT_WRITABLE_FOREGROUND="158"

	P9K_ROOT_INDICATOR_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_ROOT_INDICATOR_FOREGROUND="red"

	P9K_STATUS_OK_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_STATUS_OK_FOREGROUND="green"
	P9K_STATUS_ERROR_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_STATUS_ERROR_FOREGROUND="red"

	#P9K_TIME_FORMAT="%D{%H:%M:%S \uf017}" #  Jun 15  09:32
	P9K_TIME_ICON="\uF017" # 
	#P9K_TIME_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
	P9K_TIME_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_TIME_FOREGROUND="183"

	P9K_COMMAND_EXECUTION_TIME_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_COMMAND_EXECUTION_TIME_FOREGROUND="183"
	P9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
	P9K_COMMAND_EXECUTION_TIME_PRECISION=1

	P9K_BACKGROUND_JOBS_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_BACKGROUND_JOBS_FOREGROUND="123"

	P9K_USER_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_USER_DEFAULT_FOREGROUND="cyan"
	P9K_USER_SUDO_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_USER_SUDO_FOREGROUND="magenta"
	P9K_USER_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_USER_ROOT_FOREGROUND="red"
	P9K_USER_DEFAULT_ICON="\uF415" # 
	P9K_USER_ROOT_ICON=$'\uFF03' # ＃

	P9K_CONTEXT_TEMPLATE="\uF109 %m"
	#P9K_CONTEXT_TEMPLATE="\uF109 %m"
	P9K_CONTEXT_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_CONTEXT_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
	P9K_CONTEXT_DEFAULT_FOREGROUND="123"
	P9K_CONTEXT_SUDO_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_CONTEXT_SUDO_FOREGROUND="$DEFAULT_FOREGROUND"
	P9K_CONTEXT_SUDO_FOREGROUND="123"
	P9K_CONTEXT_REMOTE_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_CONTEXT_REMOTE_FOREGROUND="$DEFAULT_FOREGROUND"
	P9K_CONTEXT_REMOTE_FOREGROUND="123"
	P9K_CONTEXT_REMOTE_SUDO_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_CONTEXT_REMOTE_SUDO_FOREGROUND="$DEFAULT_FOREGROUND"
	P9K_CONTEXT_REMOTE_SUDO_FOREGROUND="123"
	P9K_CONTEXT_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_CONTEXT_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
	P9K_CONTEXT_ROOT_FOREGROUND="123"

	P9K_HOST_LOCAL_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_HOST_LOCAL_FOREGROUND="cyan"
	P9K_HOST_REMOTE_BACKGROUND="$DEFAULT_BACKGROUND"
	#P9K_HOST_REMOTE_FOREGROUND="magenta"
	P9K_HOST_LOCAL_ICON="\uF109 " # 
	P9K_SSH_ICON="\uF489 "  # 
	#P9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
	P9K_SSH_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_SSH_FOREGROUND="212"
	#P9K_OS_ICON_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
	P9K_OS_ICON_BACKGROUND="$DEFAULT_BACKGROUND"
	P9K_OS_ICON_FOREGROUND="212"
	#P9K_SHOW_CHANGESET=true
fi

# Then, source plugins and add commands to $PATH
zplug load

# Source defined functions.
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# Source local customizations.
[[ -f ~/.zsh_rclocal ]] && source ~/.zsh_rclocal

# Source exports and aliases.
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# =============================================================================
#                                 Completions
# =============================================================================
zstyle ':completion:' completer _complete _match _approximate
zstyle ':completion:' group-name ''
#zstyle ':completion:' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:' use-cache true
zstyle ':completion:' verbose yes
zstyle ':completion::default' menu select=2
zstyle ':completion::descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

# case-insensitive (uppercase from lowercase) completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# process completion
#zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'
#zstyle ':completion:*:*:git:*' script ~/.git-completion.sh


zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
	"m:{a-zA-Z}={A-Za-z}" \
	"r:|[._-]=* r:|=*" \
	"l:|=* r:|=*"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

#ZLE_RPROMPT_INDENT=0

#echo "P9K background color: $DEFAULT_BACKGROUND"

# vim: ft=zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

