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
export git=$HOME/dev/github/
export aws=$HOME/dev/aws/
export spry=$HOME/dev/github/spry-website/
export adp=$HOME/dev/github/amigos-da-poli/

bindkey -v
export KEYTIMEOUT=1

# EOF
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias f="ag -g"
alias r="ag"
alias ls='ls -GFh'
alias v='nvim'
alias c='code'
alias p='python3'
alias sv="source ~/.zshrc"
alias yt='web_search duckduckgo \!yt'
alias goog='web_search google'
alias spry='cl $spry'
alias adp='cl $adp'
alias myip="curl http://ipecho.net/plain; echo"
alias usage="du -h -d1"

# functions
cl() {
	cd "$@";
	clear;
	ls;
}
