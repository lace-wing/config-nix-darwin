# cd relative to git top level
cd_git_top() {
  top=$(git rev-parse --show-toplevel 2>/dev/null) || return
  cd "$top/$1" 2>/dev/null || cd "$top" || return
}


# editor after fzf
fzf_editor() {
  "$EDITOR" $(fzf)
}

# zellij attach or create with layout
zellij_session_layout() {
  zellij attach "$1" 2>/dev/null || zellij --session "$1" --new-session-with-layout "${1:-default}"
}

