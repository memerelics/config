### Prompt settings ### {{{2
#
autoload -U colors; colors
setopt prompt_subst
unsetopt transient_rprompt

# define prompt color
if [ $SSH_CONNECTION ] || [ $REMOTEHOST ]; then
    color_ok="blue"; color_ng="red"
elif [ `hostname | grep 'vagrant'` ]; then
    color_ok="magenta"; color_ng="yellow"
elif [ `uname` = "Linux" ];then
    color_ok="reset_color"; color_ng="red"
else
    color_ok="green"; color_ng="yellow"
fi

# define color by $?, [count]name, and float $.
PROMPT='%{%(!.$bg[default].%(?.$bg[$color_ok].$bg[$color_ng]))%}\
[`date +%Y/%m/%d` %T]%{$reset_color%} %B%(4~,%-1~...%2~,%~)%b `rprompt-git-current-branch`\
%{$fg[blue]%}\$%{$reset_color%} '

# # git branch, path, date@hostname(define color by $?)
# RPROMPT='`rprompt-git-current-branch`\
# %{$reset_color%}%{$fg[blue]%}%B%(4~,%-1~|%2~,%~)%b \
# %{%(!.$bg[default].%(?.$bg[$color_ok].$bg[$color_ng]))%}\
# %{$fg[black]%}[`date +%Y/%m/%d` %T]%{$reset_color%}'
RPROMPT=''

SPROMPT='%{${bg[red]}%}\
m9(^Д^) \
%R -> %r ?[nyae]%{${reset_color}%} '

# prevent accidentally exit shell by hitting Ctrh-d
stty eof undef


### Aliases ### {{{2
setopt aliases
if [ `uname` = "Darwin" ];then
  alias ls='ls -vFG' sl='ls -vFG' la='ls -avFG' ll='ls -lhrtvFG' l='ls -lhrtvFG' alias y='ls -vFG'
  alias sed='gsed'
else
  alias ls='ls -vF --color' sl='ls -vF --color' la='ls -avF --color' ll='ls -lhrtvF --color' l='ls -lhrtvF --color'
fi
alias laa='ls -vA | grep --ignore-case --color=auto ^\\.'
alias lg='ll -va | grep --ignore-case --color=auto'
alias mv='mv -i' cp='cp -i' rm='rm -i'
alias less='less -R' # colorful less
alias ..='cd ../'
alias his='history'
alias hig='history 500 | grep --color=auto --ignore-case'
alias cal='cal `date +%Y`'
alias today="date +'%Y%m%d'"
alias v='vim'
alias vimrc='vim ~/.vimrc'
alias scon='vim ~/.ssh/config'
alias ifconfig.me='curl ifconfig.me/ip'
alias svim='sudo -H vim --noplugin'
alias rest='sudo -H vim --noplugin /etc/hosts'
alias tz='for tz in US/Pacific US/Central US/Eastern UTC Europe/Dublin Asia/Calcutta Asia/Tokyo Australia/Sydney; do LC_ALL=en_US.UTF-8 TZ=$tz date +"%Z, %Y-%m-%dT%H:%M:%S%z %a"; done'
alias k='kubectl'
alias tf='terraform'
alias tenki='curl wttr.in/Tokyo'
alias gcurl='curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'

### suffix
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bunzip2 $1;;
    *.zip) unzip $1;;
    *.gz) gunzip $1;;
    *.tar) tar xvf $1;;
  esac
}
alias -s {gz,tgz,bz2,tbz,zip,tar}=extract

### tmux
if [ `uname` = "Linux" ];then
  alias tmux='TERM=screen-256color-bce tmux'
fi
alias ta='tmux attach'
alias tmux-key-remote='tmux set-option -ag prefix C-w'
alias tmux-key-local='tmux set-option -ag prefix C-t'

### aptitude
if [ -f /etc/issue ] && cat /etc/issue | grep -q Ubuntu; then
  alias ac='sudo apt-cache'
  alias agi='sudo apt-get install -y'
  alias acs='sudo apt-cache search'
  if [ -f /usr/lib/mozc/mozc_tool ]; then
    alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
    alias mozc-dict='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
  fi
fi


### Global Aliases {{{3
alias -g G='| egrep --color=auto --ignore-case'
alias -g XG='| xargs rg'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g W='| wc'
alias -g TV='| tr "\n" " "'
alias -g N='2> /dev/null'
alias -g TC='tar cvzf'

### Aliases -- for git {{{3
alias g='git'
alias st='git st'
alias gst='git st && g stash list'
alias gs='git st'
alias gb='git br -avv'
alias gf='git fetch -p'
alias gl='git l'
alias gi='git l | head'
alias ga='git add'
alias gc='git commit -m'
alias gcm='git commit -m'
alias gcam='git commit --amend'
alias gco='git checkout -b'
alias gull='git pull origin'
alias gush='git push origin'
function gstitem { # returns n-th file of git status -b -s output
  local nth=$(($1+1))
  git status -b -s | head -n $nth | tail -n 1 | awk '{print $2}'
}
function gsta  { git add -- $(gstitem $1) }
function gstd  { git diff -- $(gstitem $1) }
function gstco { git checkout HEAD -- $(gstitem $1) }


### Set Options ### {{{2
setopt auto_cd
function chpwd() { ls }
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt list_packed
setopt nolistbeep

# Autojump
if [ `uname` = "Darwin" ]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
else
  #TODO: Add Linux settings here
fi

### History ### {{{2
# by default, display latest histories.
 HISTFILE=${HOME}/.zsh_history
 SAVEHIST=500000
 HISTSIZE=500000
 setopt append_history
 setopt hist_ignore_all_dups
 setopt hist_ignore_space
 setopt hist_reduce_blanks
 setopt hist_save_nodups
 setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end


### key bindkeys (bindkey -L) ### {{{2
bindkey -e # contains: Ctrl-F forward-char, Ctrl-B backward-char

bindkey "^G" clear-screen # just in case when Karabiner kills Ctrl-L

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "ƒ" forward-word # Option + F
bindkey "∫" backward-word # Option + B
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

bindkey "^U" backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # backward action of TAB key complete


### libs, miscs ### {{{2
fpath=(~/.zsh $fpath)

# should work only on Mac.
if [ `uname` = "Darwin" ]; then
  # zsh-completions (brew)
  fpath=(~/.zsh /usr/local/share/zsh-completions $fpath)

  #ZSHHOME="${HOME}/.zsh"

  ## autoload ~/.zsh/*.zsh file as a part of .zshrc
  #if [ -d $ZSHHOME -a -r $ZSHHOME -a \
  #  -x $ZSHHOME ]; then
  #for i in $ZSHHOME/*; do
  #  [[ ${i##*/} = *.zsh ]] &&
  #    [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  #done
  #fi

  #if [ -f $ZSHHOME/auto-fu.zsh ]; then
  #  zle-line-init () {auto-fu-init;}
  #  zle -N zle-line-init
  #  #  zstyle ':completion:*' completer _oldlist _complete #_history
  #  zstyle ':auto-fu:highlight' completion/one fg=blue
  #  zstyle ':auto-fu:var' postdisplay $'
  #  navi > '
  #  bindkey-advice-before "^G" afu+cancel
  #  bindkey-advice-before "^[" afu+cancel
  #  bindkey-advice-before "^J" afu+cancel afu+accept-line
  #fi
fi

## completion {{{3
# -u option: ignore "insecure" warning
autoload -U compinit; compinit -u
compdef hub=git

# ignore CASE when complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

### display git branch on the prompt ### {{{3
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
     color=%F{red}
  fi
  echo "$color$name$action%f%b "
}


### autojump settings {{{3
if [ -f /usr/share/autojump/autojump.sh ]; then
  . /usr/share/autojump/autojump.sh
fi

### aws functions {{{3
function ec2ssh () {
    if [ $# -gt 0 ]; then
      echo "Retrieving Public DNS for instance $1..."
      pubname=$(aws ec2 describe-instances --instance-ids $1 --query 'Reservations[0].Instances[0].PublicDnsName' --output text)
      ssh $pubname
    else
      echo "Retrieving Running instances..."
      ec2_hosts="$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running)"
      echo $ec2_hosts
      # sth wrong in jrq parse
      selected_line="$(echo $ec2_hosts | jrq -r '_.Reservations.map(&:Instances).flatten.map{|i| "%30s,%16s,%16s" % [(nameTag = i.Tags.find{|t| t.Key == "Name"}) ? nameTag.Value : (i.Tags.size.zero? ? "--" : i.Tags.first.Value), i.PublicIpAddress,i.PrivateIpAddress] }' | fzf)"
      echo $selected_line
      # key="$(ls $HOME/.ssh | fzf)"
      # echo $selected_line
      if [ $selected_line ]; then
        ec2_ip="$(echo $selected_line | sed 's/ //g'  | awk -F ',' '{print $(NF - 1)}')" # select public ip
        echo $ec2_ip
        # TODO: select region and key
        ssh -i $HOME/.ssh/ec2-key.pem ec2-user@$ec2_ip
      else
        echo "canceled"; return
      fi
    fi
}

### aws cli auto completion {{{3
if [ -f /usr/local/bin/aws_zsh_completer.sh ]; then
  . /usr/local/bin/aws_zsh_completer.sh
fi


### fuzzy selecting ssh target host {{{3

function fuzzy-ssh() {
  target_host="$(grep "^\s*Host " ~/.ssh/config | sed s/"[\s ]*Host "// | sed s/#.*$// | grep -v "^\*$" | sort | fzf)"
  if [ $target_host ]; then
    echo "connecting to" $target_host "..."
    ssh $target_host
  else
    echo "exit fuzzy-ssh"; return
  fi
}
alias sssh='fuzzy-ssh'

# open URL from Firefox bookmarks {{{3
function fb () {
  sqlite_file="$(find $HOME/Library/Application\ Support/Firefox/Profiles/*.default/places.sqlite)"
  if [ ! -e "$sqlite_file" ]; then
    echo "cannot find sqlite file"; return
  fi

  sql="SELECT b.title, p.url FROM moz_bookmarks as b, moz_places as p \
    WHERE b.type = 1 \
      AND b.title IS NOT NULL \
      AND b.fk = p.id \
      AND p.url NOT LIKE 'place:%' \
    ORDER BY b.id;"

  selections="$(sqlite3 $sqlite_file "$sql" | fzf --multi)"
  if [ "$selections" = "" ]; then; return; fi

  echo $selections
  echo $selections | awk -F '|' '{print $(NF)}' | xargs open -a Firefox
}

function cdg() {
  selection="$(ghq list -p | fzf)"
  if [ "$selection" = "" ]; then; return; fi
  cd $selection
}

# load fzf.zsh {{{3
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load awless (AWS 3rd party CLI tool) auto completion {{{3
if [[ -s $HOME/.zshrc.awless ]]; then source $HOME/.zshrc.awless; fi

# load auto suggestion {{{3
# https://github.com/zsh-users/zsh-autosuggestions
if [[ -s $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#065c78'
fi


# rbenv settings (doesn't work in .zshenv) {{{3
if which rbenv > /dev/null; then
  eval "$(rbenv init - zsh)"
fi

if which xkbcomp > /dev/null; then
  # As applying xkb configuration takes some time, skip execution when not needed (i.e. "thashkbd" is already applied).
  if [ `xkbcomp $DISPLAY $HOME/.tmp_xkbcomp && grep -q thashkbd $HOME/.tmp_xkbcomp; echo $?` = 1 ]; then
    echo "[zshrc] applying xkb keymap..."
    xkbcomp -I$HOME/.xkb ~/.xkb/keymap/thashxkb $DISPLAY 2> /dev/null
  fi
fi


# load local settings {{{3
if [[ -s $HOME/.zshrc.local ]]; then source $HOME/.zshrc.local; fi
