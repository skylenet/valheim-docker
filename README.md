# valheim-docker

Running a dedicated [Valheim](https://www.valheimgame.com/) game server using docker

## Configuration

ENV Var | Default value | Description
------- | ---- | --
SERVER_NAME | My Valheim Server | Name that will appear on the server list
SERVER_PASSWORD | youshouldchangethis | Password required to enter the server
SERVER_WORLD | Dedicated | Unique name of your world
SERVER_ADMIN_USERS | | Comma separated list of Steam user IDs that should be admins
SERVER_BANNED_USERS | | Comma separated list of Steam user IDs that should be banned
SERVER_PERMITTED_USERS | | Comma separated list of Steam user IDs that should be permitted, leaving it empty will allow anyone to connect

## Networking

Ports `2456,2457,2458` on both `TCP` and `UDP` should be exposed.

## Data management

All world data will be stored under `/data`. If you want to persist the state, you should mount a volume on that path.

## Server Administrators

Server administrators can be added via the `SERVER_ADMIN_USERS` environment variable (Have to be comma separated if multiple IDs are used). Alternatively you could also just add a line with the user ID to the `/data/adminlist.txt` file. These users will be able to open the admin console (Pressing F5) once they are logged onto the server. From there they can perform commands such as `Kick/Ban/Unban <PLAYERNAME>` or list banned players via the `Banned` command.

## How to run

If you use docker compose, then you can check the example compose file: [docker-compose.yml](docker-compose.yml)

Or you can just build and run it directly without compose. Some examples:

```sh
# Building from scratch
$ docker build -t valheim .

# Running with port forwarding
$ docker run -it --name valheim \
  --restart always \
  -v $PWD/data:/data \
  -p 2456:2456/tcp \
  -p 2456:2456/udp \
  -p 2457:2457/tcp \
  -p 2457:2457/udp \
  -p 2458:2458/tcp \
  -p 2458:2458/udp \
  valheim

# Running the container using the host network
$ docker run -it --name valheim \
  --restart always \
  -v $PWD/data:/data \
  --network host valheim
```

### TODOS
- Automatic game server updates (Workaround: Re-build/run the container)
- Run the main process without root
