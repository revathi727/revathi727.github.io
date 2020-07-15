---
layout: post
title: "Android MediaPlayer"
date: 2020-07-13 19:30
category: 
author: Revathi Polisetty
tags: [Android]
description: Life cycle of Android MediaPlayer State Diagram
image: mediaplayer.jpg
---

## Android MediaPlayer

MediaPlayer class can be used to control playback of audio/video files and streams. MediaPlayer is not thread-safe. Creation of and all access to player instances should be on the same thread. If registering callbacks, the thread must have a Looper.

### STATE DIAGRAM

Playback control of audio/video files and streams is managed as a state machine. The following diagram shows the life cycle and the states of a MediaPlayer object driven by the supported playback control operations.

{% highlight markdown %}
Ovals -> State of MediaPlayer Object
Double Oval -> End state of MediaPlayer Object
Arcs -> Playback control operations that drive the object state transition in the direction of arrow
    Single arrow -> Synchronous method call
    Double arrow -> Asynchronous method call{% endhighlight %}

![]({{site.baseurl}}/img/mediaplayer_state_diagram.gif)

### STATES

* **IDLE:**
* **INITIALIZED:**
* **PREPARING:**
* **PREPARED:**
* **STARTED:**
* **STOPPED:**
* **PAUSED:**
* **PLAYBACKCOMPLETED:**
* **END:**
* **ERROR**

### OPERATIONS

* **new**
* **reset()**
* **setDataSource()**
* **prepare()**
* **prepareAsync()**
* **OnPreparedListener.onPrepared()**
* **start()**
* **seekTo()**
* **stop()**
* **pause()**
* **release()**
* **OnCompleteListener on onCompletion()**
* **OnErrorListener.onError()**

When a MediaPlayer object is just created using new or after reset() is called, it is in the Idle state; and after release() is called, it is in the End state. Between these two states is the life cycle of the MediaPlayer object.

### REFERENCES
* <https://developer.android.com/reference/android/media/MediaPlayer>
