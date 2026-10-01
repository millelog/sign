# sign

[Documenso](https://github.com/documenso/documenso) e-signature server for Cascade Online at
https://sign.cascadeonline.dev. Runs on gpu1 as a Coolify docker-compose app; the tunnel,
DNS and env setup are documented in `homelab-command` (`hosts/gpu1.md` → "Documenso").

- Secrets (`NEXTAUTH_SECRET`, encryption keys, `POSTGRES_PASSWORD`, signing cert,
  `SENDGRID_API_KEY`) are Coolify env vars; copies live in `homelab-command/.env`.
- Upgrade: bump the `FROM` tag in `Dockerfile`, push, redeploy. Migrations run on container start.
- `branding/`: Cascade favicons and the email fallback logo, copied over the stock files by
  `Dockerfile`. `logo-horizontal.png` is the org branding logo uploaded in Documenso settings.
- API client: `cascade-online-documents/sign.py`.
