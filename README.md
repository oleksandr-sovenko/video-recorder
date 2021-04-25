# video-recorder
The special script for recording video from IP cameras through FFMPEG.

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
