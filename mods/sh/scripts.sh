# cd relative to git top level
cdgt() {
  top=$(git rev-parse --show-toplevel 2>/dev/null) || return
  cd "$top/$1" 2>/dev/null || cd "$top" || return
}


# nvim after fzf
vv() {
  nvim $(fzf)
}

