#!/bin/bash
# Idea and interface taken from https://github.com/macmade/host-manager

path="/etc/hosts"
addusage="Usage: `basename $0` -add host address"
remusage="Usage: `basename $0` -remove host"

case "$1" in
-add)
  if [ $# -eq 3 ]; then
    if [[ -n $(grep "^$3.*[^A-Za-z0-9\.]$2$" ${path}) ]]; then
      echo "Duplicate address/host combination, ${path} not changed."
    else
      printf "$3\t$2\n" >> ${path}
      echo "${2} added to your hosts list."
    fi
  else
    echo $addusage;
  fi
  ;;
-remove)
  if [ $# -eq 2 ]; then
    sed -i '' -e "s/^[^#].*[^A-Za-z0-9\.]$2$//g" -e "/^$/ d" ${path}
    echo "${2} removed from your hosts list."
  else
    echo $remusage;
  fi
  ;;
*)
  echo $addusage;
  echo $remusage;
esac