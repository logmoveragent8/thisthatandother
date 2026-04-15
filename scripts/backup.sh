#!/bin/bash
# OpenClaw Workspace Backup Script
# Backs up workspace to GitHub, scrubbing secrets first

WORKSPACE="/home/logmover/.openclaw/workspace"
BACKUP_DIR="/tmp/openclaw-backup-$(date +%Y%m%d)"

echo "Starting backup at $(date)"

# Clone to temp directory
rm -rf "$BACKUP_DIR"
git clone "$WORKSPACE" "$BACKUP_DIR"

cd "$BACKUP_DIR"

# Scrub secrets in openclaw.json - replace token with placeholder
if [ -f "openclaw.json" ]; then
    sed -i 's/"token": "[^"]*"/"token": "[OPENCLAW_TOKEN_PLACEHOLDER]"/g' openclaw.json
    echo "Scrubbed secrets from openclaw.json"
fi

# Check for other potential secrets in config files
for file in *.json *.yaml *.yml; do
    if [ -f "$file" ]; then
        # Replace common secret patterns
        sed -i 's/"apiKey": "[^"]*"/"apiKey": "[API_KEY_PLACEHOLDER]"/g' "$file"
        sed -i 's/"password": "[^"]*"/"password": "[PASSWORD_PLACEHOLDER]"/g' "$file"
        sed -i 's/"token": "[^"]*"/"token": "[TOKEN_PLACEHOLDER]"/g' "$file"
    fi
done

# Add all files
git add -A

# Check if there are changes
if git diff --staged --quiet; then
    echo "No changes to commit"
else
    # Commit with date
    git commit -m "Backup: $(date +%Y-%m-%d)"

    # Push
    git push origin main 2>/dev/null || git push origin master 2>/dev/null
    
    echo "Backup pushed successfully"
fi

# Cleanup
rm -rf "$BACKUP_DIR"

echo "Backup complete at $(date)"
