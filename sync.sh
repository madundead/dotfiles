# xcode-select --install

if ! [ -x "$(command -v brew)" ]; then
  echo "==> Found brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "==> Brew already installed"
fi

echo "==> Brew bundle"
brew bundle

if [ -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
  echo "==> Found vim-plug"
else
  echo "==> Installing vim-plug"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "==> Symlinking dotfiles"
for dir in $(ls -d */); do stow -Rv ${dir}; done
