# Build image
# docker build --no-cache -t lldash .

# To run the contianer
#   docker container run --rm -it -v "$(pwd)":/src/app -e "source=./video.mp4" -e "destination=./stream/stream.mpd" --name stream-dash lldash

FROM alpine

RUN apk add --no-cache ffmpeg


WORKDIR /src/app
VOLUME /src/app

ADD lldash.sh /src/setting/lldash.sh
RUN chmod +x /src/setting/lldash.sh

# Comment this line to use the image as CLI
ENTRYPOINT ["sh", "/src/setting/lldash.sh"]