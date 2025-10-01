# OpenAI Functions

# Uses OpenAI API to get bash command suggestions
# Example: oai "how to find large files in current directory"
# Will return a relevant bash command for the query
function oai() {
  local user_prompt="$*"
  local system_prompt="You are an expert at assisting with bash command. Answer very concisely with an output that is suitable for a bash command."

  # Build the JSON body
  local json_payload=$(
    cat <<EOF
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "$system_prompt"
    },
    {
      "role": "user",
      "content": "$user_prompt"
    }
  ],
  "max_tokens": 100,
  "temperature": 0.7
}
EOF
  )

  # Send request to OpenAI, pipe to jq, extract only the assistant's "content".
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "$json_payload" \
  | jq -r '.choices[0].message.content'
}

# Tests OpenAI API configuration and connectivity
# Example: oai_help
# Checks if API key is set and validates connection to OpenAI
function oai_help() {
  echo "Checking OpenAI API configuration..."
  echo ""
  
  # Check if API key is set
  if [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ Error: OPENAI_API_KEY environment variable is not set"
    echo "Please set it with: export OPENAI_API_KEY='your-api-key'"
    return 1
  fi
  
  echo "✓ API key is set"
  echo ""
  echo "Testing API connection..."
  
  # Make a simple API call to list models
  local response=$(curl -s -w "\n%{http_code}" https://api.openai.com/v1/models \
    -H "Authorization: Bearer $OPENAI_API_KEY")
  
  local http_code=$(echo "$response" | tail -n1)
  local body=$(echo "$response" | sed '$d')
  
  if [ "$http_code" = "200" ]; then
    echo "✓ API connection successful"
    echo "✓ Authentication working properly"
    echo ""
    echo "Your OpenAI API is configured correctly!"
  else
    echo "❌ API connection failed"
    echo "HTTP Status Code: $http_code"
    echo ""
    
    if [ "$http_code" = "401" ]; then
      echo "Error: Invalid or expired API key"
      echo "Please check your OPENAI_API_KEY environment variable"
    elif [ "$http_code" = "429" ]; then
      echo "Error: Rate limit exceeded or quota reached"
      echo "Please check your OpenAI account usage and billing"
    elif [ "$http_code" = "000" ]; then
      echo "Error: Could not connect to OpenAI API"
      echo "Please check your internet connection"
    else
      echo "Error details:"
      echo "$body" | jq '.' 2>/dev/null || echo "$body"
    fi
    return 1
  fi
}

# Updates ~/.zshrc from remote GitHub repository with safety checks
# Example: update_zshrc_from_github
# Downloads latest .zshrc from GitHub and checks for local changes before replacing
function update_zshrc_from_github() {
  local github_url="https://raw.githubusercontent.com/tkr22777/bash_configs/master/.zshrc"
  local temp_file="/tmp/.zshrc.remote.$$"
  local backup_file="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
  
  echo "Fetching latest .zshrc from GitHub..."
  
  # Download to temp file first
  if ! curl -fsSL "$github_url" -o "$temp_file"; then
    echo "❌ Failed to download from GitHub"
    rm -f "$temp_file"
    return 1
  fi
  
  echo "✓ Downloaded successfully"
  
  # Check if current .zshrc exists
  if [ ! -f "$HOME/.zshrc" ]; then
    echo "No existing .zshrc found, installing fresh copy..."
    mv "$temp_file" "$HOME/.zshrc"
    source "$HOME/.zshrc"
    echo "✓ Done! New .zshrc installed."
    return 0
  fi
  
  # Compare files
  if diff -q "$HOME/.zshrc" "$temp_file" > /dev/null 2>&1; then
    echo "✓ Your .zshrc is already up to date!"
    rm -f "$temp_file"
    return 0
  fi
  
  echo ""
  echo "Checking for local modifications..."
  
  # Extract function and alias names from both files
  local current_items=$(grep -E '^(function [a-zA-Z_][a-zA-Z0-9_]*|alias [a-zA-Z_][a-zA-Z0-9_]*=)' "$HOME/.zshrc" | sed -E 's/^function ([a-zA-Z_][a-zA-Z0-9_]*).*/\1/; s/^alias ([a-zA-Z_][a-zA-Z0-9_]*)=.*/\1/' | sort)
  local remote_items=$(grep -E '^(function [a-zA-Z_][a-zA-Z0-9_]*|alias [a-zA-Z_][a-zA-Z0-9_]*=)' "$temp_file" | sed -E 's/^function ([a-zA-Z_][a-zA-Z0-9_]*).*/\1/; s/^alias ([a-zA-Z_][a-zA-Z0-9_]*)=.*/\1/' | sort)
  
  # Find items only in current (would be lost)
  local lost_items=$(comm -23 <(echo "$current_items") <(echo "$remote_items"))
  
  if [ -n "$lost_items" ]; then
    echo "❌ WARNING: The following functions/aliases exist locally but NOT in remote:"
    echo "$lost_items" | sed 's/^/  - /'
    echo ""
    echo "Update ABORTED to prevent data loss."
    echo "Please manually merge or remove local-only items before updating."
    echo ""
    echo "To see full differences, run:"
    echo "  diff ~/.zshrc $temp_file"
    rm -f "$temp_file"
    return 1
  fi
  
  # Safe to update
  echo "✓ No local-only items detected, safe to update"
  echo ""
  echo "Creating backup..."
  cp "$HOME/.zshrc" "$backup_file"
  echo "✓ Backup saved to: $backup_file"
  
  echo "Updating .zshrc..."
  mv "$temp_file" "$HOME/.zshrc"
  
  echo "✓ Sourcing new configuration..."
  source "$HOME/.zshrc"
  echo "✓ Done! Your .zshrc has been updated."
}

