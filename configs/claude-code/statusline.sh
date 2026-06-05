#!/bin/bash
# Claude Code Statusline - multi-line with dynamic separator bar
# Receives JSON session data via stdin, outputs formatted statusline

input=$(cat)

# Extract data
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "~"')
MODEL=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
CTX_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
CTX_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
TOKENS_IN=$(echo "$input" | jq -r '(.context_window.current_usage.cache_read_input_tokens // 0) + (.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0)')
TOKENS_OUT=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
DURATION=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')

# Git branch: try symbolic-ref first (works for normal branches), fallback to rev-parse
GIT_BRANCH=$(git -C "$DIR" symbolic-ref --short HEAD 2>/dev/null || git -C "$DIR" describe --tags --exact-match HEAD 2>/dev/null || git -C "$DIR" rev-parse --short HEAD 2>/dev/null)

# Shorten home path (full ~/path, no truncation)
REAL_HOME="${HOME:-/home/$(whoami)}"
DIR="${DIR/#$REAL_HOME/\~}"

# Format token counts (human readable)
fmt_tokens() {
    local n=$1
    if [ "$n" -ge 1000000 ]; then
        LC_NUMERIC=C printf "%.1fM" "$(echo "$n / 1000000" | bc -l)"
    elif [ "$n" -ge 1000 ]; then
        LC_NUMERIC=C printf "%.1fk" "$(echo "$n / 1000" | bc -l)"
    else
        echo "$n"
    fi
}

# Format duration
fmt_duration() {
    local ms=$1
    local secs=$((ms / 1000))
    if [ "$secs" -ge 3600 ]; then
        printf "%dh%02dm" $((secs/3600)) $(((secs%3600)/60))
    elif [ "$secs" -ge 60 ]; then
        printf "%dm%02ds" $((secs/60)) $((secs%60))
    else
        printf "%ds" "$secs"
    fi
}

TIN=$(fmt_tokens "$TOKENS_IN")
TOUT=$(fmt_tokens "$TOKENS_OUT")
DUR=$(fmt_duration "$DURATION")

# Context window size label
if [ "$CTX_SIZE" -ge 1000000 ]; then
    CTX_LABEL="$(( CTX_SIZE / 1000000 ))M"
else
    CTX_LABEL="$(( CTX_SIZE / 1000 ))k"
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
WHITE="\033[38;5;252m"

SEP="${DIM} │ ${R}"

# Context color by usage
if [ "$CTX_USED" -lt 50 ]; then CC="$GREEN"
elif [ "$CTX_USED" -lt 75 ]; then CC="$YELLOW"
elif [ "$CTX_USED" -lt 90 ]; then CC="$ORANGE"
else CC="$RED"
fi

# Progress bar (10 chars wide)
BAR_LEN=10
FILLED=$((CTX_USED * BAR_LEN / 100))
BAR="${CC}"
for ((i=0; i<FILLED; i++)); do BAR+="█"; done
for ((i=FILLED; i<BAR_LEN; i++)); do BAR+="░"; done
BAR+="${R}"

# Line 1: dir │ branch │ model
L1="${BLUE} ${DIR}${R}"
[ -n "$GIT_BRANCH" ] && L1+="${SEP}${GREEN} ${GIT_BRANCH}${R}"
L1+="${SEP}${MAGENTA}${MODEL}${R}"

# Effort color by level (max=vermelho, xhigh=laranja, high=amarelo, medium=verde, low=neutro)
case "$EFFORT" in
    max)    EC="$RED" ;;
    xhigh)  EC="$ORANGE" ;;
    high)   EC="$YELLOW" ;;
    medium) EC="$GREEN" ;;
    *)      EC="$DIM" ;;
esac

# Line 2: session ctx │ tokens │ duration │ effort
L2="${CC} ctx ${CTX_USED}% of ${CTX_LABEL}${R} ${BAR}${SEP}${CYAN}↑${TIN} ↓${TOUT}${R}${SEP}${WHITE}session ${DUR}${R}"
[ -n "$EFFORT" ] && L2+="${SEP}${EC}effort: ${EFFORT}${R}"

echo -e "${L1}\n${L2}"
