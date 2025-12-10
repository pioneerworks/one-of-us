#!/bin/bash

# Require environment variables - fail if not set
if [ -z "$DOTFILES_REPO" ]; then
    echo "Error: DOTFILES_REPO environment variable must be set"
    exit 1
fi

echo -e "\033[38;5;98m"
cat << "EOF"
╔═════════════════════════════════════════════════════════════════════════╗
║                                                                         ║
║   ██╗  ██╗ ██████╗ ███╗   ███╗███████╗██████╗  █████╗ ███████╗███████╗  ║
║   ██║  ██║██╔═══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝  ║
║   ███████║██║   ██║██╔████╔██║█████╗  ██████╔╝███████║███████╗█████╗    ║
║   ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗██╔══██║╚════██║██╔══╝    ║
║   ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗██████╔╝██║  ██║███████║███████╗  ║
║   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝  ║
║                                                                         ║
║                   Booting development environment...                    ║
║                                                                         ║
╚═════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "\033[0m"

brew update

# brew install gh

# Check if already authenticated
# Ensure GitHub authentication
# if gh auth status >/dev/null 2>&1; then
#     echo "Already authenticated with GitHub"
# else
#     gh auth login || { echo "Login failed"; exit 1; }
#     echo "Login successful"
# fi

if [ -d "$HOME/homebase/dotfiles" ]; then
    echo "Removing existing dotfiles directory..."
    rm -rf "$HOME/homebase/dotfiles"
fi

if command -v dotter >/dev/null 2>&1; then
    git clone git@github.com:"$DOTFILES_REPO".git ~/homebase/dotfiles
else
    brew install dotter
    git clone git@github.com:"$DOTFILES_REPO".git ~/homebase/dotfiles
fi

echo "Dotter installed"

cd ~/homebase/dotfiles

dotter deploy -v