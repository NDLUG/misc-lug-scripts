#!/bin/bash
# post-to-lug-blog.sh
# Creates and posts new post to lug blug

USER=$USER
HOST="ndlug.org"
DESTINATION="/var/www/ndlug.org/content/post"

usage() {
    cat <<EOF
Usage: ./post-to-lug-blog.sh

    Opens a new post using $EDITOR and posts to blog.

    -u ndlug.org username
EOF
    exit 0
}

while getopts "hu:" arg; do
    case $arg in
        u) USER=$OPTARG ;;
        h) usage ;;
        *) usage ;;
    esac
done

echo -n "Post filename? "
read -r filename

tmpfile=$(mktemp)

cat <<EOF > "$tmpfile"
+++
date = "$(date -u +"%FT%TZ")"
title = "Mah post"
draft = false
author = "Derpy McDerpiwitz"
summary = "wewwweeewet"
+++

This is my super fun content
EOF

$EDITOR "$tmpfile"
scp "$tmpfile" "$USER@$HOST:$DESTINATION/$filename"
echo "Post posted to $HOST."
