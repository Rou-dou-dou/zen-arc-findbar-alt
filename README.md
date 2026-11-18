# Arc-Style Find Bar

A compact find bar for [Zen Browser](https://zen-browser.app) that floats in the top-right corner of the page, the way Arc does it: a borderless search field with the match count inside, then up, down and close. No checkboxes, no status text.

![Preview](https://raw.githubusercontent.com/jan-voe/zen-arc-findbar/main/image.png)

## Features

- Floats in the top-right corner of the page instead of docking at the bottom
- One row: `[ search field   2 of 5 ] ⌃ ⌄ ✕`
- Short match count: "2 of 5" instead of "2 of 5 matches"
- Search text turns red when nothing is found
- Follows light and dark mode, short fade/scale animation (respects reduced motion)

## Arc-like highlight colors (optional)

A mod can only style the find bar, not how matches are highlighted on the page. To get Arc's colors (all matches yellow, current match orange) and always highlight every match, set these in `about:config`:

| Preference | Value |
| --- | --- |
| `findbar.highlightAll` | `true` |
| `ui.textHighlightBackground` | `#FFFF00` |
| `ui.textHighlightForeground` | `#000000` |
| `ui.textSelectAttentionBackground` | `#FF9632` |
| `ui.textSelectAttentionForeground` | `#000000` |

The "Highlight All" checkbox is hidden by this mod, so `findbar.highlightAll` is how you turn highlighting of all matches on or off.

## Customizing

All sizes and colors are CSS variables at the top of `chrome.css` (`--arc-findbar-width`, `--arc-findbar-offset-top`, `--arc-findbar-bg`, …). Change them in the repo copy and run `./install.sh` again, then restart Zen.

## Known limitations

- The short match count works by letting the trailing word ("matches", "Übereinstimmungen", …) wrap out of view. With very short words, such as "1 of 1 match" in English, the word can still show.
- Match case, whole words and diacritics are hidden. Their last state still applies.
- Built and tested on Zen 1.24 for macOS. Zen updates that change the find bar markup can break the layout.
- Not tested in split view.

## Installation

The Zen mod store is archived, so this is installed as a `userChrome.css` style.

### macOS

```bash
git clone https://github.com/jan-voe/zen-arc-findbar.git
cd zen-arc-findbar
./install.sh
```

The script finds the Zen profile, copies `chrome.css` to `chrome/arc-findbar.css`, imports it from `userChrome.css` and adds the preferences from `user.js` (enables `userChrome.css` and sets the highlight colors above). Running it again updates the CSS without duplicating anything. To pick a profile yourself: `./install.sh "/path/to/profile"`.

Then quit Zen completely (Cmd+Q) and start it again.

### Windows and Linux (manual)

1. Open `about:support` in Zen and click "Open Folder" next to "Profile Folder".
2. Create a folder `chrome` there if it doesn't exist and copy `chrome.css` into it as `arc-findbar.css`.
3. Add this as the first line of `chrome/userChrome.css` (create the file if needed): `@import url("arc-findbar.css");`
4. In `about:config`, set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`, plus the optional highlight colors above.
5. Restart Zen.

## Uninstall

Delete `chrome/arc-findbar.css` and the `@import` line in `chrome/userChrome.css` from the profile, and the lines from this repo's `user.js` in the profile's `user.js`. Values already set stay until you reset them in `about:config`. Then restart Zen.

## License

[MIT](LICENSE)
