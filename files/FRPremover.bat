adb devices
adb root
adb remount
adb shell dd if=/dev/zero of=/dev/block/persistent bs=1 count=1024
adb shell pm disable com.sec.android.app.SecSetupWizard
adb shell pm disable com.google.android.setupwizard
pause