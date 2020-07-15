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

### OPERATIONS

* **new:** Creates a new MediaPlayer object.
  
* **setDataSource():** Sets the data source (local FileDescriptor/ Streaming(HTTP/HLS/RTSP/...) source).

* **prepare():** Prepares the player for playback, synchronously. 

  Prepare process generally includes finding mime types, creating extractor and decoders.

* **prepareAsync():** Prepares the player for playback, asynchronously.

After setting the datasource and the display surface, you need to either call **prepare()** or **prepareAsync()**. For files, it is OK to call **prepare()**, which blocks until MediaPlayer is ready for playback. For streams, you should call **prepareAsync()**, which returns immediately, rather than blocking until enough data has been buffered.

* **OnPreparedListener.onPrepared():** 

* **start():** Starts or resumes playback. If playback had previously been paused, playback will continue from where it was paused. If playback had been stopped, or never started before, playback will start at the beginning.

* **seekTo():** Seeks to specified time position. 

When seekTo is finished, the user will be notified via **OnSeekComplete** supplied by the user. There is at most one active **seekTo()** processed at any time. If there is a to-be-completed **seekTo()**, new **seekTo()** requests will be queued in such a way that only the last request is kept. When current **seekTo()** is completed, the queued request will be processed if that request is different from just-finished **seekTo()** operation, i.e., the requested position or mode is different.

Different modes of seek:
  * Use **SEEK_PREVIOUS_SYNC** if one wants to seek to a sync frame that has a timestamp earlier than or the same as msec. 
  * Use **SEEK_NEXT_SYNC** if one wants to seek to a sync frame that has a timestamp later than or the same as msec. 
  * Use **SEEK_CLOSEST_SYNC** if one wants to seek to a sync frame that has a timestamp closest to or the same as msec. 
  * Use **SEEK_CLOSEST** if one wants to seek to a frame that may or may not be a sync frame but is closest to or the same as msec.

**SEEK_CLOSEST** often has larger performance overhead compared to the other options if there is no sync frame located at msec.

* **stop():** Stops playback after playback has been started or paused.

* **pause():** Pauses playback. 

Call **start()** to resume.

* **release():** Releases resources associated with this MediaPlayer object.



* **reset():** Resets the MediaPlayer to its uninitialized state.

  After calling this method, you will have to initialize it again by setting the data source and calling prepare().
  
* **OnCompleteListener on onCompletion():**
* **OnErrorListener.onError():**

When a MediaPlayer object is just created using new or after reset() is called, it is in the Idle state; and after release() is called, it is in the End state. Between these two states is the life cycle of the MediaPlayer object.

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

### REFERENCES
* <https://developer.android.com/reference/android/media/MediaPlayer>
