#!/bin/bash
# Sync ZSH configuration from Dropbox to home directory

echo "Syncing ZSH configuration to home directory..."

# Create ~/.zsh directory if it doesn't exist
mkdir -p ~/.zsh

# Copy .zshrc
echo "✓ Copying .zshrc..."
cp "$HOME/Dropbox/Work/init/.zshrc" ~/.zshrc

# Copy all modular config files (excluding .env to preserve local settings)
echo "✓ Copying modular config files..."
for file in "$HOME/Dropbox/Work/init/.zsh/"*.zsh; do
  cp "$file" ~/.zsh/
done

# Copy .env.template if it doesn't exist in home directory
if [ ! -f ~/.zsh/.env ]; then
  if [ -f "$HOME/Dropbox/Work/init/.zsh/.env.template" ]; then
    echo "✓ Creating .env from template (please configure your API keys)..."
    cp "$HOME/Dropbox/Work/init/.zsh/.env.template" ~/.zsh/.env
    echo "⚠️  Remember to edit ~/.zsh/.env and add your API keys!"
  fi
else
  echo "✓ Preserving existing ~/.zsh/.env file"
fi

echo "✓ Done! ZSH configuration synced."
echo ""
echo "Run 'source ~/.zshrc' to apply changes, or restart your terminal."

