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

base=./outputs/$1
echo $base
mkdir -p $base
time_inicio="$(timestamp)"


for i in $(seq 1 $7);
do
  file=$base/out.$i.txt
 
  echo -n "Running tests now."

  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithChangingContent_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchFieldTest#typeTextInSearchFieldAndClear_textIsClearedAndBackToHome -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithVariousWords_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.ShareWithFriendTest#shareWithFriends -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.NavigationTest#browsingWebsiteBackAndForward_backAndFrowardToWebsite -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchSuggestionTest#clickSearchSuggestion_browseByDefaultSearchEngine -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RemoveTopSitesTest#deleteTopSite_deleteSuccessfully -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#addBookmarkAndEdit_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithClearingLocationContent_saveButtonIsDisabled -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file

  echo "."
  echo "Finished."
done

if [ $PID ]
then
  echo "kill stress"
  kill -9  $PID
fi


echo "start" $time_inicio >> $base/time.txt
echo "end $(timestamp)" >> $base/time.txt
echo "stress [$2, $3, $4, $5, $6]" > $base/stress.txt
sleep 7
