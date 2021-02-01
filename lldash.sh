#!/bin/bash

if [[-z "$source" || -z "$destination"]]; then
    echo "To run ffmpeg Dash you should specify the 'source' & 'destination' "
else
    echo "Start streaming video..."
    echo "source:$source"
    echo "destination:$destination"

    ffmpeg -y -i "$source" -ldash 1 -streaming 1 -use_template 1 -seg_duration 1 -window_size 10 -segment_wrap 15 -vcodec copy -f dash $destination
fi