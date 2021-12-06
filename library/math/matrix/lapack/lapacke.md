# lapacke

[http://www.netlib.org/lapack/lapacke.html](http://www.netlib.org/lapack/lapacke.html)

## homepage

### Introduction

This document describes a two-level C interface to LAPACK, consisting of a high-level interface and a middle-level interface. The high-level interface handles all workspace memory allocation internally, while the middle-level interface requires the user to provide workspace arrays as in the original FORTRAN interface. Both interfaces provide support for both column-major and row-major matrices. The prototypes for both interfaces, associated macros and type definitions are contained in the header file lapacke.h.

