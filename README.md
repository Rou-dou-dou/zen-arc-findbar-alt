# Arc-Style Find Bar

The find bar of [Zen Browser](https://zen-browser.app), restyled like Arc's: small, floating in the top-right corner, with just the search field, match count, arrows and close.

![Preview](https://raw.githubusercontent.com/jan-voe/zen-arc-findbar/main/image.png)

> [!NOTE]
> Not available in the Zen mod store, because its repository ([zen-browser/theme-store](https://github.com/zen-browser/theme-store)) has been archived. On macOS, a small script installs it as a regular Zen mod anyway. It takes about two minutes.

## Features

- Floats top-right instead of sitting at the bottom
- One clean row: `[ search   2 of 5 ] ⌃ ⌄ ✕`
- Arc-like highlights: all matches yellow, current match orange
- Works in light and dark mode

## Installation

**[⬇ Download zen-arc-findbar.zip](https://github.com/jan-voe/zen-arc-findbar/releases/latest/download/zen-arc-findbar.zip)** and unzip it (Safari does this automatically). You get a folder called `zen-arc-findbar`.

### macOS

1. Quit Zen with `Cmd + Q`.
2. Open **Terminal** (`Cmd + Space`, type "Terminal", press Enter).
3. Paste this line and press Enter:
   ```bash
   zsh ~/Downloads/zen-arc-findbar/install.sh
   ```
   Folder not in Downloads? Type `zsh ` (with a space), drag `install.sh` into the Terminal window and press Enter.
4. Start Zen and press `Cmd + F` on any page.

The find bar now shows up in Zen's settings under **Zen Mods**, like any other mod. You can switch it off or remove it there.

<details>
<summary>What the script does</summary>

It finds your Zen profile and registers the find bar there the same way Zen installs mods from its store. It also sets the highlight colors. Your other mods and settings are kept, and running it twice is safe. It stops if Zen is still running.

</details>

### Windows and Linux

1. In Zen, open `about:support`, find **Profile Folder** and click **Open Folder**.
2. Create a folder named `chrome` there (if it doesn't exist).
3. Copy `chrome.css` into `chrome` and rename it to `arc-findbar.css`.
4. In `chrome`, create a text file named `userChrome.css` (on Windows, not `userChrome.css.txt`) with this line at the top:
   ```css
   @import url("arc-findbar.css");
   ```
5. Open `about:config`, accept the warning, and set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
6. Optional: set the [highlight colors](#highlight-colors).
7. Restart Zen.

### Updating

Zen doesn't update this mod by itself. Delete the old `zen-arc-findbar` folder, download the new ZIP and install again (on macOS, quit Zen and run the script). This overwrites changes you made to the stylesheet.

## Customization

### Highlight colors

Matches on the page are colored by browser settings, not by the stylesheet. The macOS script sets them. On Windows and Linux, or to change them, use `about:config`:

| Preference | Value |
| --- | --- |
| `findbar.highlightAll` | `true` (highlight all matches) |
| `ui.textHighlightBackground` | `#FFFF00` (all matches) |
| `ui.textHighlightForeground` | `#000000` |
| `ui.textSelectAttentionBackground` | `#FF9632` (current match) |
| `ui.textSelectAttentionForeground` | `#000000` |

On macOS these live in `user.js` in your profile folder and are applied on every start, so change them there.

### Size, position and colors of the bar

Edit the variables at the top of `chrome.css` (`--arc-findbar-width`, `--arc-findbar-offset-top`, `--arc-findbar-bg`, …) in the downloaded folder and install again.

## Known limitations

- Made for Zen 1.24 on macOS. Not tested on Windows, Linux or in split view yet.
- Zen updates can change the find bar and break the layout.
- The macOS install uses Zen's internal mod format, which isn't officially documented. A future Zen version could change it.
- The match count hides the word after the numbers. In some languages a short word like "match" may still show.
- Match case, whole words and diacritics are hidden. Their last setting still applies.

## Uninstall

**macOS:** in Zen's settings under **Zen Mods**, click **Remove** next to Arc-Style Find Bar.

**Windows and Linux:** open your profile folder (`about:support` → **Profile Folder**), delete `chrome/arc-findbar.css` and the `@import` line in `chrome/userChrome.css`, then restart Zen. If you don't use any other custom styles, also reset `toolkit.legacyUserProfileCustomizations.stylesheets` in `about:config`.

**Highlight colors:** on macOS, also remove this mod's lines from `user.js` in your profile folder. Then reset the preferences from the table above in `about:config` (all systems).

## License

[MIT](LICENSE)
