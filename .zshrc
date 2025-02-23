# Auto completion
autoload -Uz compinit
compinit

# Key bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# Custom prompt string
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats " (%b)"
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f%F{green}${vcs_info_msg_0_}%f %# '

# store last command name
function preexec() {
	last_cmd=$1
}

# logic before new prompt (such as newline, but only after the first command)
first_cmd=true
precmd() {
	vcs_info

	if [[ $last_cmd == "clear" ]]; then
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

alias ls=' ls --color=auto'
alias ll=' ls -l'
alias la=' ls -a'
alias lla=' ls -la'

alias grep='grep --color=auto'

alias sudo='sudo '
alias pacman='pacman --color=auto'

alias yay='yay --color=auto'

alias {vim,vi,v}='nvim'

# Other
setopt AUTO_CD # folders are considered as commands that cd to them
export MANPAGER='nvim +Man!' # neovim manpager instead of less

# History
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

HISTORY_IGNORE="(history|ls(| *)|cd(| *)|clear|pwd|exit)"

setopt HIST_IGNORE_SPACE         # don't record an entry starting with a space.

setopt HIST_SAVE_NO_DUPS         # don't save duplicates

setopt SHARE_HISTORY             # share history between sessions, with timestamps to ensure its correctness

## Use fzf for better history search and more
source <(fzf --zsh)
