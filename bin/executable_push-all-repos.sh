#!/usr/bin/env bash
set -uo pipefail

SSH_KEY="$HOME/.ssh/id_ed25519"

# Hard-coded list of repos
for repo in \
  "$HOME/Workspace/nix-config" \
  "$HOME/Workspace/kriwilcom" \
  "$HOME/Workspace/dotfiles"
do
  if [ ! -d "$repo/.git" ]; then
    echo "Skipping $repo — not a git repo"
    continue
  fi

  echo ">>> Pushing $repo"

  (
    cd "$repo" || exit 1

    # Just try to push; if it fails, print an error and continue
    if ! GIT_SSH_COMMAND="ssh -i $SSH_KEY" git push; then
      echo "  ERROR: git push failed for $repo"
    fi
  )
done
