if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

eval "$(rbenv init - --no-rehash)"
(rbenv rehash &) 2> /dev/null

eval "$(zoxide init bash)"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# eval "$(docker-machine env default)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-gcc-bin@8/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
