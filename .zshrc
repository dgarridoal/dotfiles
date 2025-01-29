# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Homebrew
export PATH=/opt/homebrew/bin:$PATH


if [[ $- == *i* ]]; then
    # Commands to run in interactive sessions can go here
fi


if [[ "$(uname)" == "Darwin" ]]; then
    # macOS
    BREW_BIN="/opt/homebrew/bin"
else
    # Linux
    BREW_BIN="/home/linuxbrew/.linuxbrew/bin"
fi

# Usar la variable BREW_BIN donde se necesite
eval "$($BREW_BIN/brew shellenv)"

source $(dirname $BREW_BIN)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(dirname $BREW_BIN)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(dirname $BREW_BIN)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source $(dirname $BREW_BIN)/share/powerlevel10k/powerlevel10k.zsh-theme


export PROJECT_PATHS="/Users/mrcajuka/Works"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exlude .git"

WM_VAR="/$ZELLIJ"
WM_CMD="zellij"

function start_if_needed() {
    if [[ $- == *i* ]] && [[ $TERM_PROGRAM == "WezTerm" ]] && [[ -z "${WM_VAR#/}" ]] && [[ -t 1 ]]; then
        exec $WM_CMD
    fi
}



eval "$(fzf --zsh)"

# P10K
#source ~/powerlevel10k/powerlevel10k.zsh-theme
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NPM
export PATH=$PATH:$(npm bin -g)

# Atuin
. "$HOME/.atuin/bin/env"

# Flutter
export PATH=$HOME/Development/flutter/bin/:$PATH

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Ruby gems
export GEM_HOME="$HOME/.gem"
export PATH="/Users/mrcajuka/.gem/ruby/2.6.0/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# FNM
eval "$(fnm env)"

# Aliases
alias fzfbat='fzf --preview="bat --theme=gruvbox-dark --color=always {}"'
alias fzfnvim='nvim $(fzf --preview="bat --theme=gruvbox-dark --color=always {}")'
alias ls='eza --color=always --long --icons=always'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias vim='nvim'
# alias ls='eza --color=always --group-directories-first --icons'
# alias ll='eza -la --icons --octal-permissions --group-directories-first'
# alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
# alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
# alias la='eza --long --all --group --group-directories-first'
# alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'


# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Zoxide
eval "$(zoxide init zsh)"

# Atuin
eval "$(atuin init zsh)"

# FZF
source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"
# set Starship PATH
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml


start_if_needed
