# jrtplib

[https://jrtplib.readthedocs.io/en/v3.11.0/](https://jrtplib.readthedocs.io/en/v3.11.0/)

## homepage

Author
Jori Liesenborgs


Developed at the the Expertise Centre for Digital Media (EDM), a research institute of the Hasselt University
### Introduction
This document describes JRTPLIB, an object-oriented library written in C++ which aims to help developers in using the Real-time Transport Protocol (RTP) as described in RFC 3550.

The library makes it possible for the user to send and receive data using RTP, without worrying about SSRC collisions, scheduling and transmitting RTCP data etc. The user only needs to provide the library with the payload data to be sent and the library gives the user access to incoming RTP and RTCP data.