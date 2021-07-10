#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
EDITOR=mcedit
LIST_LANG="en ru uk"

system_language() {
  local UP_LANG_SELECT LANG_UTF8 STR_READ
  if ! [ -d ~/.config ]; then
     mkdir ~/.config
  fi
  if ! [ -f ~/.config/lang.conf  ]; then
     while [ "$LIST_LANG" = "${LIST_LANG#*$LANG_SELECT}" ] ; do
           STR_READ=`echo "$(tput bold)$(tput setaf 2)Specify the required language: $(tput setaf 1) ${LIST_LANG} $(tput sgr0)"`
           read -p "${STR_READ}" LANG_SELECT
           if [ "$LIST_LANG" = "${LIST_LANG#*$LANG_SELECT}" ]; then
              echo "Incorrect value"
           else
              echo -e "LANG_SELECT=$LANG_SELECT" > ~/.config/lang.conf
              echo "OK"
           fi
     done
  fi
  source ~/.config/lang.conf
  loadkeys $LANG_SELECT
  UP_LANG_SELECT=`echo "${LANG_SELECT^^}"`
  LANG_UTF8=$LANG_SELECT"_"${UP_LANG_SELECT}.UTF-8
  export LANG=$LANG_UTF8
  setfont cyr-sun16
#  clear
}

system_language

lang=`echo $LANG | cut -b 1,2`

if [[ ${lang} == "ru" ]]; then
   description="- Чтобы установить дистрибутив, используйте скрипт:"
elif [[ ${lang} == "uk" ]]; then
   description="- Щоб встановити дистрибутив, використовуйте скрипт:"
else
   description="- To install the distribution, use the script:"
fi

IP=`hostname -i`
PS1="\[$(tput bold)\]\[$(tput setaf 4)\]Snug\[$(tput setaf 3)\]Linux\[$(tput sgr0)\] ${description} \[$(tput setaf 1)\]install-snuglinux\[$(tput sgr0)\]\nIP: ${IP}\n[\[$(tput setaf 2)\]\u\[$(tput setaf 3)\]\[$(tput setaf 7)\]@\[$(tput setaf 5)\]\h \[$(tput setaf 7)\]\W]\\$ \[$(tput sgr0)\]"
