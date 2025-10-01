#!/bin/bash
# Sync ZSH configuration from Dropbox to home directory

echo "Syncing ZSH configuration to home directory..."

# Create ~/.zsh directory if it doesn't exist
mkdir -p ~/.zsh

# Copy .zshrc
echo "✓ Copying .zshrc..."
cp "$HOME/Dropbox/Work/init/.zshrc" ~/.zshrc

# Copy all modular config files
echo "✓ Copying modular config files..."
for file in "$HOME/Dropbox/Work/init/.zsh/"*.zsh; do
  cp "$file" ~/.zsh/
done

# Copy .env file (sync from repo)
if [ -f "$HOME/Dropbox/Work/init/.zsh/.env" ]; then
  cp "$HOME/Dropbox/Work/init/.zsh/.env" ~/.zsh/.env
  echo "✓ Synced .env file (remember to configure your API keys)"
fi

echo "✓ Done! ZSH configuration synced."
echo ""
echo "Run 'source ~/.zshrc' to apply changes, or restart your terminal."

