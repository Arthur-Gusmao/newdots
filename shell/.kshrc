#!/bin/sh

_update_vcs_segment() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch
        branch=$(git branch --show-current 2>/dev/null)

        if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
            _VCS_PROMPT_SEGMENT=" ($branch*)"
        else
            _VCS_PROMPT_SEGMENT=" ($branch)"
        fi
    else
        _VCS_PROMPT_SEGMENT=$(hgfast -branch-only 2>/dev/null)
        if [ $? -ne 0 ]; then
            _VCS_PROMPT_SEGMENT=""
        fi
    fi
}

_vcs_chpwd_check() {
    local now_dir
    now_dir=$(pwd)
    if [ "$now_dir" != "$_VCS_CACHED_DIR" ]; then
        _VCS_CACHED_DIR="$now_dir"
        _update_vcs_segment
    fi
}

# Prompt
set_prompt() {
    _vcs_chpwd_check
    local cur_dir=$(pwd)
    
    if [ "$cur_dir" = "$HOME" ]; then
        cur_dir="~"
    else
        cur_dir="${cur_dir#$HOME/}"
        if [ "$cur_dir" != "$(pwd)" ]; then
            cur_dir="~$cur_dir"
        fi
    fi
    echo "${cur_dir}${_VCS_PROMPT_SEGMENT} % "
}

PS1='$(set_prompt)'
