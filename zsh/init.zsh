export ZSH=$HOME/.oh-my-zsh

# Plugins
plugins=(
  git
  web-search
)

# Basic
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

export PATH=$HOME/bin:/usr/local/bin:$PATH
source $ZSH/oh-my-zsh.sh

# my config
bindkey -v
export KEYTIMEOUT=1

# paths
export dev=$HOME/dev/
export git=$HOME/dev/github/
export spry=$HOME/dev/spry-website/
export adp=$HOME/dev/amigos-da-poli/
export webnext=$HOME/dev/web-next/

alias spry='cl $spry'
alias adp='cl $adp'
alias dev='cl $dev'
alias next='cl $webnext'
alias sv="source ~/.zshrc"
alias ev="nvim ~/.config/zsh/init.zsh"

# EOF
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias f="ag -g"
alias r="ag"
alias ls='ls -GFh'
alias v='nvim'
alias yt='web_search duckduckgo \!yt'
alias goog='web_search google'
alias myip="curl http://ipecho.net/plain; echo"
alias usage="du -k -d1 | sort -nr"

# functions
cl() {
	cd "$@";
	clear;
	ls;
}
