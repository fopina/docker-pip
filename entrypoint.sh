#!/bin/bash

if [ "$(sysctl -n kernel.msgmnb)" != "65536000" ]; then
	# why doesn't sysctl use proper exit codes when it fails to update values...
	sysctl kernel.msgmnb=65536000 kernel.msgmni=512 kernel.msgmax=1048700 2>&1 | grep -q "Read-only"
	if [ "$?" == "0" ]; then
		cat <<EOF > /dev/stderr
Failed to correct sysctl values!

Please run this image with --privileged:
	docker run --privileged -p 61315:61315 fopina/fis-pip

Or, if you prefer, you can drop the privileged and set the required sysctl parameters:
	docker run --sysctl "kernel.msgmnb=65536000" --sysctl "kernel.msgmni=512" --sysctl "kernel.msgmax=1048700" -p 61315:61315 fopina/fis-pip


Check https://github.com/fopina/docker-pip for more information (or to report issues).
EOF
		exit 1
	fi
fi

set -e

su pip /home/pip/pip_V02/pipstart

# let this docker run!
tail -f /dev/null

su pip /home/pip/pip_V02/pipstop