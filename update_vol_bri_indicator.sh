#!/bin/bash
a=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
b=${a:10} 
echo $b | xob & 
