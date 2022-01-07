#!/bin/bash

H=$(pactl list sinks short | grep -Pwo "alsa_output.*Schiit+\S*")
echo hf:$H
pactl set-default-sink $H
