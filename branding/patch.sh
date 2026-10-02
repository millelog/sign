#!/bin/sh
# Patches Documenso's build for Cascade Online; each grep fails the image build if an upgrade moves its target.
set -eu
cd /app/apps/remix/build
srv=$(ls server/assets/server-build-*.js)

# Force dark mode for everyone (the theme cookie is ignored).
sed -i 's/theme: getTheme(),/theme: "dark",/' "$srv"
grep -q 'theme: "dark",' "$srv"

# Load cascade.css on every page; ?v= busts Cloudflare and browser caches when it changes.
v=$(md5sum client/static/cascade.css | cut -c1-8)
sed -i 's#href: `${basePath}/site.webmanifest`#& }), jsx("link", { rel: "stylesheet", href: "/static/cascade.css?v='"$v"'"#' "$srv"
grep -q "cascade.css?v=$v" "$srv"

# Emails sit on white, so they get the dark-wordmark static/logo.png, not the org logo (light, for the dark web app).
for f in server/assets/get-email-context-*.js server/hono/packages/lib/utils/team-global-settings-to-branding.js; do
  sed -i 's#/api/branding/logo/[a-z]*/${[a-zA-Z]*}#/static/logo.png#g' "$f"
  ! grep -q 'api/branding/logo/' "$f"
done

# Signer IPs: Traefik overwrites X-Forwarded-For with the Docker gateway, so trust Cloudflare's header first
# (the origin is reachable only through the tunnel, and Cloudflare always sets it).
cf='if (req.headers.get("cf-connecting-ip")) return req.headers.get("cf-connecting-ip").trim();'
sed -i "s#const getIpAddress = (req) => {#& $cf#" "$srv"
sed -i "s#const getIpAddress = req => {#& $cf#" server/hono/packages/lib/universal/get-ip-address.js
grep -q 'getIpAddress = (req) => { if (req.headers.get("cf-connecting-ip"))' "$srv"
grep -q 'getIpAddress = req => { if (req.headers.get("cf-connecting-ip"))' server/hono/packages/lib/universal/get-ip-address.js
