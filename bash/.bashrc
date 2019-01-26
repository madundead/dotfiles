[ -z "$TMUX"  ] && tmux a

[ -f /etc/bashrc ] && . /etc/bashrc
. /usr/local/etc/profile.d/z.sh
[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkhash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Creds
export HOMEBREW_GITHUB_API_TOKEN="2a4fad8fb1b5ff1de5fdf043aeea7d6cf0c5b101"

alias ~='cd ~'
alias l='ls'
alias ls='ls -G'
alias ll='ls -l'
alias v='vim'
alias vi='vim'
alias vim='nvim'
alias cat='bat --style plain --theme=solarized'
alias grep='rg'
alias be='bundle exec'
alias ..='cd ..'
alias ...='cd ../..'

alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gca='git commit --amend'
alias gs='git status -sb'
alias ga='git add'
alias gup='git up'
alias gp='git push'
alias gb='git branch'
alias gl='git lg'

alias rdc='be rake db:create'
alias rdd='be rake db:drop'
alias rdm='be rake db:migrate'
alias rdr='be rake db:rollback'
alias rds='be rake db:seed'

alias rc='bin/rails c'
alias rs='bin/rails s -p3001'

yta() {
  streamlink $1 audio_mp4
}

# Homebrew stuff
if [ -x /usr/local/bin/brew ]; then
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export MANPATH=/usr/local/share/man:$MANPATH

    # bash_completion if installed
    if [ -f `brew --prefix`/etc/bash_completion.d ]; then
        . `brew --prefix`/etc/bash_completion.d
    fi
fi

__git_ps1() { :;}
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi
PS1='\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:\[\e[m\]\w\[\e[1;34m\]$(__git_ps1)\[\e[1;31m\]> \[\e[0m\]'

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--layout=reverse --inline-info'
