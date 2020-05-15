[ -f ~/iCloud/secrets.sh ]           && . ~/iCloud/secrets.sh
[ -f /etc/bashrc ]                   && . /etc/bashrc
[ -f /usr/local/etc/profile.d/z.sh ] && . /usr/local/etc/profile.d/z.sh
[ -f /etc/bash_completion ]          && . /etc/bash_completion
[ -f ~/.fzf.bash ]                   && . ~/.fzf.bash

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkhash
shopt -s cmdhist # save multi-line commands in one

export BASH_SILENCE_DEPRECATION_WARNING=1

# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--layout=reverse --inline-info'

alias ~='cd ~'
alias l='ls'
alias ls='ls -G'
alias ll='ls -l'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias cat='bat --style plain'
alias grep='rg'
alias be='bundle exec'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'

alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gca='git commit --amend'
alias gcw='git commit -m "wip"'
alias gs='git status -sb'
alias ga='git add'
alias grm='git rm'
alias gup='git up'
alias gp='git push'
alias gpf='git push -f'
alias gpt='git push origin --tags'
alias gb='git branch'
alias gg='git go'
alias gl='git lg'
alias gr='git reset'
alias gr1='git reset HEAD~1'
alias gh='git lg -1'
function gcm () {
    git commit -m "$*"
}

alias fs='foreman start'
alias ss='spring stop'

alias rdc='bin/rails db:create'
alias rdd='bin/rails db:drop'
alias rdm='bin/rails db:migrate'
alias rdr='bin/rails db:rollback'
alias rds='bin/rails db:seed'

alias k='kubectl'

alias br='bin/rails'
alias rc='bin/rails c'
alias rs='bin/rails s -p3001'

alias mux='tmuxinator start'

yta() {
  streamlink $1 audio_mp4
}

fzf_kill() {
    local pids=$(
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f3
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

alias fkill='fzf_kill'

# Homebrew stuff
if [ -x /usr/local/bin/brew ]; then
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export MANPATH=/usr/local/share/man:$MANPATH
fi

export PATH="$HOME/.cargo/bin:$PATH"

if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi
PS1='\W$(__git_ps1 ":%s") '

function q() { if [ -z "$1" ]; then return 1; fi; kubectl exec -n $1 -it $(kubectl get pods -n $1 -l product=quoting,app=quoting-rails-webserver -o=custom-columns=NAME:.metadata.name | tail -1) ${@:2}; }
function olb() { if [ -z "$1" ]; then return 1; fi; kubectl exec -n $1 -it $(kubectl get pods -n $1 -l product=online-bind,app=online-bind-rails-webserver -o=custom-columns=NAME:.metadata.name | tail -1) ${@:2}; }
function qstag() { kubectl exec -n staging -it $(kubectl get pods -n staging -l product=quoting,app=quoting-rails-webserver -o=custom-columns=NAME:.metadata.name | tail -1) ${@:2}; }

function _calcram() {
  local sum
  sum=0
  for i in `ps aux | grep -i "$1" | grep -v "grep" | awk '{print $6}'`; do
    sum=$(($i + $sum))
  done
  sum=$(echo "scale=2; $sum / 1024.0" | bc)
  echo $sum
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM
function ram() {
  local sum
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
    return 0
  fi

  sum=$(_calcram $app)
  if [[ $sum != "0" ]]; then
    echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM"
  else
    echo "No active processes matching pattern '${fg[blue]}${app}${reset_color}'"
  fi
}
