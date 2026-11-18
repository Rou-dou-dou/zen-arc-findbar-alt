# Arc-Style Find Bar

A compact find bar for [Zen Browser](https://zen-browser.app) that floats in the top-right corner of the page, the way Arc does it: a borderless search field with the match count inside, then up, down and close. No checkboxes, no status text.

![Preview](https://raw.githubusercontent.com/jan-voe/zen-arc-findbar/main/image.png)

## Features

- Floats in the top-right corner of the page instead of docking at the bottom (also in split view, one per panel)
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

All sizes and colors are CSS variables at the top of `chrome.css` (`--arc-findbar-width`, `--arc-findbar-offset-top`, `--arc-findbar-bg`, …).

## Known limitations

- The short match count works by letting the trailing word ("matches", "Übereinstimmungen", …) wrap out of view. With very short words, such as "1 of 1 match" in English, the word can still show.
- Match case, whole words and diacritics are hidden. Their last state still applies.

## Install without the mod store (macOS)

Clone this repo and run:

```bash
./install.sh
```

The script finds the Zen profile, copies `chrome.css` into `chrome/arc-findbar.css`, imports it from `userChrome.css` and adds the preferences from `user.js` (enables `userChrome.css` and sets the highlight colors above). Then quit Zen completely (Cmd+Q) and start it again. To pick a profile yourself: `./install.sh "/path/to/profile"`.

## License

[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/), the license of the Zen theme store.
