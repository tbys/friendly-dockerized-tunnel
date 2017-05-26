#! /bin/sh

set -e
warning="Warning: This script should only be used inside a Docker container. Exiting!"
test -f /.dockerenv || (echo ${warning}; exit 1)

echo "$SERVER_HOSTKEY" > ~/.ssh/known_hosts
eval $(ssh-agent -s)
echo "$PRIVATE_KEY" | ssh-add -

cmd="/usr/bin/autossh -M 0 -T -N -v -p $PORT $USER@$HOSTNAME"

#export LOCAL_FORWARDS=*:1111:localhost:2222,localhost:3333:localhost:4444
for l in $(echo $LOCAL_FORWARDS | sed "s/,/ /g")
do
  local_forwards="$local_forwards -L $l"
done

#export REMOTE_FORWARDS=*:1111:localhost:2222,localhost:3333:localhost:4444
for r in $(echo $REMOTE_FORWARDS | sed "s/,/ /g")
do
  remote_forwards="$remote_forwards -R $r"
done

cmd="$cmd $local_forwards $remote_forwards"
echo Running the following command: $cmd
exec $cmd
