#!/bin/zsh
# Installs the Arc-Style Find Bar into the active Zen profile (macOS):
#  - copies chrome.css to <profile>/chrome/arc-findbar.css
#  - imports it from <profile>/chrome/userChrome.css
#  - adds the prefs from ./user.js (enable userChrome.css, highlight colors)
# Safe to run again. Pick a profile yourself: ./install.sh "/path/to/profile"
set -e
D=${0:A:h}
ZEN=~/Library/Application\ Support/zen

if [[ -n "$1" ]]; then
  P="$1"
else
  # Profile used by the installed Zen app: [Install…] section of profiles.ini,
  # then installs.ini, then the profile marked Default=1
  REL=$(awk -F= '/^\[Install/{s=1;next} /^\[/{s=0} s && /^Default=/{print $2; exit}' "$ZEN/profiles.ini" 2>/dev/null)
  [[ -z "$REL" ]] && REL=$(awk -F= '/^Default=/{print $2; exit}' "$ZEN/installs.ini" 2>/dev/null)
  if [[ -z "$REL" ]]; then
    REL=$(awk -F= '/^\[Profile/{path=""} /^Path=/{path=$2} /^Default=1/{print path; exit}' "$ZEN/profiles.ini" 2>/dev/null)
  fi
  [[ -z "$REL" ]] && { echo "No Zen profile found. Start Zen once, or pass the profile path as an argument."; exit 1; }
  P="$ZEN/$REL"
fi
[[ -d "$P" ]] || { echo "Profile not found: $P"; exit 1; }
echo "Profile: $P"

mkdir -p "$P/chrome"
cp "$D/chrome.css" "$P/chrome/arc-findbar.css"
touch "$P/chrome/userChrome.css"
if ! grep -q 'arc-findbar.css' "$P/chrome/userChrome.css"; then
  printf '@import url("arc-findbar.css");\n' | cat - "$P/chrome/userChrome.css" > "$P/chrome/.uc.tmp"
  mv "$P/chrome/.uc.tmp" "$P/chrome/userChrome.css"
fi

touch "$P/user.js"
while IFS= read -r line; do
  grep -qxF "$line" "$P/user.js" || echo "$line" >> "$P/user.js"
done < "$D/user.js"

echo "Done. Quit Zen completely (Cmd+Q) and start it again."
