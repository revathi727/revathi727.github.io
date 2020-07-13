---
layout: post
title: "Android Architecture"
date: 2020-07-10 22:30
category: 
author: Revathi Polisetty
tags: [Android]
description: Android platform architecture or android software stack. 
image: android_architecture.jpg
---

## Android Platform Architecture or Android Software Stack

Android is an open source, Linux-based software stack created for a wide array of devices and form factors.
Although Android has developed many OS versions, the android platform architecture or software stack remains unchanged.

![]({{site.baseurl}}/img/android_stack.png)

The major components of Android Platform are:

* **LINUX KERNEL:**

  The foundation of the Android platform is the Linux kernel. Android core system relies on linux kernel for underlying functionalities such as threading, memory management, security, process management, network protocol stack and driver model. THe linux kernel also serves as abstraction layer for hardware and software stacks. Drivers uch as Display driver, Camera driver, Keypad driver, WiFi driver, Audio driver, USB driver, Binder(IPC) driver, Bluetooth driver etc., interact with hardware directly.

* **HARDWARE ABSTRACTION LAYER(HAL):**

  The HAL provides standard interfaces that expose device hardware capabilities to the higher-level Java API framework. The HAL consists of multiple library modules, each of which implements an interface for a specific type of hardware component, such as the camera or bluetooth module. When a framework API makes a call to access device hardware, the Android system loads the library module for that hardware component.

* **ANDROID RUNTIME(ART):**

  Each app runs in its own process and with its own instance of the Android Runtime (ART). ART is written to run multiple virtual machines on low-memory devices by executing DEX(Dalvik executable) files, a bytecode format designed specially for Android that's optimized for minimal memory footprint.

  The Android runtime includes the core library and the Dalvik virtual machine. The core libraries are not only compatible with the function functions that 
most Java languages need to call, but also includes the core libraries of Android, such as android.os, android.net, android.media, and so on.
DVM is a register-based Java virtual machine. Dalvik virtual machine mainly completes important functions such as life cycle management, 
stack management, thread management, security and exception management, and garbage collection.

Major features of ART are:
  * Ahead-of-time (AOT) and just-in-time (JIT) compilation.
  * Optimized garbage collection (GC).
  * Conversion of an app package's Dalvik Executable format (DEX) files to more compact machine code.
  * Better debugging support, including a dedicated sampling profiler, detailed diagnostic exceptions and crash reporting, and the ability to set watchpoints to monitor specific fields.

* **NATIVE C/C++ LIBRARIES:**

  Many core Android system components and services, such as ART and HAL, are built from native code that require native libraries written in C and C++. Native code is many times faster than Java when used in interpreted mode. Java Native Interface(JNI) is the framework that allows Java code to interact with other languages. Use of native libraries improves code resuability and performace.

Here are some core native libraries:
  * **Core C/C++:**
    * C libraries such as stdlib, stdio, libc, dlfcn(dynamic linker functionality), libm(math functions) etc.
    * C++ libraries with support of C++17.
    * Logging(liblog).
    * Tracing(libandroid) allows to trace named units of work in your code by writing trace events to the system trace buffer.
    * zlib compression(libz).
  * **Graphics:**
    2D, 3D libraries based on OpenGL ES, Bitmaps etc.
  * **Camera:**
    Java camera APIs doesn't support HAL imprementations of external camera devices. The native camera APIs perform fine-grained photo capture and processing.
  * **Media:**
    Native media libraries provides low-level interfaces similar to MediaCodec, MediaExtractor and many more.
  * **Audio:**
    Native auido libraries provide better support for high-performance audio apps that require low-latency audio.
  * **Neural Networks API:**
    NNAPI provides apps with hardware acceleration for on-device machine learning operations.

* **JAVA API FRAMEWORK:**

  The entire feature-set of the Android OS is available through APIs written in the Java language. Developers have full access to the same framework APIs that Android system apps use. These APIs form the building blocks to create Android apps by simplifying the reuse of core, modular system components and services, which include the following:
  * **View System:** It is used to build an app’s UI, including lists, grids, text boxes, buttons, and even an embeddable web browser.
  * **Resource Manager:** It provides access to non-code resources such as localized strings, graphics, and layout files.
  * **Notification Manager:** It enables all apps to display custom alerts in the status bar.
  * **Activity Manager:** It manages the lifecycle of apps and provides a common navigation back stack.
  * **Content Providers:** They enable apps to access data from other apps, such as the Contacts app, or to share their own data
    
* **SYSTEM APPS:**

  Android comes with a set of core apps for email, SMS messaging, calendars, internet browsing, contacts, and more. Developers can also make apps and set them as default(except Settings).

### REFERENCES
* [1] <https://developer.android.com/guide/platform>
