#aliases

# utilities
alias pimpgradle="gradle --daemon --parallel"
alias ex="gradle explodedWar"
alias exc="gradle clean explodedWar"
alias pex="pimpgradle explodedWar"
alias pexc="pimpgradle clean explodedWar"


# git related stuff
alias cout="git checkout"
alias bug="git bug"
alias bugf="git bug finish"
alias feature="git feature"
alias featuref="git feature finish"

__git_files () { 
  _wanted files expl 'local files' _files  
}
