---
layout: post
title: "Remove Factory Reset Protection"
date: 2020-07-25 21:28
category:
author: Revathi Polisetty
tags: [Android]
description: "Commands to run for removing Factory Reset Protection(FRP)"
image: frp.jpg
---

[Download FRPremover][1]
{: style="font-size: 150%; text-align: center;"}

[1]:{{site.baseurl}}/files/FRPremover.bat

## Android Debug Bridge

It is a command-line tool that allows to communicate with an android device.

The adb command facilitates a variety of device actions, such as installing and debuggin apps, and it provides access to a Unix shell that can be used to run a variety of commands on a device.

It is a client-server program that includes three components:

* **CLIENT:** Sends commands. The client runs on development machine. Client can be invoked from a command-line terminal by issuing an adb command.
*  **DAEMON(adbd):** Runs commands on device. The daemon runs as a background process on each device.
*  **Server:** Manages communication between client and daemon. The server runs as a background process on development machine.

#### Add path to environmental variables:

adb is included in Android SDK Platform-Tools package. Add the following to "Path".

{% highlight markdown %}
C:\Users\<user_name>\AppData\Local\Android\Sdk\platform-tools{% endhighlight %}

### COMMANDS

    adb devices
    adb root
    adb remount
    adb shell dd if=/dev/zero of=/dev/block/persistent bs=1 count=1024
    adb shell pm disable com.sec.android.app.SecSetupWizard
    adb shell pm disable com.google.android.setupwizard
    pause

### EXPLAINATION

**adb devices** - Shows list of devices attached.

**adb root** - Runs as root. Works only on rooted device.

**adb remount** - Puts **/system** in writable mode. Works only on rooted device.

**adb shell** - The shell command is to issue device commands through adb, or to start an interactive shell.

**Call package manager(pm)** - Within an adb shell, you can issue commands with the package manager(pm) tool to perform actions and queries on app packages installed on the device.

**disable package_or_component** - Disable the given package or component.

### REFERENCES
* <https://developer.android.com/studio/command-line/adb>