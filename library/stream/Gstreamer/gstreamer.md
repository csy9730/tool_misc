# gstreamer


```
gst-play-1.0 rtsp://localhost:554/mystream
```

## bin
```
gst-device-monitor-1
gst-discoverer-1.0
gst-launch-1.0
gst-inspect-1.0
gst-stats-1.0
gst-typefind-1.0
```

## help
```

[root@M1808 ~]# gst-play-1.0 --help
librga:RGA_GET_VERSION:4.00,4.000000
ctx=0x185b3a20,ctx->rgaFd=3
Rga built version:version:+2017-09-28 10:12:42
Usage:
  gst-play-1.0 [OPTION…] FILE1|URI1 [FILE2|URI2] [FILE3|URI3] ...

Help Options:
  -h, --help                        Show help options
  --help-all                        Show all help options
  --help-gst                        Show GStreamer Options

Application Options:
  -v, --verbose                     Output status information and property notifications
  --flags                           Control playback behaviour setting playbin 'flags' property
  --version                         Print version information and exit
  --videosink                       Video sink to use (default is autovideosink)
  --audiosink                       Audio sink to use (default is autoaudiosink)
  --gapless                         Enable gapless playback
  --shuffle                         Shuffle playlist
  --no-interactive                  Disable interactive control via the keyboard
  --volume                          Volume
  --playlist                        Playlist file containing input media files
  -q, --quiet                       Do not print any output (apart from errors)
  --use-playbin3                    Use playbin3 pipeline(default varies depending on 'USE_PLAYBIN' env variable)
```
