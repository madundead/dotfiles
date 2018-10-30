if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

eval "$(rbenv init -)"
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
