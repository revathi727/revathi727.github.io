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

#### TYPES OF VIDEO COMPRESSION



#### FRAME TYPES OR PICTURE TYPES

In the field of video compression a video frame is compressed(encoded) using different algorithms with different advantages and disadvantages, centered mainly around amount of data compression. 

These different algorithms for video frames are called picture types or frame types.

There are three major picture types or frame types used in the different video algorithms.

* **I-FRAME (Intra-coded picture) or Key frame**:
  * These frames don't require other frames to decode. It is a complete image like JPG or BMP image file.
  * These are least compressible.
  * Only spatial compression is possible.
  * These are expensive and utilize more of the allocated bit-rate.
  * Starting frame of any video is always an I-frame.

* **P-FRAME (Predicted picture)**:
  * These frames use data from previous frames to decompress.
  * These are more compressible than I-frames.
  * Spatial/temporal compression is possible.

* **B-FRAME (Bidirectional predicted picture)**:
  * These frames can use both previous and future frames for data reference.
  * These are the highest compressible frames.
  * Spatial/temporal compression is possible.
  * It requires frames reordering as it requires future frames reference.

