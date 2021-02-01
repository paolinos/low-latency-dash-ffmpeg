## Streaming Low Latency
Following the article 'Low-latency dash streaming using open-source tools' (https://bozhang-26963.medium.com/low-latency-dash-streaming-using-open-source-tools-f93142ece69d)
we started to make some test and create a Docker to stream passing only the input video (source) and output (destination).

We used Low Latency Dash but you can change for low latency Hls.(https://ffmpeg.org/ffmpeg-formats.html#dash-2)


### Build docker image
```
docker build --no-cache -t lldash .
```

### Start to stream
So my current folder structure is:
- current_folder
    - Dockerfile (file)
    - lldash.sh (file)
    - videos (Directory)
    - streams (Directory)

So we can run this:
```
docker container run --rm -it -v "$(pwd)":/src/app -e "source=./videos/video.mp4" -e "destination=./streams/stream.mpd" --name stream-dash lldash
```
To undestand more about "docker continer run" (remember you always have `docker container run --help`)

- --rm
    Remove automatically the container when it exist. for that reason then we specify the --name 

- -it
    -i, --interactive                    Keep STDIN open even if not attached
    -t, --tty                            Allocate a pseudo-TTY

- -v "$(pwd)":/src/app
    -v, --volume list                    Bind mount a volume
    So we'll mount the directory that we want to use. $(pwd) -> for linux to tell current directory. For CMD or Powershell remember that are %cd% and $PWD respectively.

- -e "source=./videos/video.mp4" & -e "destination=./streams/stream.mpd"
    -e, --env list                       Set environment variables
    So we set the 'source' & 'destination' variable that will be used in the 'lldash.sh' file.

- --name 
    --name string                    Assign a name to the container
    The name is very useful because we can identify each container. if we don't specify the name we'll have a random name.

### Low Latency Dash
We use the following parameters to stream:

- ldash ldash
    Enable Low-latency Dash by constraining the presence and values of some elements.

- streaming streaming
    Enable (1) or disable (0) chunk streaming mode of output. In chunk streaming mode, each frame will be a moof fragment which forms a chunk.

- use_template template
    Enable (1) or disable (0) use of SegmentTemplate instead of SegmentList. 

- seg_duration duration
    Set the segment length in seconds (fractional value can be set). The value is treated as average segment duration when use_template is enabled and 

- window_size size
    Set the maximum number of segments kept in the manifest. 

- segment_wrap limit
    Wrap around segment index once it reaches limit.

- -vcodec copy
    Copy the same codec

- -f dash
    Dash format
