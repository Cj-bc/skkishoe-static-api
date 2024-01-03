#!/bin/awk -f

BEGIN {
    # Ensure 'dst' is a directory and exists.
    if (dst == "") dst = "midashis/"
    if (dst !~ /\//) dst = dst "/"
    if (system("test -d " dst)) system("mkdir -p " dst)
}

/^;; / { next; }

{
    cands = substr($2, 2)
    if ($1 ~ /[./\\\\=]/) next

    entries[$1] = entries[$1] cands
}

END {
    for (i in entries)
		print substr(entries[i], 1, length(entries[i]) - 1) > (dst i)
}
