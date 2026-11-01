# SGVK Tours and Travels

Single-page website for SGVK Tours and Travels: bus ticket search with seat selection, cab enquiries and TTD (Tirumala) ticket enquiries.

## Structure

- `src/index.html` — the readable source of the whole site (HTML, CSS and JavaScript in one file); edit this
- `index.html` — the minified page Vercel serves, built from the source
- `build.sh` — rebuilds `index.html`: removes unused CSS and minifies HTML, CSS and JS (needs Node.js and Python 3)
- `img/` — photos and the logo
- `vercel.json` — static hosting settings for Vercel

## Run locally

Open `index.html` in a browser, or serve the folder:

```sh
npx serve .
```

## Build

After editing `src/index.html`, run:

```sh
./build.sh
```

and commit both files.

## Deploy

The site is static, with no build step. On Vercel, import this repository and keep the defaults (Framework preset: Other, no build command, output directory `.`).

## Notes

- Bus schedules, fares and seat availability are sample data.
- Cab and TTD enquiries are saved to a database only when the page runs inside a Claude artifact. On any other host, the form shows the customer a "copy details" screen to send by WhatsApp or SMS. Connect a backend (for example a form service or an API) to receive enquiries directly.
