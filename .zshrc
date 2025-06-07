# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# use Man page with nvim instead
export MANPAGER='nvim +Man!'

# lazygit aliases
alias lg="lazygit"
alias lzd="lazydocker"
# open neovim aliases
alias v="nvim"
# ls will always show color
alias ls="ls --color"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

#History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # make completion case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # add color output to completion
zstyle ':completion:*' menu no # disable native zsh tab in favor of fzf tab
zstyle ':fzf-tab:*' popup-min-size 80 10 # Set the minimum preview window size when using fzf-tab cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # fzf tab cd will show a preview of the directory
# Keybindings
bindkey '^[[A' history-search-backward # remap show history search command to arrow up
bindkey '^[[B' history-search-forward # remap show history search command to arrow down


# pnpm
export PNPM_HOME="/Users/haonguyen/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# GO LANG
export GOPATH=$HOME/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$GOPATH/bin:$PATH
# ChatGPT Key
source "$HOME/.openai_key.zsh"
# JAVA
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
# Activate ruby version when needed
# chruby ruby-3.1.3

# For cs50 library to learn C
# export C_INCLUDE_PATH=/usr/local/include
# export LIBRARY_PATH=/usr/local/lib
# export LD_LIBRARY_PATH=/usr/local/lib
# export DYLD_LIBRARY_PATH=/usr/local/lib
# export CC="clang"
# export CFLAGS="-ferror-limit=1 -gdwarf-4 -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-gnu-folding-constant -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wshadow"
# export LDLIBS="-lcs50 -lm"
# fzf options
# export FZF_DEFAULT_OPTS="--layout=default"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# https://starship.rs/
# starship prompts
eval "$(starship init zsh)"

# # Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found

eval "$(uv generate-shell-completion zsh)"
zinit cdreplay -q
fpath=(~/.zsh/completions $fpath)
autoload -U compinit; compinit
