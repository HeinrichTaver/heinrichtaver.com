#!/bin/sh
#
# build.sh — Script for build my site
# ======================================================================
#
# Author:
# ----------------------------------------------------------------------
# Heinrich van Tol Taver
#
# Commentary:
# ----------------------------------------------------------------------
# Originally meant to be an Emacs Lisp code, right now I'll be doing
# in POSIX shell just because it's what I know. Probably I'll be
# rewriting this in a later stage.
#
# As with everything else, since I want to do all by myself, I will
# not be using Elmstatic, Hugo or anything like that.
#
#
# TODO:
# ----------------------------------------------------------------------

main() {
  echo "Cleaning public directory."
  mkdir -p public
  rm -rf public/*

  echo "Copying static resources."
  cp -r src/resources public/@

  echo "Building site pages."
  for index in $(find src/pages -iname index.html); do
    target_file=${index#src/pages/}
    target_dir=${target_file%/index.html}

    # Prevents creating a `public/index.html` directory
    [ "$target_file" != "$target_dir" ] && mkdir -p public/$target_dir

    title=$(grep "title:" src/pages/$target_file)
    title="${title#*title: }"
    [ "$title" = "-" ] && title=""
    [ "$title" != "" ] && title="$title | "

    category="${target_dir%/*}"

    cat src/template/header.html \
        src/pages/$target_file \
        src/template/footer.html \
      | awk '
        {
          if ($0 ~ /\$TITLE_CONTENT\$/) {
             gsub(/\$TITLE_CONTENT\$/, title, $0);
             print
          } else if ($0 ~ category) {
             gsub(/\$ACTIVE_PAGE\$/, "current-category", $0);
             print
          } else {
             gsub(/\$ACTIVE_PAGE\$/, "", $0);
             print
          }
        }' title="$title" category="$category" \
          > public/$target_file
  done

  echo "Done."
}

# Entry point
# ======================================================================

main
