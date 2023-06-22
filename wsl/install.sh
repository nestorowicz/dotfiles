#!/bin/bash

set -e

ZSHRC="${HOME}/.zshrc"

echo "installing zsh"
sudo apt-get -y install zsh

echo "copying configs"
cp $PWD/.zshrc $HOME/
cp -r $PWD/.zsh $PWD/.fzf $HOME/

echo "installing fzf"
$HOME/.fzf/install --key-bindings --completion --update-rc

echo '' >> ${ZSHRC}
echo '# zsh-syntax-highlighting has to be the last statement as per documentation' >> ${ZSHRC}
echo 'source ${ZSH}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZSHRC}
