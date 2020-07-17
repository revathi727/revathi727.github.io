---
layout: post
title: "Video Compression and Frame Types"
date: 2020-07-16 19:30
category: 
author: Revathi Polisetty
tags: [Video]
description: Explains video compression, uses and an overview on how it is done. 
image: videocompression.jpg
---

## Video Compression and Frame Types

A picture can be either a frame or a field. A frame is a complete image. A field is the set of odd-numbered or even-numbered scan lines composing a partial image.

When video is sent in **interlaced-scan** format, each frame is sent in two fields, the field of odd-numbered lines followed by the field of even-numbered lines.

#### TYPES OF VIDEO COMPRESSION

Based on loss of data:

* **LOSSLESS COMPRESSION:** Lossless compression reduces bits by identifying and eliminating statistical redundancy. No information is lost in lossless compression.

  For example, an image may have areas of color that do not change over several pixels; instead of coding "red pixel, red pixel, ..." the data may be encoded as "279 red pixels".

* **LOSSY COMPRESSION:** Lossy compression reduces bits by removing unnecessary or less important information.

  As all lossy compression, there is a trade-off between video quality and bit rate, cost of processing the compression and decompression, and system requirements.

Based on frames:

* **SPATIAL COMPRESSION or INTRA-FRAME COMPRESSION:** Size of a frame is reduced by different storage mechanism or reducing quality.

* **TEMPORAL COMPRESSION or INTER-FRAME COMPRESSION:** Only changes from previous/future frames are stored.

{% highlight markdown %}
A device that performs data compression is referred to as an encoder, and one that performs the reversal of the process (decompression) as a decoder.{% endhighlight %}

#### FRAME TYPES OR PICTURE TYPES

In the field of video compression a video frame is compressed(encoded) using different algorithms with different advantages and disadvantages, centered mainly around amount of data compression. 

These different algorithms for video frames are called picture types or frame types.

A frame used as a reference for predicting other frames is called a **reference frame**.

There are three major picture types or frame types used in the different video algorithms.

* **I-FRAME (Intra-coded picture) or Key frame**:
  * These frames don't require other frames to decode. It is a complete image like JPG or BMP image file.
  * These are least compressible.
  * Only spatial compression is possible.
  * These are expensive and utilize more of the allocated bit-rate.
  * Starting frame of any video is always an I-frame.
  * No reference frames.

* **P-FRAME (Predicted picture)**:
  * These frames use data from previous frames to decompress.
  * These are more compressible than I-frames.
  * Spatial/temporal compression is possible.
  * One reference frame.

* **B-FRAME (Bidirectional predicted picture)**:
  * These frames can use both previous and future frames for data reference.
  * These are the highest compressible frames.
  * Spatial/temporal compression is possible.
  * It requires frames reordering as it requires future frames reference.
  * Two reference frames.
  
#### Extract images from video using FFMPEG

    * ffmpeg -i input.mp4 -filter_complex "setpts=N/TB,select='1*eq(pict_type,PICT_TYPE_I)+2*eq(pict_type,PICT_TYPE_P)+3*eq(pict_type,PICT_TYPE_B)':n=3[i][p][b]" -vsync 0 -map "[i]" -r 1 -frame_pts 1 iframe_%04d.png -map "[p]" -r 1 -frame_pts 1 pframe_%04d.png -map "[b]" -r 1 -frame_pts 1 bframe_%04d.png **

### MARCROBLOCKS:

Typically, pictures (frames) are segmented into macroblocks, and individual prediction types can be selected on a macroblock basis rather than being the same for the entire picture, as follows:

* I-frames can contain only intra macroblocks
* P-frames can contain either intra macroblocks or predicted macroblocks
* B-frames can contain intra, predicted, or bi-predicted macroblocks

## REFERENCES

* <https://en.wikipedia.org/wiki/Video_compression_picture_types>

* <https://superuser.com/questions/1480729/ffmpeg-save-images-with-frame-type>
