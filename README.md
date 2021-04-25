# video-recorder
The special script for recording video from IP cameras through FFMPEG.

## Cron tasks
@reboot ./capture.sh cam1 admin password 192.168.0.100:554
@reboot ./capture.sh cam2 admin password 192.168.0.101:554
....
@reboot ./capture.sh camN admin password 192.168.0.N:554
