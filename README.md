# Video Recorder
The special script for recording video from IP cameras through FFMPEG.

## Install
In this example, I am using directory /opt, but this can be any other directory. Before using directory /opt, make sure that the user under whom FFMPEG will be working has sufficient permissions to write to the dorectory /opt

```bash
  git clone https://github.com/oleksandr-sovenko/video-recorder /opt/video-recorder
```

## Cron tasks
Let's say the script capture.sh is in /opt/video-recorder, then Cron will look like this

```bash
  # Capture video from IP cameras
  @reboot /opt/video-recorder/capture.sh cam1 admin password 192.168.0.100:554
  @reboot /opt/video-recorder/capture.sh cam2 admin password 192.168.0.101:554
  ....
  @reboot /opt/video-recorder/capture.sh camN admin password 192.168.0.N:554
  
  # Remove old files (older than 7 days)
  */10 * * * * find /opt/video-recorder/video -mindepth 1 -mtime +7 -delete
```
