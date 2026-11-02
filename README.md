# حواجز بيروت · Hawajiz Beirut

Live alerts for moto riders in Beirut: where the hawajiz are right now, a form to report one on WhatsApp, timed ads, and Whish donations. Arabic and dark mode by default, with English and light mode as buttons.

## How it works

- `index.html` is the whole site.
- `data.json` holds the hawajiz, the ads and the settings. The site reads it on load and every minute after.
- The admin screen (the **الإدارة / Admin** link at the bottom of the page) saves changes by committing a new `data.json` to this repo through the GitHub API. GitHub Pages redeploys in about a minute.

## One-time setup

1. **Turn on GitHub Pages:** Settings → Pages → Source: *Deploy from a branch* → Branch: `main`, folder `/ (root)` → Save.
2. **Make a token for the admin screen:** GitHub → Settings → Developer settings → Fine-grained tokens → Generate new token.
   - Repository access: *Only select repositories* → this repo.
   - Permissions → Repository permissions → **Contents: Read and write**.
3. Open the site, tap **الإدارة**, enter the admin password, then paste the token under **ربط GitHub / GitHub connection**. It is stored only in that browser.

## Security note

The admin password only hides the admin screen. Because this is a public static site, its hash sits in the page source. What actually protects your data is the GitHub token: without it, nobody can change `data.json`. Never share the token, and revoke it on GitHub if a phone with it saved is lost.
