#!/bin/bash

base=./outputs/normal/$1
echo $base
mkdir -p $base

  SECONDS=0
  file=$base/out.1.txt


  adb shell settings put global transition_animation_scale 0
  adb shell settings put global window_animation_scale 0
  adb shell settings put global animator_duration_scale 0

  echo -n "Running tests now."
  
  adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.MainActivityTest#testSearchResultAppears -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  echo "Finished."

  echo $SECONDS >> $base/time.txt

if [ $PID ]
then
  echo "kill stress"
  kill -9  $PID
fi
