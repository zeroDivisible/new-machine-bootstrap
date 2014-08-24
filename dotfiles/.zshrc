ZSH=$HOME/.oh-my-zsh
ZSH_THEME="nanotech"
plugins=(git git-extras brew brew-cask bundler docker osx gem colorize colored-man cp go golang node npm rbenv zsh-syntax-highlighting)

# variables
export EDITOR='mvim'
export MANPATH=`man -w`

# ======= alises =======
alias ls='ls -h'
alias lsock='lsof -Pnl +M -i4'

# ======= git ailases =======
alias gc='git commit'
alias gs='git status -sb'
alias gg='git grep'


alias vi='vim'
# ====== shortcuts ======
alias b='brew'
alias bup='brew update && brew upgrade'
alias h='history'


# global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# pipe aliases
alias -g G='| grep '

# history settings
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
export HISTCONTROL=ignoredups:erasedups

autoload -U colors && colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# keybindings
bindkey -v

# export variables
# android sdk, from brew 
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
#export JAVA_HOME=/opt/java

export GRADLE_HOME=/usr/local/Cellar/gradle/1.7/
export GISTIT_TOKEN="e8fa68115dcff2b24f6be9039250f4cfa78e1180"

# private dev stuff, don't want that one on GitHub :)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/dev.zsh

fpath=(/usr/local/share/zsh-completions $fpath)

export GOROOT=/usr/local/Cellar/go/1.3/libexec/
export GOPATH=$HOME/Dev/go

export PATH=$GOPATH/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:$JAVA_HOME/bin:~/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH
eval "$(rbenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


setopt autopushd # turn cd into pushd for all situations 
setopt APPEND_HISTORY
setopt AUTO_CD # cd if no matching command
setopt EXTENDED_HISTORY # saves timestamps on history
setopt EXTENDED_GLOB # globs #, ~ and ^
setopt PUSHDMINUS       # make using cd -3 go to the 3rd directory history (dh) directory instead of having to use + (the default)
setopt PUSHD_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_PARAM_SLASH # adds slash at end of tabbed dirs
setopt CHECK_JOBS # check bg jobs on exit
setopt CORRECT # corrects spelling
setopt CORRECT_ALL # corrects spelling

setopt GLOB_DOTS # find dotfiles easier
setopt HASH_CMDS # save cmd location to skip PATH lookup
setopt HIST_NO_STORE # don't save 'history' cmd in history
setopt INC_APPEND_HISTORY # append history as command are entered
setopt LIST_ROWS_FIRST # completion options left-to-right, top-to-bottom
setopt LIST_TYPES # show file types in list
setopt MARK_DIRS # adds slash to end of completed dirs
setopt NUMERIC_GLOB_SORT # sort numerically first, before alpha
setopt SHARE_HISTORY # share history between open shells

# Remove all duplicates from history
setopt hist_ignore_all_dups

setopt notify

# custom keybindings
# alt + back removes a word
bindkey "^[" backward-kill-word

autoload -U zutil
autoload -U compinit
autoload -U complist
compinit -i -d $ZSH/run/zcompdump-$HOST-$UID

unsetopt list_beep
setopt complete_in_word # Allow completion from within a word/phrase

#some of the default stuff from clint's prompt
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format $'\033[22;35mCompleting %d\e[0m'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')


# get the API keys sourced
source ~/.keys

