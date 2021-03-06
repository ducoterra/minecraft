FROM openjdk:8-slim

RUN apt update && apt install -y rsync

WORKDIR /mc_server
COPY ./server .

RUN groupadd -r minecraft && useradd --no-log-init -r -g minecraft minecraft
WORKDIR /mc_data
RUN chown -R minecraft:minecraft .

USER minecraft
# Copy files only if they don't yet exist (server.jar, server.properties, etc) and start the server
CMD cp -r /mc_server/. . && \
java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads="$THREADS" -XX:+AggressiveOpts -Xmx"$MAX_RAM"G -Xms"$MIN_RAM"G -jar server.jar nogui