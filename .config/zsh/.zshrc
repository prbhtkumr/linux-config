# zshell configuration
ZDOTDIR=~/.config/zsh
setopt autocd extendedglob
setopt interactive_comments
setopt appendhistory

## History in cache directory 
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000

## Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case Insensitive completion
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

### fzf-tab configuration
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Set up fzf key bindings 
source <(fzf --zsh)

## Emacs mode
bindkey -e

## Vi mode
#bindkey -v
#export KEYTIMEOUT=1

## Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

## Aliases
### Source Aliases from aliasrc
#zsh_add_file aliasrc

## Key-bindings
### Source Key-Bindings from zsh-keybindings
#zsh_add_file zsh-keybindings

## Plugins
### Function to add plugins if they don't exist
function zsh_add_plugin(){
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        sudo git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

### Syntax Highlighting
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

### AutoSuggestions
zsh_add_plugin "zsh-users/zsh-autosuggestions"

### FZF tab
zsh_add_plugin "Aloxaf/fzf-tab"

## Prompt
eval "$(starship init zsh)"

