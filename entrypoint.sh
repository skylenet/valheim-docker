#!/bin/bash
export templdpath="$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/$PWD/linux64:$LD_LIBRARY_PATH"
export SteamAppId="892970"

# Add admin users
for i in ${SERVER_ADMIN_USERS//,/ }
do
  echo "Adding admin user: $i"
  grep -qxF "$i" /data/adminlist.txt || echo "$i" >> /data/adminlist.txt
done

# Add banned users
for i in ${SERVER_BANNED_USERS//,/ }
do
  echo "Adding banned user: $i"
  grep -qxF "$i" /data/bannedlist.txt || echo "$i" >> /data/bannedlist.txt
done

# Add permitted users
for i in ${SERVER_BANNED_USERS//,/ }
do
  echo "Adding permitted user: $i"
  grep -qxF "$i" /data/permittedlist.txt || echo "$i" >> /data/permittedlist.txt
done

# Run server
./valheim_server.x86_64 -nographics -batchmode \
  -name "${SERVER_NAME}" \
  -port 2456 \
  -world "${SERVER_WORLD}" \
  -password "${SERVER_PASSWORD}" \
  -savedir /data -public 1
