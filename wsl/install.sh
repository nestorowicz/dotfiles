#!/bin/bash

set -e

ZSHRC="${HOME}/.zshrc"

if ! command -v zsh &> /dev/null
then
  echo "installing zsh"
  sudo apt-get -y install zsh
fi

echo "copying configs"
cp $PWD/.zshrc $HOME/
cp -r $PWD/.zsh $PWD/.fzf $HOME/

if ! command -v fzf &> /dev/null ; then
  echo "installing fzf"
  $HOME/.fzf/install --key-bindings --completion --update-rc
fi

if ! [ -s "$NVM_DIR/nvm.sh" ] ; then
  echo "installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

echo '' >> ${ZSHRC}
echo '# zsh-syntax-highlighting has to be the last statement as per documentation' >> ${ZSHRC}
echo 'source ${ZSH}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZSHRC}
