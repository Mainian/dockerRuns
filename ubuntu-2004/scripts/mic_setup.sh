#!/bin/bash

# enable loop back
# pactl load-module module-loopback latency_msec=1

# unload loopback module
# pactl unload-module module-loopback

# if focus mapped as output -> change to input
#MOutput=$(pactl list sinks short | grep -Pwo "alsa_output.*Focus+\S*")

#M=$(pactl list sources | grep -P "name:.*alsa.*Focus" | tail -n 1 | perl -pe 's/.*<//g;s/>.*//g')

srcCardConf=$(pacmd list-sources | grep -P "name:.*alsa.*Focus.*output" | tail -n 1 | perl -pe 's/.*<//g;s/>.*//g')
if [ ! -z "$srcCardConf" ]; then
	echo changing card profile to input
	srcCard=$(pacmd list-cards | grep -P "name:.*alsa.*Focus" | tail -n 1 | perl -pe 's/.*<//g;s/>.*//g')
	pacmd set-card-profile $srcCard input:multichannel-input
else
	echo card profile is correct
fi

srcExists=$(pacmd list-sources | grep record_mono)
if [ -z "$srcExists" ]; then
	# map microphone
	echo map microphone
	M=$(pacmd list-sources | grep -P "name:.*alsa.*Focus" | tail -n 1 | perl -pe 's/.*<//g;s/>.*//g')
	echo $M
	#pacmd load-module module-remap-source source_name=mono master=$M master_channel_map=front-left  channel_map=mono
	pactl load-module module-remap-source source_name=record_mono master=$M master_channel_map=front-left channel_map=mono
	pactl set-default-source record_mono
else
	echo mic exists
fi
