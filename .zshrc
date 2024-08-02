autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit 

export XDG_CONFIG_HOME="/Users/ohaney/.config/"

export K9S_CONFIG_DIR=$XDG_CONFIG_HOME/k9s/
export K9S_CONFIG=$XDG_CONFIG_HOME/config.yaml

plugins=(git)

alias c=clear
alias gi="git init"
alias gs="git status"
alias gm="git commit -m"
alias gpu="git push"
alias gpuf="git push -f"
alias ups="git push -u origin"
alias gl="git log"
alias gcb="git checkout -b"
alias gb="git branch"
alias gc="git checkout"
alias gri="git rebase -i"
alias grm="git rebase master"
alias gcm="git checkout master"
alias ga="git add"
alias gaa="git add ."
alias gp="git pull"
alias gdba="git branch | grep -Ev 'master|dev|stage|prod|beta|development|staging|production|uat' | xargs git branch -D"
alias pipuninstall="pip freeze | xargs pip uninstall -y"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ohaney/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ohaney/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ohaney/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ohaney/code/google-cloud-sdk/completion.zsh.inc'; fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=
plugin=(
  pyenv
)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


command -v flux >/dev/null && . <(flux completion zsh)

alias vim="nvim"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export EDITOR="nvim"
export PATH=/usr/local/share/dotnet/dotnet:$PATH
export ASPNETCORE_ENVIRONMENT=Development
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib
export LOCAL=true
export PATH="/usr/local/opt/go@1.21/bin:$PATH"


## https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found


zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
