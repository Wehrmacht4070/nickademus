#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

echo "Everytime you load bash, a Windows computer crashes. Welcome back $USER!"
#echo -e "Today is $(date)\nUptime: $(uptime)"
#echo "Your personal settings have been loaded successfully."
#echo "Good luck today!"
#-------
#ALIASES
#-------
alias update='sudo pacman -Syyuv'
alias fish='asciiquarium'
alias home='cd ~'
alias lsd='ls -ld `find . -maxdepth 1 -type d -o -type l`'
alias ls='ls -lAi --group-directories-first --color='always''
alias reload='. ~/.bash_profile'
alias shutdown='echo “Are you sure you want to do that `hostname` [y/N]?” && read shutdown_answer && if [ “$shutdown_answer” == y ]; then /sbin/shutdown -h now; fi'
alias reboot='echo “Are you sure you want to do that `hostname` [y/N]?” && read reboot_answer && if [ “$reboot_answer” == y ]; then /sbin/reboot; fi'
#alias ipcheck='nmap -sP $(ip -o addr show | grep inet\  | grep eth | cut -d\  -f 7)'
#this is currently under repair, trying to figure out my target error. Any help is most appreciated.
alias path='echo -e ${PATH//:/\\n}'
#ForTheLOLZ
alias busy='cat /dev/urandom | hexdump -C | grep 'ca''
#---------
#FUNCTIONS
#---------
#compressed file extractor
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}


# clock - self explanatory
clock ()
	{
	while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
	}

#netinfo - shows network information for your system
netinfo ()
{
	echo "--------------- Network Information ---------------"
	myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
	echo "${myip}"
  #I am planning on expanding this function to include statistics about network flow and what not
	echo "---------------------------------------------------"
}

#disk usage formatted
function duf {
du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}
