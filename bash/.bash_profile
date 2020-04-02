if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

eval "$(rbenv init - --no-rehash)"
(rbenv rehash &) 2> /dev/null

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
