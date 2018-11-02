#!/usr/bin/env bash

commonPrefix() {
  prefix=$1
  IFS_BAK=$IFS
  IFS=$'\n'
  res=0
  for i in $(compgen -d "$2");
  do
    if [ "$prefix" != "$(echo "$i" | cut -c 1-${#prefix})" ];
    then
      res=$((res + 1))
    fi
  done
  IFS=$IFS_BAK
  echo "$res"
}
currentPath=$(pwd)
IFS_BAK=$IFS
IFS='/'
currentPathArray=($currentPath)
IFS=$IFS_BAK

absolutePath="/"
result=""

((n_elements=${#currentPathArray[@]}, max_index=n_elements - 1))
for ((i = 1; i <= max_index; i++)); do
  p=${currentPathArray[i]}
  pathIter=""
  pathChars=$p
  ((pathCharsLen=${#pathChars}, lenPathChars=pathCharsLen - 1))
  for ((j = 0; j <= lenPathChars; j++)); do
    pp=${pathChars:$j:1}
    pathIter=$pathIter$pp
    cd "$absolutePath";
    if [ "$(compgen -d "$pathIter" | wc -l)" == 1 ] || [ "$(commonPrefix "$p" "$pathIter")" == 0 ]; then
      break
    fi
  done
  absolutePath="$absolutePath$p/"
  result="$result/$pathIter"
done
if [ -z "$result" ]; then
  result="/"
fi
echo "${result// /\\ }"
