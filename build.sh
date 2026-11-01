#!/bin/sh
# Build the served index.html from src/index.html:
# 1. drop CSS rules no element or script on the page uses (PurgeCSS),
# 2. minify HTML, CSS and JS.
set -e
cd "$(dirname "$0")"
tmp=$(mktemp -d)
python3 - "$tmp" <<'PY'
import re,sys
t=sys.argv[1];s=open('src/index.html').read()
m=re.search(r'<style>(.*?)</style>',s,re.S)
open(t+'/in.css','w').write(m.group(1))
open(t+'/content.html','w').write(s.replace(m.group(0),'<style>/*CSS*/</style>'))
PY
mkdir -p "$tmp/out"
npx -y purgecss@6.0.0 --css "$tmp/in.css" --content "$tmp/content.html" --output "$tmp/out" --safelist html body >/dev/null 2>&1
python3 - "$tmp" <<'PY'
import sys
t=sys.argv[1];s=open(t+'/content.html').read()
open(t+'/purged.html','w').write(s.replace('/*CSS*/',open(t+'/out/in.css').read()))
PY
npx -y html-minifier-terser@7.2.0 \
  --collapse-whitespace --conservative-collapse --remove-comments \
  --minify-css true --minify-js true \
  -o index.html "$tmp/purged.html"
rm -rf "$tmp"
