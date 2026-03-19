#!/bin/bash
# Claude Code Statusline
# Receives JSON session data via stdin, outputs formatted statusline

input=$(cat)

# Extract data
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "~"')
MODEL=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
CTX_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
GIT_BRANCH=$(echo "$input" | jq -r '.workspace.git_branch // empty')

# Shorten home path
DIR="${DIR/#$HOME/~}"
# Keep only last 2 components if long
if [ "$(echo "$DIR" | tr '/' '\n' | wc -l)" -gt 3 ]; then
    DIR="…/$(echo "$DIR" | rev | cut -d'/' -f1-2 | rev)"
fi

# Colors
R="\033[0m"
DIM="\033[38;5;243m"
BLUE="\033[38;5;75m"
GREEN="\033[38;5;114m"
YELLOW="\033[38;5;220m"
ORANGE="\033[38;5;208m"
RED="\033[38;5;196m"
CYAN="\033[38;5;116m"
MAGENTA="\033[38;5;176m"

SEP="${DIM} │ ${R}"

# Context color by usage
if [ "$CTX_USED" -lt 50 ]; then CC="$GREEN"
elif [ "$CTX_USED" -lt 75 ]; then CC="$YELLOW"
elif [ "$CTX_USED" -lt 90 ]; then CC="$ORANGE"
else CC="$RED"
fi

# Progress bar
BAR=""
FILLED=$((CTX_USED * 5 / 100))
for ((i=0; i<FILLED; i++)); do BAR+="█"; done
for ((i=FILLED; i<5; i++)); do BAR+="░"; done

# Build line
LINE="${BLUE} ${DIR}${R}"
[ -n "$GIT_BRANCH" ] && LINE+="${SEP}${GREEN} ${GIT_BRANCH}${R}"
LINE+="${SEP}${MAGENTA}${MODEL}${R}"
LINE+="${SEP}${CC}ctx ${CTX_USED}%${R} ${CC}${BAR}${R}"
if [ "$(echo "$COST > 0" | bc -l 2>/dev/null)" = "1" ]; then
    LINE+="${SEP}${CYAN}\$ $(printf '%.3f' "$COST")${R}"
fi

echo -e "$LINE"
