#!/bin/bash

# Require environment variables - fail if not set
if [ -z "$DOTFILES_REPO" ]; then
    echo "Error: DOTFILES_REPO environment variable must be set"
    exit 1
fi

echo "Booting development environment"

#install xcode command line tools
xcode-select --install

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
brew update

if gh auth login; then
    echo "Login successful"
else
    echo "Login failed"
    exit 1
fi

if command -v dotter >/dev/null 2>&1; then
    gh repo clone "$DOTFILES_REPO" ~/homebase/.dotfiles
else
    brew install dotter
fi

dotter deploy -v