if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

eval "$(rbenv init - --no-rehash)"
(rbenv rehash &) 2> /dev/null

# eval "$(docker-machine env default)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
