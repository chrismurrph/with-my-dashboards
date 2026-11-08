#!/usr/bin/env bash
# Search the history of Claude Code sessions that WMD keeps
# (session-history.edn beside config.edn): titles, trails of recaps, last
# requests, folders. Every word must match, in any case. Newest first, each with
# the command that resumes it. The panel's Sessions section has the same search.
#   ./session-find.sh WORDS...
# MDSERVE_PORT picks the WMD to ask (default 7000).
[ $# -gt 0 ] || { echo "usage: session-find.sh WORDS..." >&2; exit 2; }
port="${MDSERVE_PORT:-7000}"
curl -sfG --data-urlencode "q=$*" --data "format=text" "http://localhost:$port/sessions/find" ||
  { echo "session-find.sh: no WMD on port $port. The history file itself is session-history.edn beside config.edn (one session per line)." >&2; exit 1; }
