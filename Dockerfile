# Stock Documenso with Cascade Online favicons and email fallback logo baked in. Upgrade = bump this tag.
FROM documenso/documenso:v2.19.0
COPY branding/favicon.ico branding/favicon-16x16.png branding/favicon-32x32.png branding/apple-touch-icon.png branding/android-chrome-192x192.png branding/android-chrome-512x512.png /app/apps/remix/build/client/
COPY branding/logo.png /app/apps/remix/build/client/static/logo.png
