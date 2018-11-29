[ -f /etc/bashrc ] && . /etc/bashrc
[ -f ~/.z.sh ] && . ~/.z.sh
[ -f /etc/bash_completion ] && . /etc/bash_completion

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

alias ls='ls -G'
alias ll='ls -l'
alias vi='vim'
alias cat='bat --style plain --theme=solarized'
alias grep='rg'
alias be='bundle exec'
alias vim='nvim'
alias ..='cd ..'
alias ...='cd ../..'

alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gs='git status -sb'
alias ga='git add'

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

# fzf experiments
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
