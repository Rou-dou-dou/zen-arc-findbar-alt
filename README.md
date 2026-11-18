# Arc-Style Find Bar

A compact find bar for [Zen Browser](https://zen-browser.app) that floats in the top-right corner of the page, the way Arc does it: a borderless search field with the match count inside, then up, down and close. No checkboxes, no status text.

![Preview](https://raw.githubusercontent.com/jan-voe/zen-arc-findbar/main/image.png)

> [!NOTE]
> **Not available in the Zen mod store.** The repository behind the official Zen mod store ([zen-browser/theme-store](https://github.com/zen-browser/theme-store)) has been archived, so new mods can't be submitted there anymore. Install this mod with the steps below instead. It takes about two minutes.

## Features

- Floats in the top-right corner of the page instead of docking at the bottom
- One row: `[ search field   2 of 5 ] ⌃ ⌄ ✕`
- Short match count: "2 of 5" instead of "2 of 5 matches"
- Search text turns red when nothing is found
- Arc-like highlight colors on the page: all matches yellow, current match orange (see [below](#arc-like-highlight-colors))
- Follows light and dark mode, short fade/scale animation (respects reduced motion)

## Installation

### macOS

You don't need Git or any developer tools. The install script does all the work.

1. **Start Zen once** if you have never used it on this Mac, so it creates your profile. Then quit it with `Cmd + Q`.
2. **Download this mod.** At the top of this page, click the green **Code** button, then **Download ZIP**. Your Mac saves it to your Downloads folder.
3. **Unzip it.** Double-click the ZIP file in Downloads. You get a folder called `zen-arc-findbar-main`.
4. **Open Terminal.** Press `Cmd + Space`, type `Terminal` and press Enter.
5. **Run the install script.** Copy this line, paste it into Terminal and press Enter:
   ```bash
   zsh ~/Downloads/zen-arc-findbar-main/install.sh
   ```
   If the folder is somewhere else, type `zsh ` (with a space at the end), drag `install.sh` from the folder into the Terminal window, and press Enter.
6. **Check the output.** It should end with `Done. Quit Zen completely (Cmd+Q) and start it again.`
7. **Restart Zen.** Quit it completely with `Cmd + Q` (closing the window isn't enough), then open it again.
8. **Try it.** Open any web page and press `Cmd + F`.

<details>
<summary>What the script does</summary>

It finds the Zen profile, copies `chrome.css` to `<profile>/chrome/arc-findbar.css`, imports it from `<profile>/chrome/userChrome.css` and adds the lines from `user.js` to `<profile>/user.js`. Those lines turn on `userChrome.css` support (off by default in Zen) and set the highlight colors. Existing content in both files is kept, and running the script again doesn't duplicate anything. To use a specific profile: `zsh install.sh "/path/to/profile"`.

</details>

### Windows and Linux

There is no script for Windows and Linux yet, so this is done by hand.

1. **Download this mod.** At the top of this page, click the green **Code** button, then **Download ZIP**, and unzip it.
2. **Open your Zen profile folder.** In Zen, type `about:support` into the address bar and press Enter. In the table, find **Profile Folder** and click **Open Folder** (Windows) or **Open Directory** (Linux).
3. **Create the `chrome` folder.** In the profile folder, create a new folder named `chrome` (all lowercase). Skip this if it already exists.
4. **Copy the stylesheet.** Copy `chrome.css` from the downloaded folder into the `chrome` folder and rename the copy to `arc-findbar.css`.
5. **Create or edit `userChrome.css`.** In the `chrome` folder, open `userChrome.css` with a text editor (Notepad on Windows). If it doesn't exist, create a new text file with that exact name. On Windows, make sure it isn't saved as `userChrome.css.txt` (in Notepad, choose "Save as type: All files"). Put this line at the very top and save:
   ```css
   @import url("arc-findbar.css");
   ```
6. **Allow custom styles.** Type `about:config` into the address bar and press Enter. Click **Accept the Risk and Continue**. Search for `toolkit.legacyUserProfileCustomizations.stylesheets` and double-click it so it says `true`.
7. **Optional: Arc-like highlight colors.** Still in `about:config`, set the values from the table under [Arc-like highlight colors](#arc-like-highlight-colors). Search for each name, click the pencil icon, enter the value and confirm with Enter. For `findbar.highlightAll`, double-click it so it says `true`.
8. **Restart Zen.** Close all Zen windows, then open Zen again, and press `Ctrl + F` on any page.

### Updating

Download the newest ZIP and repeat the installation. On macOS, delete the old `zen-arc-findbar-main` folder in Downloads first, so the new one gets the same name, then run the install script again. On Windows and Linux, replace `arc-findbar.css` in the `chrome` folder. Restart Zen afterwards.

Updating replaces `arc-findbar.css`, so any changes you made to it (see [Further customization](#further-customization)) need to be made again.

## Customization

### Arc-like highlight colors

A mod can only style the find bar itself. How matches are highlighted on the page is controlled by browser settings. The macOS install script sets these for you. To set or change them yourself, use `about:config`:

| Preference | Value | What it does |
| --- | --- | --- |
| `findbar.highlightAll` | `true` | Highlight all matches, not just the current one |
| `ui.textHighlightBackground` | `#FFFF00` | All matches: yellow |
| `ui.textHighlightForeground` | `#000000` | All matches: black text |
| `ui.textSelectAttentionBackground` | `#FF9632` | Current match: orange |
| `ui.textSelectAttentionForeground` | `#000000` | Current match: black text |

The "Highlight All" checkbox is hidden by this mod, so `findbar.highlightAll` is how you turn highlighting of all matches on or off.

On macOS, the install script writes these values to `user.js` in your profile, and Zen applies them on every start. Changing them in `about:config` only lasts until the next restart, so edit `user.js` in the profile folder instead.

### Further customization

All sizes and colors are CSS variables at the top of `chrome.css`, for example `--arc-findbar-width`, `--arc-findbar-offset-top` and `--arc-findbar-bg`. Edit them in the downloaded `chrome.css` and install again (macOS), or edit `arc-findbar.css` in your profile's `chrome` folder directly (Windows and Linux). Restart Zen to see the change.

## Known limitations

- The short match count works by letting the trailing word ("matches", "Übereinstimmungen", …) wrap out of view. With very short words, such as "1 of 1 match" in English, the word can still show.
- Match case, whole words and diacritics are hidden. Their last state still applies.
- Built and tested on Zen 1.24 for macOS. Zen updates that change the find bar markup can break the layout.
- Not tested in split view, and not tested on Windows and Linux yet.

## Uninstall

1. Open your profile folder (`about:support` → **Profile Folder**).
2. In the `chrome` folder, delete `arc-findbar.css` and remove the line `@import url("arc-findbar.css");` from `userChrome.css`.
3. macOS only: open `user.js` in the profile folder and delete the lines that came from this mod (the ones listed in this repo's `user.js`).
4. To get the default highlight colors back, open `about:config`, search for each preference from the table above and click the reset arrow next to it.
5. Restart Zen.

## License

[MIT](LICENSE)
