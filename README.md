# sign

[Documenso](https://github.com/documenso/documenso) e-signature server for Cascade Online at
https://sign.cascadeonline.dev. Runs on gpu1 as a Coolify docker-compose app; the tunnel,
DNS and env setup are documented in `homelab-command` (`hosts/gpu1.md` → "Documenso").

- Secrets (`NEXTAUTH_SECRET`, encryption keys, `POSTGRES_PASSWORD`, signing cert,
  `SENDGRID_API_KEY`) are Coolify env vars; copies live in `homelab-command/.env`.
- Upgrade: bump the `FROM` tag in `Dockerfile`, push, redeploy. Migrations run on container start.
- `branding/`: Cascade favicons and the email fallback logo, copied over the stock files by
  `Dockerfile`. `logo-horizontal-dark.png` (light wordmark, for the dark theme) is the org branding logo uploaded in Documenso settings. `Dockerfile` also pins every visitor to dark mode (one sed on the server build; the grep fails the build on an upgrade that moves it).
- API client: `cascade-online-documents/sign.py`.
