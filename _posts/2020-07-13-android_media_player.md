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

* **OnPreparedListener.onPrepared():** A callback to be invoked when the media source is ready for playback.

* **start():** Starts or resumes playback. If playback had previously been paused, playback will continue from where it was paused. If playback had been stopped, or never started before, playback will start at the beginning.

* **seekTo():** Seeks to specified time position. 

When seekTo is finished, the user will be notified via **OnSeekComplete** supplied by the user. There is at most one active **seekTo()** processed at any time. If there is a to-be-completed **seekTo()**, new **seekTo()** requests will be queued in such a way that only the last request is kept. When current **seekTo()** is completed, the queued request will be processed if that request is different from just-finished **seekTo()** operation, i.e., the requested position or mode is different.

  Different modes of seek:

  -- Use **SEEK_PREVIOUS_SYNC** if one wants to seek to a sync frame that has a timestamp earlier than or the same as msec.
  
  -- Use **SEEK_NEXT_SYNC** if one wants to seek to a sync frame that has a timestamp later than or the same as msec.
  
  -- Use **SEEK_CLOSEST_SYNC** if one wants to seek to a sync frame that has a timestamp closest to or the same as msec.
  
  -- Use **SEEK_CLOSEST** if one wants to seek to a frame that may or may not be a sync frame but is closest to or the same as msec.

**SEEK_CLOSEST** often has larger performance overhead compared to the other options if there is no sync frame located at msec.

* **stop():** Stops playback after playback has been started or paused.

* **pause():** Pauses playback. 

Call **start()** to resume.

* **release():** Releases resources associated with this MediaPlayer object.

It is considered good practice to call this method when you're done using the MediaPlayer. In particular, whenever an Activity of an application is paused, this method should be invoked to release the MediaPlayer object, unless the application has a special need to keep the object around. In addition to unnecessary resources (such as memory and instances of codecs) being held, failure to call this method immediately if a MediaPlayer object is no longer needed may also lead to continuous battery consumption for mobile devices, and playback failure for other applications if no multiple instances of the same codec are supported on a device. Even if multiple instances of the same codec are supported, some performance degradation may be expected when unnecessary multiple instances are used at the same time.

* **reset():** Resets the MediaPlayer to its uninitialized state.

  After calling this method, you will have to initialize it again by setting the data source and calling prepare().
  
* **OnCompleteListener.onCompletion():** A callback to be invoked when the end of a media source has been reached during playback.

* **OnErrorListener.onError():** A callback to be invoked when an error has happened during an asynchronous operation.


**The Life cycle of MediaPlayer object is in between **IDLE** and **END** states.**

### STATES

* **IDLE:** When a MediaPlayer object is just created using **new** or after **reset()** is called, it is in the **IDLE** state. 

* **END:** After **release()** is called, the MediaPlayer object is in the **END** state. Once the MediaPlayer object is in the End state, it can no longer be used and there is no way to bring it back to any other state.

* **ERROR:** Some playback control operation may fail due to various reasons, such as unsupported audio/video format, poorly interleaved audio/video, resolution too high, streaming timeout etc. Error reporting and recovery is an important concern under these circumstances. Sometimes, due to programming errors, invoking a playback control operation in an invalid state may also occur. Under all these error conditions, the internal player engine invokes a user supplied **OnErrorListener.onError()** method.

If any of the MediaPlayer methods are called after newly constructed object, error is not thrown and it remains in same state, but if any of the methods are called after **reset**, the user supplied callback method **OnErrorListener.onError()** will be invoked and object will be transfered to **ERROR** state.

In order to reuse a MediaPlayer object that is in the **ERROR** state and recover from the error, **reset()** can be called to restore the object to its **IDLE** state.

**IllegalStateException** is thrown when a method is called from invalid state.

* **INITIALIZED:** Calling **setDataSource()** transfers a MediaPlayer object in the **IDLE** state to the **INITIALIZED** state.

* **PREPARING:**  Asynchronous call **prepareAync()** transfers MediaPlayer object to **PREPARING** state.

* **PREPARED:** A MediaPlayer object must first enter the **PREPARED** state before playback can be started. Synchronous method **prepare()** transfers MediaPLayer object to **PREPARED** state. After asynchronous method **prepareAsync()** transfer object to **PREPARING** state, on completion **OnPreparedListener.onPrepared()** is returned to notify that MediaPlayer object is prepared and object is tranfered to **PREPARED** state.

While in the **PREPARED** state, properties such as audio/sound volume, screenOnWhilePlaying, looping can be adjusted by invoking the corresponding set methods.

* **STARTED:** To start the playback, **start()** must be called. After **start()** returns successfully, the MediaPlayer object is in the **STARTED** state. **isPlaying()** can be called to test whether the MediaPlayer object is in the **STARTED** state.

Calling **start()** has no effect on a MediaPlayer object that is already in the **STARTED** state.

* **STOPPED:** Calling **stop()** stops playback and causes a MediaPlayer in the **STARTED**, **PAUSED**, **PREPARED** or **PLAYBACKCOMPLETED** state to enter the **STOPPED** state.

Once in the **STOPPED** state, playback cannot be started until **prepare()** or **prepareAsync()** are called to set the MediaPlayer object to the **PREPARED** state again.

Calling **stop()** has no effect on a MediaPlayer object that is already in the **STOPPED** state.

* **PAUSED:** When the call to **pause()** returns, the MediaPlayer object enters the **PAUSED** state. 

Note that the transition from the **STARTED** state to the **PAUSED** state and vice versa happens asynchronously in the player engine. It may take some time before the state is updated in calls to **isPlaying()**, and it can be a number of seconds in the case of streamed content.

Calling **start()** to resume playback for a paused MediaPlayer object, and the resumed playback position is the same as where it was paused. When the call to **start()** returns, the paused MediaPlayer object goes back to the **STARTED** state.

Calling **pause()** has no effect on a MediaPlayer object that is already in the **PAUSED** state.

* **PLAYBACKCOMPLETED:** When the playback reaches the end of stream, the playback completes. 

If the looping mode was being set to **true** with **setLooping(boolean)**, the MediaPlayer object shall remain in the **STARTED** state.

If the looping mode was set to **false** , the player engine calls a user supplied callback method, **OnCompletion.onCompletion()**  that the object is now in the **PLAYBACKCOMPLETED** state.

Calling **start()** can restart the playback from the beginning of the audio/video source.

* The playback position can be adjusted with a call to **seekTo()**. hen the actual seek operation completes, the internal player engine calls a user supplied **OnSeekComplete.onSeekComplete()**. **seekTo(long, int)** can be called in **PREPARED**, **STARTED**, **PAUSED** and **PLAYBACKCOMPLETED** states.

The actual current playback position can be retrieved with a call to **getCurrentPosition()**, which is helpful for applications such as a Music player that need to keep track of the playback progress.

### REFERENCES
* <https://developer.android.com/reference/android/media/MediaPlayer>
