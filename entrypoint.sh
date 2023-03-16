#!/bin/sh -l

command="pscale password create $1 $2 $3 --org $4 -f json"

if [ -n "$5" ];then
  command="$command --role $5"
fi

CMDOUT=$(eval $command)

username=$(jq -n "$CMDOUT" | jq '.username')
password=$(jq -n "$CMDOUT" | jq '.plain_text')
hostname=$(jq -n "$CMDOUT" | jq '.database_branch.access_host_url')
echo "username=$username" >> $GITHUB_OUTPUT
echo "password=$password" >> $GITHUB_OUTPUT
echo "hostname=$hostname" >> $GITHUB_OUTPUT