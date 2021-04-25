# capture.sh
# Copyright (c) 2021 Oleksandr Sovenko (info@oleksandrsovenko.com)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

NAME=$1
USER=$2
PASSWORD=$3
CAMERA=$4

ROOTDIR=`dirname $0`

if [ "${CAMERA}" == "" ]; then
	echo "~E~ Please use the command as follows (RTSP credentials)."
	echo "  ${0} name username password ip:port"
	exit;
fi

if [ "`which ffmpeg`" == "" ]; then
	echo "~E~ Please install 'ffmpeg'."
	exit;
fi

cd "${ROOTDIR}" 2> /dev/null

if [ "$?" != "0" ]; then
	echo "~E~ Something went wrong! Looks like directory not exists or maybe path has specific symbols '${ROOTDIR}/video'."
	exit;	
fi

if [ ! -d "./video" ]; then
	mkdir ./video

	if [ "$?" != "0" ]; then
		echo "~E~ Impossible to create directory '${ROOTDIR}/video'."
		exit;	
	fi
fi

while true
do
	/usr/bin/ffmpeg \
		-rtsp_transport tcp \
		-i rtsp://${USER}:${PASSWORD}@${CAMERA} \
		-f segment \
		-strftime 1 \
		-segment_time 00:10:00 \
		-segment_atclocktime 1 \
		-segment_clocktime_offset 30 \
		-segment_format mp4 -an -vcodec copy \
		-reset_timestamps 1 ./video/${NAME}-%Y%m%d-%H%M%S.mp4
	sleep 5
done
