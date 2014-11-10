#!/bin/bash

commonPrefix() {
  prefix=$1
  shift
  res=0
  for i in $@;
  do
    if [ $prefix != "`echo $i | cut -c 1-${#prefix}`" ];
    then
      res=$[ $res + 1 ]
    fi
  done
  echo $res
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
    cd $absolutePath;
    if [ `compgen -d $pathIter | wc -l` == 1 ] || [ `commonPrefix $p \`compgen -d $pathIter\`` == 0 ];
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
