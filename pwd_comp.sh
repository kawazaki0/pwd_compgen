#!/bin/bash

commonPrefix() {
  prefix=$1
  shift
  res=0
  for i in "$@";
  do
    if [ "$prefix" != "$(echo "$i" | cut -c 1-${#prefix})" ];
    then
      res=$((res + 1))
    fi
  done
  echo $res
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
  # pathChars=`echo $p | sed -e 's/\(.\)/\1\n/g'`
  pathChars=$p
  ((pathCharsLen=${#pathChars}, lenPathChars=pathCharsLen - 1))
  for ((j = 0; j <= lenPathChars; j++)); do
    pp=${pathChars:$j:1}
    pathIter=$pathIter$pp
    cd "$absolutePath";
    if [ "$(compgen -d "$pathIter" -P \" -S \" | wc -l)" == 1 ] || [ "$(commonPrefix \"$p\" \`compgen -d "$pathIter"\` -P \" -S \")" == 0 ];
      then
      break
    fi
  done
  absolutePath=$absolutePath"$p/"
  result="$result/$pathIter"
done
if [ -z "$result" ]; then
  result="/"
fi
echo ${result// /\\ }
