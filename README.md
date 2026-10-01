# sign

[Documenso](https://github.com/documenso/documenso) e-signature server for Cascade Online at
https://sign.cascadeonline.dev. Runs on gpu1 as a Coolify docker-compose app; the tunnel,
DNS and env setup are documented in `homelab-command` (`hosts/gpu1.md` → "Documenso").

- Secrets (`NEXTAUTH_SECRET`, encryption keys, `POSTGRES_PASSWORD`, signing cert,
  `SENDGRID_API_KEY`) are Coolify env vars; copies live in `homelab-command/.env`.
- Upgrade: bump the `FROM` tag in `Dockerfile`, push, redeploy. Migrations run on container start.
- `branding/`: Cascade favicons and logos, copied over the stock files by `Dockerfile`.
  `patch.sh` then pins every visitor to dark mode, loads `cascade.css` (Cascade dark palette
  and header wordmark for the whole web app) and points emails at `static/logo.png` (dark
  wordmark, for white emails). Each patch greps for its result, so an upgrade that moves a
  target fails the build. `logo-horizontal-dark.png` (light wordmark) is also the org branding
  logo uploaded in Documenso settings; the org `brandingColors` stay light because emails use them.
- API client: `cascade-online-documents/sign.py`.
