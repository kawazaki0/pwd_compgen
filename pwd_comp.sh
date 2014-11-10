#!/bin/bash

listcontains() {
  for word in $1; do
    [[ $word = $2 ]] && return 0
  done
  return 1
}

pathList=`echo \`pwd\` | sed 's/\//\n/g'`
absolutePath="/"
result=""
for p in $pathList;
do
  pathIter=""
  pathChars=`echo $p | sed -e 's/\(.\)/\1\n/g'`
  for pp in $pathChars;
  do
    pathIter=$pathIter$pp
    if [ `cd $absolutePath; compgen -d $pathIter | wc -l` == 1 ]; 
    then
      break
    fi
  done
  absolutePath=$absolutePath"$p/"
  result="$result/$pathIter"
done
if [ -z $result ]; then
  result="/"
fi
echo $result
