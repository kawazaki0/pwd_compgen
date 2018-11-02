#!/usr/bin/env bash
#set -euo pipefail
#trap 'printf %s\\n "$BASH_COMMAND" >&2' DEBUG

function assert {
  TEST_DIR=$1
  BASE_DIR=$2
  #echo $TEST_DIR $BASE_DIR
  TEST_DIR_PREFIX=$(cd $TEST_DIR; /.${BASE_DIR}/pwd_comp.sh)/
  #echo $TEST_DIR_PREFIX
  DIR_TO_TEST=$3
  EXPECTED_STRING=$4
  ACTUAL=$(cd $TEST_DIR/$DIR_TO_TEST; /.${BASE_DIR}/pwd_comp.sh | sed -e "s|^${TEST_DIR_PREFIX}||" )
  if [ $ACTUAL != $EXPECTED_STRING ]; then
    echo $ACTUAL $EXPECTED_STRING
  fi
}

BASE_DIR=$(pwd)
TEST_DIR=/tmp/pwd_comp_tests
trap "rm -r $TEST_DIR" ERR
echo $TEST_DIR
mkdir $TEST_DIR
#(cd $DEST_DIR; /.${BASE_DIR}/pwd_comp.sh | sed -e "s|^${TEST_DIR}||" )

mkdir $TEST_DIR/aabbb
mkdir $TEST_DIR/aabcc
mkdir $TEST_DIR/cdef
mkdir $TEST_DIR/df
mkdir $TEST_DIR/dfdddddf
mkdir $TEST_DIR/dddddddf

assert $TEST_DIR $BASE_DIR aabbb aabb
assert $TEST_DIR $BASE_DIR aabcc aabc
assert $TEST_DIR $BASE_DIR cdef c
assert $TEST_DIR $BASE_DIR df df
assert $TEST_DIR $BASE_DIR dfdddddf dfd
assert $TEST_DIR $BASE_DIR dddddddf dd2


rm -r $TEST_DIR
