#!/bin/sh -l

command="pscale password create $1 $2 $3 --org $4 -f json"

if [ -n "$5" ];then
  command="$command --role $5"
fi

CMDOUT=$(eval $command)

ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi

username=$(jq -n "$CMDOUT" | jq -r '.username')
password=$(jq -n "$CMDOUT" | jq -r '.plain_text')
hostname=$(jq -n "$CMDOUT" | jq -r '.database_branch.access_host_url')
echo "username=$username" >> $GITHUB_OUTPUT
echo "password=$password" >> $GITHUB_OUTPUT
echo "hostname=$hostname" >> $GITHUB_OUTPUT
