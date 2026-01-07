[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] &&
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/.cargo/env ] && . ~/.cargo/env
[ -f ~/Syncthing/secrets.sh ] && . ~/Syncthing/secrets.sh

if [ -x /usr/libexec/path_helper ]; then
  eval $(/usr/libexec/path_helper -s)
fi

# Save 10,000 lines of history in memory
HISTSIZE=10000
# Save 2,000,000 lines of history to disk (will have to grep ~/.bash_history for full listing)
HISTFILESIZE=2000000
# Ignore redundant or space commands
HISTCONTROL=ignoreboth
# Ignore more
HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
HISTIGNORE=$HISTIGNORE':gcom:gcob:gd:gdc:gc:gca:gcw:gs:ga:grm:gup:gp:gpf:gpt:gb:gg:gl:gr:gr1:gh'
HISTIGNORE=$HISTIGNORE':v:vi:nvim'
HISTIGNORE=$HISTIGNORE':k:s:p:y:kp:ks:kl:kgp:d:dc:dcu:dcd:dcr:dcl:dcs'
# Immediately store command to the history
PROMPT_COMMAND='history -a'

shopt -s histappend # Append to history instead of overwrite
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkhash
shopt -s cmdhist # save multi-line commands in one

export KUBE_TMUX_SYMBOL_ENABLE=false
export KUBE_TMUX_NS_ENABLE=false

export BASH_SILENCE_DEPRECATION_WARNING=1
export HOMEBREW_NO_ENV_HINTS=true
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"
# Fix for the following error in some Ruby version
# objc[12590]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib
# export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_R_OPTS='--no-info'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
  --height 100% --layout=reverse --border --cycle --info=inline
  --bind=ctrl-d:preview-page-down
  --bind=ctrl-u:preview-page-up"

alias ~='cd ~'
alias l='eza'
alias ls='eza'
alias ll='eza -l'
alias tree='eza --tree'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias cat='bat --style plain'
alias grep='rg'
alias be='bundle exec'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'

alias pacman='sudo pacman'
alias p='sudo pacman'
alias s='sudo systemctl'
alias y='yay --noconfirm --answerdiff=None --answeredit=None'
alias yay='yay --noconfirm --answerdiff=None --answeredit=None'


alias gco='git checkout'
alias gcom='git checkout master'
alias gcob='git checkout -b'
# TODO: git checkout --track origin/$1^W man git-switch --guess
# alias gcot='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdn='git diff --no-index'
alias gc='git commit'
alias gca='git commit --amend'
alias gcw='git commit --no-verify -m "wip"'
alias gs='git status -sb'
alias ga='git add'
alias grm='git rm'
alias gup='git up'
alias gp='git push'
alias gpf='git push -f'
alias gpt='git push origin --tags'
alias gb='git branch'
alias gg='git go' # checkout or create
alias gl='git lg'
alias gr='git reset'
alias gr1='git reset HEAD~1'
# alias gh='git lg -1'
function gcm() {
  git commit --no-verify -m "$*"
}

alias fs='foreman start'
alias ss='spring stop'

alias rdc='bin/rails db:create'
alias rdd='bin/rails db:drop'
alias rdm='bin/rails db:migrate'
alias rdr='bin/rails db:rollback'
alias rds='bin/rails db:seed'

alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose stop'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -tf --tail="50"'
alias dcs='docker-compose ps'

alias tf='tofu'
alias tfp='tofu plan'
alias tfa='tofu apply'
alias tff='tofu fmt'

alias k='kubectl'
alias kp='kubectx matic-production'
alias ks='kubectx matic-staging'
alias kl='kubectx local-colima'
function kgp() {
  if [ -z "$1" ]; then
    kubectl get pods
  else
    kubectl get pods | grep $1
  fi
}

alias rc='bin/rails c'
alias rs='bin/rails s -p3001'

alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias mbrew='arch -arm64e /opt/homebrew/bin/brew'

alias pgu='asdf exec pg_ctl -D ./data/pg -l ./log/pg.log start'
alias pgd='asdf exec pg_ctl -D ./data/pg stop'
alias pgs='asdf exec pg_ctl -D ./data/pg status'

alias oclean="fd . '/Users/madundead/Syncthing/Obsidian/Personal' | rg sync-conflict | tr '\n' '\0' | xargs -0 rm"

alias proxy='kubectl port-forward -n staging svc/tinyproxy-svc 8888:8888'

# Experimental
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'

alias ssn='sudo shutdown now'

o() {
  files="$(fzf --print0 --preview "bat --theme ansi --color always {}")"
  if [ -z "$files" ]; then
    return
  fi
  echo -n "$files" | xargs -0 -o "$EDITOR"
}

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\\e[0m") \
    LESS_TERMCAP_se=$(printf "\\e[0m") \
    LESS_TERMCAP_so=$(printf "\\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\\e[0m") \
    LESS_TERMCAP_us=$(printf "\\e[0;32m") \
    man "$@"
}

function ex {
  if [ $# -eq 0 ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
    echo "       ex <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  fi
  for n in "$@"; do
    if [ ! -f "$n" ]; then
      echo "'$n' - file doesn't exist"
      return 1
    fi

    case "${n%,}" in
    *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
      tar zxvf "$n"
      ;;
    *.lzma) unlzma ./"$n" ;;
    *.bz2) bunzip2 ./"$n" ;;
    *.cbr | *.rar) unrar x -ad ./"$n" ;;
    *.gz) gunzip ./"$n" ;;
    *.cbz | *.epub | *.zip) unzip ./"$n" ;;
    *.z) uncompress ./"$n" ;;
    *.7z | *.apk | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar | *.vhd)
      7z x ./"$n"
      ;;
    *.xz) unxz ./"$n" ;;
    *.exe) cabextract ./"$n" ;;
    *.cpio) cpio -id <./"$n" ;;
    *.cba | *.ace) unace x ./"$n" ;;
    *.zpaq) zpaq x ./"$n" ;;
    *.arc) arc e ./"$n" ;;
    *.cso) ciso 0 ./"$n" ./"$n.iso" &&
      extract "$n.iso" && \rm -f "$n" ;;
    *.zlib) zlib-flate -uncompress <./"$n" >./"$n.tmp" &&
      mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n" ;;
    *.dmg)
      hdiutil mount ./"$n" -mountpoint "./$n.mounted"
      ;;
    *.tar.zst) tar -I zstd -xvf ./"$n" ;;
    *.zst) zstd -d ./"$n" ;;
    *)
      echo "ex: '$n' - unknown archive method"
      return 1
      ;;
    esac
  done
}

fkill() {
  local pids=$(
    ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f3
  )
  if [[ -n $pids ]]; then
    echo "$pids" | xargs kill -9 "$@"
  fi
}
alias fk='fkill'

# Homebrew stuff
export MANPATH=/usr/local/share/man:$MANPATH
export PATH=/opt/homebrew/bin:/opt/homebrew/opt:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-gcc-bin@8/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

eval "$(zoxide init bash)"

if [ -s ~/Development/dotfiles/git/.git-prompt.sh ]; then
  source ~/Development/dotfiles/git/.git-prompt.sh
fi

PS1='\W$(__git_ps1 ":%s") '
eval "$(mise activate --shims)"
