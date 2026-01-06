# lang: by nix

# Colors {{{
export TERM="xterm-256color"
[[ -n $TMUX ]] && export TERM="tmux-256color"
export CLICOLOR=1
export LSCOLORS="ExFxBxDxCxegedabagacad"
# }}}

# PATH {{{
# add py 3.11 to PATH
# export PATH="/usr/local/opt/python@3.11/libexec/bin:/usr/local/sbin:$PATH"

# add dotnet tools to PATH
# export PATH="$PATH:$HOME/.dotnet/tools"

# add nvim mason bins to path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
# }}}

# Other Env {{{
# editors: by nix

# }}}

# Zsh Features {{{
# configuring zsh compltion
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

# adding extra function sources
fpath=($HOME/.config/completions/zsh.* $fpath)

# enable autocompletion for subcommands
autoload -Uz compinit && compinit

# enable command editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# enable vcs info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
# git info style
zstyle ':vcs_info:git:*' formats '%b'
# }}}

# External Features{{{
# sourcing carapace for its completions
source <(carapace _carapace)

# zoxide init (after compinit)
eval "$(zoxide init zsh)"
# }}}

# Prompt {{{
setopt PROMPT_SUBST

export PROMPT='%n%F{cyan}@%f%m%F{cyan}:%f%F{yellow}%3~%f %F{blue}${vcs_info_msg_0_}%f
%# '
export RPROMPT='%0(?..%F{red}%?%f)'

precmd() {
  echo ""
}
# }}}

# Aliases {{{
# rc alias
alias rc="$EDITOR ~/.zshrc"
alias trc="$EDITOR ~/.tmux.conf"
alias nrc="$EDITOR ~/.config/nvim/init.lua"

# cd
cdgt() {
  cd $(git rev-parse --show-toplevel)
}
alias cddc="cd ~/Documents/"
alias cddw="cd ~/Downloads/"
alias cdds="cd ~/Desktop/"
alias cdpc="cd ~/Pictures/Saved\ Pictures/"
alias cdss="cd ~/Pictures/Screen\ Shot/"
alias cdas="cd ~/Library/Application\ Support/"
alias cdic="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias cd=z

# ls
alias l="ls -o"
alias la="ls -a"
alias ll="ls -la"

# neovim
alias v=nvim
# nvim after fzf
vv() {
  nvim $(fzf)
}

# tmux
alias tn="tmux new-session -A -s"
# }}}

# startup visuals and commands

