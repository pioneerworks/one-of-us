#!/bin/bash

# Require environment variables - fail if not set
if [ -z "$DOTFILES_REPO" ]; then
    echo "Error: DOTFILES_REPO environment variable must be set"
    exit 1
fi

echo "Booting development environment"

#install xcode command line tools
xcode-select --install

# install homebrew if not already installed
# if ! command -v brew >/dev/null 2>&1; then
#     echo "Installing Homebrew..."
#     NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# fi

brew update

brew install gh

if gh auth login; then
    echo "Login successful"
else
    echo "Login failed"
    exit 1
fi

if [ -d "$HOME/homebase/dotfiles" ]; then
    echo "Removing existing dotfiles directory..."
    rm -rf "$HOME/homebase/dotfiles"
fi

if command -v dotter >/dev/null 2>&1; then
    gh repo clone "$DOTFILES_REPO" ~/homebase/dotfiles
else
    brew install dotter
    gh repo clone "$DOTFILES_REPO" ~/homebase/dotfiles
fi

echo "Dotter installed"

cd ~/homebase/dotfiles

dotter deploy -v