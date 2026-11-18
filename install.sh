#!/bin/zsh
# Installiert die Arc-Style Find Bar ins aktive Zen-Profil (macOS):
#  - kopiert chrome.css als chrome/arc-findbar.css ins Profil
#  - bindet sie per chrome/userChrome.css ein
#  - übernimmt die Prefs aus ./user.js (userChrome aktivieren, Trefferfarben)
# Mehrfach ausführbar. Eigenes Profil erzwingen: ./install.sh "/Pfad/zum/Profil"
set -e
D=${0:A:h}
ZEN=~/Library/Application\ Support/zen

if [[ -n "$1" ]]; then
  P="$1"
else
  # Profil der installierten Zen-App: [Install…]-Abschnitt in profiles.ini bzw. installs.ini,
  # sonst das als Default markierte Profil
  REL=$(awk -F= '/^\[Install/{s=1;next} /^\[/{s=0} s && /^Default=/{print $2; exit}' "$ZEN/profiles.ini" 2>/dev/null)
  [[ -z "$REL" ]] && REL=$(awk -F= '/^Default=/{print $2; exit}' "$ZEN/installs.ini" 2>/dev/null)
  if [[ -z "$REL" ]]; then
    REL=$(awk -F= '/^\[Profile/{path=""} /^Path=/{path=$2} /^Default=1/{print path; exit}' "$ZEN/profiles.ini" 2>/dev/null)
  fi
  [[ -z "$REL" ]] && { echo "Kein Zen-Profil gefunden. Zen einmal starten oder Profilpfad als Argument angeben."; exit 1; }
  P="$ZEN/$REL"
fi
[[ -d "$P" ]] || { echo "Profil nicht gefunden: $P"; exit 1; }
echo "Profil: $P"

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

echo "Installiert. Zen komplett beenden (Cmd+Q) und neu starten."
