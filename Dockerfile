# Stock Documenso with Cascade Online favicons, email fallback logo and forced dark mode. Upgrade = bump this tag.
FROM documenso/documenso:v2.19.0
COPY branding/favicon.ico branding/favicon-16x16.png branding/favicon-32x32.png branding/apple-touch-icon.png branding/android-chrome-192x192.png branding/android-chrome-512x512.png /app/apps/remix/build/client/
COPY branding/logo.png /app/apps/remix/build/client/static/logo.png
# Force dark mode for everyone (the theme cookie is ignored); the grep fails the build if an upgrade moves the line.
RUN f=$(ls /app/apps/remix/build/server/assets/server-build-*.js) && sed -i 's/theme: getTheme(),/theme: "dark",/' $f && grep -q 'theme: "dark",' $f
