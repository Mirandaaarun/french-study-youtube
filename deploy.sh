#!/usr/bin/env bash
# Push the French Study site to GitHub Pages.
#
# Usage: ./deploy.sh [optional commit message]
#
# Stages every change in this folder, commits with an auto-generated message
# (or the one you pass), and pushes to origin/main. GitHub Pages rebuilds
# automatically — site updates live within a minute or two.

set -euo pipefail
cd "$(dirname "$0")"

# Refuse to run if we're not in a git repo or origin isn't set
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "ERROR: this folder is not a git repo. Run 'gh repo create ...' first." >&2
  exit 1
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "ERROR: origin remote not set." >&2
  exit 1
fi

git add -A

if git diff --staged --quiet; then
  echo "Nothing to deploy — working tree matches origin/main."
  exit 0
fi

# Auto message: "Update site (N videos) — <list>"
if [ $# -ge 1 ]; then
  MSG="$*"
else
  COUNT="$(jq 'length' videos.json 2>/dev/null || echo 0)"
  TITLES="$(jq -r '.[].title' videos.json 2>/dev/null | head -3 | paste -sd ', ' -)"
  MSG="Update site (${COUNT} videos): ${TITLES}"
fi

git commit -m "$MSG"
git push origin main

URL="$(gh api /repos/:owner/:repo/pages 2>/dev/null | jq -r '.html_url' 2>/dev/null || echo '')"
[ -z "$URL" ] && URL="https://mirandaaarun.github.io/french-study-youtube/"

echo
echo "Pushed. Pages will rebuild in ~30-60s."
echo "Live: $URL"
