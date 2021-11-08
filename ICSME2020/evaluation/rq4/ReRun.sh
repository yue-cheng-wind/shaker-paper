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

  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#removeBookmarkFromBookmarkList_bookmarkIsRemoved -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingHistoryTest#browsingTwoWebSites_sitesAreDisplayedInOrderInHistoryPanel -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SwitchSearchEngineTest#switchSearchEngine_searchViaSearchEngineAccordingly -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SaveRestoreTabsTest#restoreEmptyTab_addNewTabThenRelaunch -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingIntentTest#appHasOneTabAndReceiveBrowsingIntent_tabIncreasedAndBrowse -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RateAppPromotionTest#showRateAppPromotionAndClickFeedback_openFeedbackUrl -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  
  echo "."
  echo "Finished."
  echo $SECONDS >> $pat/time.txt
done

sleep 10
