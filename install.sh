#!/bin/zsh
# Installs (or updates) the Arc-Style Find Bar as a Zen mod in the active Zen profile (macOS).
#  - registers the mod so it shows up in Zen's settings under Zen Mods, with an on/off switch
#  - adds the highlight color prefs from ./user.js to <profile>/user.js
# Safe to run again. Pick a profile yourself: zsh install.sh "/path/to/profile"
set -e
D=${0:A:h}
ZEN=~/Library/Application\ Support/zen

# Zen rewrites its mod files while running, so it has to be closed.
# ZEN_SKIP_RUNNING_CHECK=1 skips this (only for testing against a separate profile).
if [[ -z "$ZEN_SKIP_RUNNING_CHECK" ]] && pgrep -x zen >/dev/null; then
  echo "Zen is still running. Quit it with Cmd+Q, then run this again."
  exit 1
fi

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

osascript -l JavaScript "$D/install-mod.js" "$P" "$D"

touch "$P/user.js"
# Make sure an existing user.js ends with a newline before appending
[[ -n "$(tail -c1 "$P/user.js")" ]] && echo >> "$P/user.js"
while IFS= read -r line; do
  grep -qxF "$line" "$P/user.js" || echo "$line" >> "$P/user.js"
done < "$D/user.js"

echo "Done. Start Zen and press Cmd+F. The mod is listed in Zen's settings under Zen Mods."
