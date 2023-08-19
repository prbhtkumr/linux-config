# zshell configuration ###

ZDOTDIR=~/.config/zsh/
setopt autocd extendedglob

## History in cache directory 
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000

## Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

## Emacs mode
bindkey -e

## Vi mode
#bindkey -v
#export KEYTIMEOUT=1

### Change cursor shape for different vi modes.
#function zle-keymap-select {
#  if [[ ${KEYMAP} == vicmd ]] ||
#     [[ $1 = 'block' ]]; then
#    echo -ne '\e[1 q'
#  elif [[ ${KEYMAP} == main ]] ||
#       [[ ${KEYMAP} == viins ]] ||
#       [[ ${KEYMAP} = '' ]] ||
#       [[ $1 = 'beam' ]]; then
#    echo -ne '\e[5 q'
#  fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


### Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

## Function to source files if they exist
function zsh_add_file(){
	[ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}


## Aliases
### Source Aliases from aliasrc
zsh_add_file aliasrc

## Key-bindings
### Source Key-Bindings from zsh-keybindings
zsh_add_file zsh-keybindings

## Plugins
### Function to add plugins if they don't exist
function zsh_add_plugin(){
	PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
	if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
		# For plugins
		zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.pluign"
		zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
	else
		sudo git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
	fi
}

### Syntax Highlighting
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

### AutoSuggestions
zsh_add_plugin "zsh-users/zsh-autosuggestions"

## Prompt
eval "$(starship init zsh)"
