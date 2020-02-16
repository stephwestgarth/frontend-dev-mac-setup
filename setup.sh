#!/bin/bash
printf '/ -------------------------------------------------------------- / \n\n'
printf 'Welcome! Let''s get you set up. \n\n'
printf 'For more information on any of the following pages, \ncheck out confluence or the page urls provided. \n\n'
printf '/ -------------------------------------------------------------- / \n\n'

# turn off case sensitive matching
shopt -s nocasematch

if ! command -v brew >/dev/null 2>&1; then
  printf 'Would you like to install homebrew? [https://brew.sh/] (y/n) '
  read acceptBrew

  if [[ $acceptBrew =~ 'y' ]]; then
    printf 'Installing brew\n'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
else
  printf '\nHOMEBREW already installed. Get started using brew -h\n';
fi

if ! command -v zsh >/dev/null 2>&1; then
  printf 'Would you like to install and use zsh? You must have homebrew installed. (y/n) '
  read acceptZsh

  if [[ $acceptZsh =~ 'y' ]]; then
    printf 'Installing zsh\n'
    brew install zsh
    chsh -s /bin/zsh
  fi
else
  printf '\nZSH already installed. If you would like to use it as default,\nrun chsh -s /bin/zsh. Otherwise, you can start it with just /bin/zsh\n'
fi

if [ ! -d "$ZSH" ]; then
  printf 'Would you like to install and use ohmyz.sh? You may have to restart this script (though previously installed items will remain installed)[https://ohmyz.sh] (y/n) '
  read acceptOhMyZsh

  if [[ $acceptOhMyZsh =~ 'y' ]]; then
    printf 'Installing ohmyz.sh\n'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
else
  printf '\nOHMYZ.SH already installed. See [https://ohmyz.sh] for some cool tips\nand tricks.\n'
fi

if [ ! command -v nvm >/dev/null 2>&1 ] || [[ -f ~/.nvm ]]; then
  printf 'Would you like to install nvm? [https://github.com/nvm-sh/nvm] (y/n) '
  read acceptNvm

  if [[ $acceptNvm =~ 'y' ]]; then
    printf 'Installing nvm\n'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi
else
  printf '\nNVM already installed. Use nvm --help to get started.\n'
fi

if [[ ! -s "$HOME/.rvm/scripts/rvm" ]]; then
  printf '\nWould you like to install rvm and latest stable ruby? (y/n) '
  read acceptRvm

  if [[ $acceptRvm =~ 'y' ]]; then
    printf '\nWould you like to include rails? (y/n) ' acceptRails

    if [[ $acceptRails =~ 'y' ]]; then
      \curl -sSL https://get.rvm.io | bash -s stable
    else
      \curl -sSL https://get.rvm.io | bash -s stable --rails
    fi
  fi

else
  printf '\nRVM already installed. Use rvm -h to get started.\n'
fi

printf '\nFinal step: reloading profiles if required...'
terminalType=$(ps -p $$ -oargs=)

if [[ $terminalType == *'zsh'* ]] && [[ -f ~/.zshrc ]]; then
   # assume Zsh
   source ~/.zshrc
   printf '\n ~/.zshrc file reloaded.\n'
elif [[ $terminalType == *'bash'* ]] && [[ -f ~/.bash_profile ]]; then
   # assume Bash
   source ~/.bash_profile
   printf '\n ~/.bash_profile file reloaded.\n'
fi


printf '\n\n/ -------------------------------------------------------------- /\n\n'
printf 'You should now be ready to go. See confluence for any next steps.\nGood luck!';
printf '\n\n/ -------------------------------------------------------------- /\n\n'
exit 0;