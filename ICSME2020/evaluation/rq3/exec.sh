#!/bin/bash

timestamp() {
  date +"%T"
}
emulator=$8

##stress
if [ $6 == 1 ]
then
  echo '>1'
  taskset -c -pa 0 $emulator > trash.txt
fi
if [ $6 == 2 ]
then
  echo '>2'
  taskset -c -pa 0,1 $emulator > trash.txt
fi
if [ $6 == 3 ]
then
  echo '>3'
  taskset -c -pa 0,1,2 $emulator > trash.txt
fi
if [ $6 == 4 ]
then
  taskset -c -pa 0,1,2,3 $emulator > trash.txt
fi

if [ $2 ]
then
  stress-ng --cpu $2 --cpu-load $3% --vm $4 --vm-bytes $5% &
  PID=$!
fi

adb shell settings put global transition_animation_scale 1
adb shell settings put global window_animation_scale 1
adb shell settings put global animator_duration_scale 1


base=./outputsTest/$1
echo $base
mkdir -p $base
time_inicio="$(timestamp)"
for i in $(seq $7 $7);
do
  echo 'entrou'
  file=$base/out.$i.txt
  
  echo -n "Running tests now."
# no test for marktony.espresso
done

if [ $PID ]
then
  echo "kill stress"
  kill -9  $PID
fi


echo incio $time_inicio >> $base/time.txt
echo "fim $(timestamp)" >> $base/time.txt
echo "stress [$2, $3, $4, $5, $6]" > $base/stress.txt
sleep 10
