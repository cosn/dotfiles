#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract information from JSON
model_name=$(echo "$input" | jq -r '.model.display_name')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Extract context window information
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
current_usage=$(echo "$input" | jq '.context_window.current_usage')

# Calculate context percentage
if [ "$current_usage" != "null" ]; then
    current_tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    context_percent=$((current_tokens * 100 / context_size))
else
    context_percent=0
fi

# Build context progress bar (20 chars wide)
bar_width=15
filled=$((context_percent * bar_width / 100))
empty=$((bar_width - filled))
bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

# Extract cost information
session_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
[ "$session_cost" != "empty" ] && session_cost=$(printf "%.4f" "$session_cost") || session_cost=""

# Get directory name (basename), with special handling for epsilon repos
dir_name=$(basename "$current_dir")
if [[ "$current_dir" =~ /accrual/epsilon/([0-9]+)(/|$) ]]; then
    dir_name="epsilon/${BASH_REMATCH[1]}/${dir_name}"
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Change to the current directory to get git info
cd "$current_dir" 2>/dev/null || cd /

# Get git branch
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || echo "detached")
    
    # Get git status with file counts
    status_output=$(git status --porcelain 2>/dev/null)
    
    if [ -n "$status_output" ]; then
        # Count files and get basic line stats
        total_files=$(echo "$status_output" | wc -l | xargs)
        line_stats=$(git diff --numstat HEAD 2>/dev/null | awk '{added+=$1; removed+=$2} END {print added+0, removed+0}')
        
        added=$(echo $line_stats | cut -d' ' -f1)
        removed=$(echo $line_stats | cut -d' ' -f2)
        
        # Build status display
        git_info=" ${YELLOW}($branch${NC} ${YELLOW}|${NC} ${GRAY}${total_files} files${NC}"
        
        [ "$added" -gt 0 ] && git_info="${git_info} ${GREEN}+${added}${NC}"
        [ "$removed" -gt 0 ] && git_info="${git_info} ${RED}-${removed}${NC}"
        
        git_info="${git_info} ${YELLOW})${NC}"
    else
        git_info=" ${YELLOW}($branch)${NC}"
    fi
else
    git_info=""
fi

# Extract rate limit info (only present for Pro/Max after first API call)
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
five_hour_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

# Add session cost if available
cost_info=""
if [ -n "$session_cost" ] && [ "$session_cost" != "null" ] && [ "$session_cost" != "empty" ]; then
    cost_info=" ${GRAY}[\$$session_cost]${NC}"
fi

# Build rate limit display
rate_info=""
if [ -n "$five_hour_pct" ]; then
    five_h_int=$(printf "%.0f" "$five_hour_pct")

    if [ "$five_h_int" -ge 90 ]; then
        rl_color=$RED
    elif [ "$five_h_int" -ge 70 ]; then
        rl_color=$YELLOW
    else
        rl_color=$GREEN
    fi

    rate_info=" ${GRAY}[${NC}${rl_color}5h:${five_h_int}%${NC}"

    if [ -n "$five_hour_resets" ] && [ "$five_h_int" -ge 70 ]; then
        now=$(date +%s)
        mins_left=$(( (five_hour_resets - now) / 60 ))
        rate_info="${rate_info} ${GRAY}${mins_left}m left${NC}"
    fi

    if [ -n "$seven_day_pct" ]; then
        seven_d_int=$(printf "%.0f" "$seven_day_pct")
        rate_info="${rate_info} ${GRAY}7d:${seven_d_int}%${NC}"
    fi

    rate_info="${rate_info}${GRAY}]${NC}"
fi

# Build context bar display
context_info="${GRAY}${bar}${NC} ${context_percent}%"

# Output the status line
echo -e "${BLUE}${dir_name}${NC} ${GRAY}|${NC} ${CYAN}${model_name}${NC} ${GRAY}|${NC} ${context_info}${git_info:+ ${GRAY}|${NC}}${git_info}${cost_info}${rate_info}"