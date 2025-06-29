# file: .zshrc
# created: 2025-06-22 05:50 PM
# updated: 2025-06-29 03:10 PM

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

# set: MSYS2 environment
export MSYSTEM=MSYS

PATH=/usr/bin:/bin:/usr/locla/bin
PATH=$PATH:/mingw64/bin
PATH=$PATH:/mingw32/bin
PATH=$PATH:/clang64/bin
PATH=$PATH:/ucrt64/bin

PATH=$PATH:~/bin
PATH=$PATH:~/bin/node-v22.16.0
PATH=$PATH:~/bin/php-8.4.8-nts

PATH=$PATH:/c/Windows/system32
PATH=$PATH:/c/Windows
PATH=$PATH:/c/Windows/System32/Wbem
PATH=$PATH:/c/Windows/System32/WindowsPowerShell/v1.0
PATH=$PATH:/c/Windows/System32/OpenSSH
PATH=$PATH:~/AppData/Local/Microsoft/WindowsApps

export PATH

# enable zsh completion system
autoload -Uz compinit && compinit

# set: custom prompt (default at: /etc/zsh/zshenv)
NEWLINE=$'\n'
PROMPT="%F{yellow}%~%f ${NEWLINE}%# "

# support: CTRL + Arrow Keys
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# support: CTRL + Backspace
bindkey '^H' backward-kill-word

# support: CTRL + Delete
bindkey '^[[3;5~' kill-word

# support: Delete
bindkey '^[[3~' delete-char
