# =============================================================================
#                                   Functions
# =============================================================================
zsh_wifi_signal(){
	local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
    local color='yellow'
    [[ $signal -gt 75 ]] && color='green'
    [[ $signal -lt 50 ]] && color='red'
    echo -n "%F{$color}\uf1eb" # \uf1eb is 
}

# =============================================================================
#                                   Plugins
# =============================================================================
# powerlevel9k prompt theme
#DEFAULT_USER=$USER
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
#POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{cyan}\/%F{blue}"
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{white}\/%F{grey}"
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{grey}\u2570\uf460%f "
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="clear"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context time battery dir vcs virtualenv custom_wifi_signal)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator time_joined
                                   dir_joined dir_writable_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time vcs
                                    background_jobs_joined
									host_joined
                                    custom_wifi_signal)
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="grey"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="grey"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="grey"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="clear"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="red"
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
#POWERLEVEL9K_TIME_FORMAT="%D{\uf073 %b %d \uf017 %H:%M}" #  Jun 15  09:32
#POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}" #  Jun 15  09:32
POWERLEVEL9K_TIME_FOREGROUND="cyan"
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='magenta'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='clear'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='cyan'
POWERLEVEL9K_USER_ROOT_BACKGROUND='clear'
POWERLEVEL9K_USER_ROOT_FOREGROUND='red'
POWERLEVEL9K_USER_ICON="\uf415" # 
POWERLEVEL9K_ROOT_ICON="\u26a1" # ⚡
POWERLEVEL9K_HOST_LOCAL_BACKGROUND='clear'
POWERLEVEL9K_HOST_LOCAL_FOREGROUND='cyan'
POWERLEVEL9K_HOST_REMOTE_BACKGROUND='clear'
POWERLEVEL9K_HOST_REMOTE_FOREGROUND='magenta'
POWERLEVEL9K_HOST_ICON="\uF109" # 
POWERLEVEL9K_SSH_ICON="\uF489"  # 
POWERLEVEL9K_OS_ICON_BACKGROUND="clear"
POWERLEVEL9K_OS_ICON_FOREGROUND="grey"

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

#zplug 'plugins/bundler', from:oh-my-zsh, if:'which bundle'
#zplug 'plugins/colored-man-pages', from:oh-my-zsh
#zplug 'plugins/extract', from:oh-my-zsh
#zplug 'plugins/fancy-ctrl-z', from:oh-my-zsh
#zplug 'plugins/git', from:oh-my-zsh, if:'which git'
#zplug 'plugins/globalias', from:oh-my-zsh
#zplug 'plugins/gpg-agent', from:oh-my-zsh, if:'which gpg-agent'
#zplug 'plugins/httpie', from:oh-my-zsh, if:'which httpie'
#zplug 'plugins/nanoc', from:oh-my-zsh, if:'which nanoc'
#zplug 'plugins/nmap', from:oh-my-zsh, if:'which nmap'
#zplug 'plugins/tmux', from:oh-my-zsh, if:'which tmux'
#zplug 'plugins/vi-mode', from:oh-my-zsh

#zplug 'b4b4r07/enhancd', use:init.sh
#zplug 'b4b4r07/zsh-vimode-visual', defer:3
zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme, at:next
#zplug 'knu/zsh-manydots-magic', use:manydots-magic, defer:2
zplug 'seebi/dircolors-solarized', ignore:"*", as:plugin
zplug 'zsh-users/zsh-autosuggestions', at:develop
zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-history-substring-search'
#zplug 'zsh-users/zsh-syntax-highlighting', defer:2

#if ! zplug check; then
#  zplug install
#fi
#
#zplug load

# Supports oh-my-zsh plugins and the like
zplug 'plugins/git', from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load

if zplug check 'seebi/dircolors-solarized'; then
  if which gdircolors > /dev/null 2>&1; then
    alias dircolors='gdircolors'
  fi
  if which dircolors > /dev/null 2>&1; then
    scheme='dircolors.256dark'
    eval $(dircolors ~/.zplug/repos/seebi/dircolors-solarized/$scheme)
  fi
fi

# =============================================================================
#                                   Options
# =============================================================================

# Watching other users
WATCHFMT='%n %a %l from %m at %t.'
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
REPORTTIME=5          # Display usage statistics for commands running > 5 sec.
WORDCHARS="\'*?_-.[]~=/&;!#$%^(){}<>\'"

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Don't overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Don't display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.

# Changing directories
setopt pushd_ignore_dups        # Don't push copies of the same dir on stack.
setopt pushd_minus              # Reference stack entries with '-'.

setopt extended_glob

# =============================================================================
#                                   Aliases
# =============================================================================

# In the definitions below, you will see use of function definitions instead of
# aliases for some cases. We use this method to avoid expansion of the alias in
# combination with the globalias plugin.

# Directory coloring
if which gls > /dev/null 2>&1; then
  # Prefer GNU version, since it respects dircolors.
  ls() { gls --group-directories-first --color=auto $@ }
elif [[ $OSTYPE = (darwin|freebsd)* ]]; then
  export CLICOLOR="YES" # Equivalent to passing -G to ls.
  export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"
fi

# Directory management
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias d='dirs -v'
alias 1='pu'
alias 2='pu -2'
alias 3='pu -3'
alias 4='pu -4'
alias 5='pu -5'
alias 6='pu -6'
alias 7='pu -7'
alias 8='pu -8'
alias 9='pu -9'
pu() { pushd $1 > /dev/null 2>&1; dirs -v; }
po() { popd > /dev/null 2>&1; dirs -v }

# Generic command adaptations.
grep() { $(whence -p grep) --colour=auto $@ }
egrep() { $(whence -p egrep) --colour=auto $@ }

# OS-specific aliases
if [[ $OSTYPE = darwin* ]]; then
  # Lock screen (e.g., when leaving computer).
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false \
    && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true \
    && killall Finder"
  # Combine PDFs on the command line.
  pdfcat() {
    if [[ $# -lt 2 ]]; then
      echo "usage: $0 merged.pdf input0.pdf [input1.pdf ...]" > /dev/stderr
      return 1
    fi
    local output="$1"
    shift
    # Try pdfunite first (from Homebrew package poppler), because it's much
    # faster and doesn't perform stupid page rotations.
    if which pdfunite > /dev/null 2>&1; then
      pdfunite "$@" "$output"
    else
      local join='/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py'
      "$join" -o "$output" "$@" && open "$output"
    fi
  }
fi


# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^k' kill-line
bindkey '^d' delete-char
bindkey '^y' accept-and-hold
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line

# History
if zplug check 'zsh-users/zsh-history-substring-search'; then
  zmodload zsh/terminfo
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Do not require a space when attempting to tab-complete.
bindkey '^i' expand-or-complete-prefix

# =============================================================================
#                                 Completions
# =============================================================================

# case-insensitive (all), partial-word and then substring completion
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# =============================================================================
#                                    Other
# =============================================================================

# Overwrite oh-my-zsh's version of `globalias', which makes globbing and
# on-the-fly shell programming painful. The only difference to the original
# function definition is that we do not use the `expand-word' widget.
# See https://github.com/robbyrussell/oh-my-zsh/issues/6123 for discussion.
globalias() {
   zle _expand_alias
   #zle expand-word
   zle self-insert
}
zle -N globalias

# Utility that prints out lines that are common among $# files.
intersect() {
  local sort='sort -S 1G'
  case $# in
    (0) true;;
    (2) $sort -u "$1"; $sort -u "$2";;
    (*) $sort -u "$1"; shift; intersection "$@";;
  esac | $sort | uniq -d
}

# Changes an iTerm profile by sending a proprietary escape code that iTerm
# intercepts. This function additionally updates ITERM_PROFILE environment
# variable.
iterm-profile() {
  echo -ne "\033]50;SetProfile=$1\a"
  export ITERM_PROFILE="$1"
}

# =============================================================================
#                                   Startup
# =============================================================================

# Load SSH and GPG agents via keychain.
setup_agents() {
  [[ $UID -eq 0 ]] && return

  local -a ssh_keys gpg_keys
  ssh_keys=(~/.ssh/**/*pub(.N:r))
  gpg_keys=$(gpg -K --with-colons 2>/dev/null | awk -F : '$1 == "sec" { print $5 }')

  if which keychain > /dev/null 2>&1; then
    if (( $#ssh_keys > 0 )) || (( $#gpg_keys > 0 )); then
      eval $(keychain -q --nogui --eval --host fix \
		  --agents ssh,gpg $ssh_keys ${(f)gpg_keys})
    fi
  fi
}
setup_agents
unfunction setup_agents

# Fix alt-arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Source local customizations.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.zshrc.alias ]] && source ~/.zshrc.alias

# vim: ft=zsh

