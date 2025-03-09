# Key bindings
bindkey "^[[H" beginning-of-line   # end
bindkey "^[[F" end-of-line         # home
bindkey "^[[3~" delete-char        # del

# Auto completion
autoload -Uz compinit; compinit

zstyle ':completion:*:*:*:*:*' menu select # selection menu
zstyle ':completion:*' complete yes
zstyle ':completion:*' accept-exact yes
zstyle ':completion:*' auto-description 'specify: %d' # placeholder in prompt of current completion
zstyle ':completion:*' completer _expand _complete # globbing (filename expansion) and complete with other arguments
zstyle ':completion:*' group-name ''

zstyle ':completion:*' list-colors '' # colorize completion options
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive matcher
zstyle ':completion:*' rehash true # rebuild completion cache when installing a new command
zstyle ':completion:*' use-compctl false # disable old completion system
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,tty,cmd f' # kill command completion
zstyle ':completion:*' use-cache on # use cache to speed up some commands
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Custom prompt string
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats " (%b)"
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f%F{green}${vcs_info_msg_0_}%f %% '

# store last command name
function preexec() {
	last_cmd=$1
}

# logic before new prompt (such as newline, but only after the first command)
first_cmd=true
precmd() {
	vcs_info

	if [[ $last_cmd == "clear" || $last_cmd == "c" ]]; then
		first_cmd=true
		last_cmd=
	fi
	if [[ $first_cmd == false ]]; then
		echo
	else
		first_cmd=false
	fi
}

# Aliases
alias clear=' clear && printf "\033[3J"'
alias c=' clear'

alias ls=' ls --color=auto'
alias ll=' ls -l'
alias la=' ls -a'
alias lla=' ls -la'

alias grep='grep --color=auto'

alias sudo='sudo '
alias pacman='pacman --color=auto'

alias yay='yay --color=auto'

alias {vim,vi,v}='nvim'

alias gp='git pull'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gm='git commit -m'
alias gc='git commit'
alias gpp='git push'

# Other
setopt AUTO_CD # folders are considered as commands that cd to them, if their name is not used as a command.
export MANPAGER='nvim +Man!' # neovim manpager instead of less

# History
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

#HISTORY_IGNORE="(history|ls(| *)|cd(| *)|clear|pwd|exit)"

setopt HIST_IGNORE_SPACE         # don't record an entry starting with a space.

setopt HIST_SAVE_NO_DUPS         # don't save duplicates

setopt SHARE_HISTORY             # share history between sessions, with timestamps to ensure its correctness

## Use fzf for better history search and more
source <(fzf --zsh)
