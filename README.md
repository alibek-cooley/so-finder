# SO Finder — Discovery Flow

A static prototype for the **Service Offering Finder** discovery flow. Lets a
user pick an entry point (entity / fact pattern / person / event), search a
client by name, browse recommended Service Offerings, drill into specific
matters, and submit feedback.

Built from Figma designs, single-file HTML + Tailwind (CDN). No build step.

---

## Features

- **Dashboard** — pick one of four entry points
- **By Company search** — autocomplete dropdown, "Nothing found" hint, full
  results state with metric cards (Industry, Size, Entity type, HQ, Founded,
  Jurisdiction, Status)
- **No-results state** — close-match suggestions from Salesforce, request-to-add
  flow, switch-to-experiences fallback
- **Service Offering grid** — Existing / Prospect cards
- **Drawer (right slide-over)**
  - List view: matter cards graded **Rich / Partial / Poor**
  - Detail view: status / geography / outcome / complexity, 5-step phase
    pipeline (Diligence → Negotiation → Sign → Regulatory → Close), team & role
    signals, narrative quality
- **Feedback modal** with sentiment chips, issue tags, comment, and a thanks
  state on submit
- Esc / backdrop / X to dismiss any overlay

---

## Run locally

The project is plain HTML — open `index.html` in any browser.

If you want HTTP (e.g. for sharing on your LAN), there's a tiny PowerShell
server included:

```powershell
.\serve.ps1            # http://localhost:8080
.\serve.ps1 -Port 9090 # custom port
```

---

## Deploy to GitHub Pages (free, always-on, no machine needed)

1. Create a new GitHub repo and push this folder to it:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/<your-username>/<repo>.git
   git push -u origin main
   ```
2. On GitHub, go to **Settings → Pages**.
3. Under **Build and deployment**, set **Source = Deploy from a branch**, pick
   `main` and `/ (root)`, save.
4. Wait ~1 minute. Your site will be live at:
   `https://<your-username>.github.io/<repo>/`

Share that URL with the project owner — it stays up regardless of whether
your machine is on.

> Note: GitHub Pages only serves *public* repo content (or private with a paid
> plan). The placeholder data here is non-sensitive, but double-check before
> making the repo public.

---

## Project structure

```
so-finder/
├── index.html            # The whole app (markup + styles + JS)
├── assets/
│   └── logo.png          # Sidebar logo
├── serve.ps1             # Tiny local HTTP server (Windows / PowerShell)
├── README.md
└── .gitignore
```

---

## Tech notes

- **No build step** — uses Tailwind CSS via CDN.
- **No framework** — vanilla HTML + JS, all state held in module-scope variables
  (`currentEntity`, `currentMatters`).
- **Icons** — masked SVGs as inline data-URIs so they recolor cleanly.
- **Fonts** — `Arial Nova` (body) and `GT Sectra` (display). System / fallback
  fonts kick in if these aren't installed.

---

## Source design

[Figma — SO Finder Discovery Flow v1](https://www.figma.com/design/X7Jb5PXGLmc4eBDqP10kpR/SO-Finder-%E2%80%94-Discovery-Flow-v1)
