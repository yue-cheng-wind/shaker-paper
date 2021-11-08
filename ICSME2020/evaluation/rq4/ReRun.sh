#!/bin/bash

#emulator=4330

adb shell settings put global transition_animation_scale 0
adb shell settings put global window_animation_scale 0
adb shell settings put global animator_duration_scale 0


base=./outputs/normal
for i in $(seq $1);
do
  pat=$base/$i
  mkdir -p $pat
  echo $pat
  file=$pat/out.1.txt
  
  SECONDS=0
  echo -n "Running tests now."
  # no test for marktony.espresso
  echo "."
  echo "Finished."
  echo $SECONDS >> $pat/time.txt
done

sleep 10
