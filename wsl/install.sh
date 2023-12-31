#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ZSHRC="${HOME}/.zshrc"
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log () {
  echo -e "${GREEN}${1}${NC}\n"
}

if ! command -v wslview &> /dev/null ; then
  log "installing wslu"
  sudo apt -y install wslu
fi

if ! command -v rg &> /dev/null ; then
  log "installing ripgrep"
  sudo apt -y install ripgrep
fi

if ! command -v fd &> /dev/null ; then
  log "installing fd-find"
  sudo apt -y install fd-find
  mkdir -p ~/.local/bin/
  ln -s $(which fdfind) ~/.local/bin/fd
fi

if ! command -v gopls &> /dev/null ; then
  log "installing gopls"
  sudo apt -y install gopls
fi

if ! command -v zsh &> /dev/null ; then
  log "installing zsh"
  sudo apt-get -y install zsh
fi

if ! command -v tmux &> /dev/null ; then
  log "installing tmux"
  sudo apt-get -y install tmux
fi

log "copying configs"
cp ${SCRIPT_DIR}/.zshrc $HOME/
cp -r ${SCRIPT_DIR}/.zsh \
  ${SCRIPT_DIR}/.fzf \
  ${SCRIPT_DIR}/.tmux \
  ${SCRIPT_DIR}/.tmux.conf \
  ${SCRIPT_DIR}/.config \
  $HOME/

if ! command -v fzf &> /dev/null ; then
  log "installing fzf"
  $HOME/.fzf/install --key-bindings --completion --update-rc
fi

if ! [ -s "$NVM_DIR/nvm.sh" ] ; then
  log "installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

echo '' >> ${ZSHRC}
echo '# zsh-syntax-highlighting has to be the last statement as per documentation' >> ${ZSHRC}
echo 'source ${ZSH}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZSHRC}

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'

log 'installation complete'
log 'execute source ~/.zshrc now'
