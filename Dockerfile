FROM steamcmd/steamcmd:latest

ENV SERVER_NAME="My Valheim Server" \
    SERVER_PASSWORD="youshouldchangethis" \
    SERVER_WORLD="Dedicated" \
    SERVER_ADMIN_USERS="" \
    SERVER_BANNED_USERS="" \
    SERVER_PERMITTED_USERS=""

EXPOSE 2456/tcp 2456/udp \
       2457/tcp 2457/udp \
       2458/tcp 2458/udp

WORKDIR /apps

VOLUME /data

RUN steamcmd +login anonymous +force_install_dir $PWD +app_update 896660 -validate +quit

COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
