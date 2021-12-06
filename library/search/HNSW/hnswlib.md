# hnswlib

[https://github.com/nmslib/hnswlib](https://github.com/nmslib/hnswlib)

## homepage

# Hnswlib - fast approximate nearest neighbor search

Header-only C++ HNSW implementation with python bindings.

**NEWS:**

- **Hnswlib is now 0.5.2**. Bugfixes - thanks [@marekhanus](https://github.com/marekhanus) for fixing the missing arguments, adding support for python 3.8, 3.9 in Travis, improving python wrapper and fixing typos/code style; [@apoorv-sharma](https://github.com/apoorv-sharma) for fixing the bug int the insertion/deletion logic; [@shengjun1985](https://github.com/shengjun1985) for simplifying the memory reallocation logic; [@TakaakiFuruse](https://github.com/TakaakiFuruse) for improved description of `add_items`; [@psobot ](https://github.com/psobot)for improving error handling; [@ShuAiii](https://github.com/ShuAiii) for reporting the bug in the python interface
- **Hnswlib is now 0.5.0**. Added support for pickling indices, support for PEP-517 and PEP-518 building, small speedups, bug and documentation fixes. Many thanks to [@dbespalov](https://github.com/dbespalov), [@dyashuni](https://github.com/dyashuni), [@groodt](https://github.com/groodt),[@uestc-lfs](https://github.com/uestc-lfs), [@vinnitu](https://github.com/vinnitu), [@fabiencastan](https://github.com/fabiencastan), [@JinHai-CN](https://github.com/JinHai-CN), [@js1010](https://github.com/js1010)!
- **Thanks to Apoorv Sharma @apoorv-sharma, hnswlib now supports true element updates (the interface remained the same, but when you the performance/memory should not degrade as you update the element embeddings).**
- **Thanks to Dmitry @2ooom, hnswlib got a boost in performance for vector dimensions that are not multiple of 4**
- **Thanks to Louis Abraham (@louisabraham) hnswlib can now be installed via pip!**

Highlights:

1. Lightweight, header-only, no dependencies other than C++ 11.
2. Interfaces for C++, python and R (<https://github.com/jlmelville/rcpphnsw>).
3. Has full support for incremental index construction. Has support for element deletions (currently, without actual freeing of the memory).
4. Can work with custom user defined distances (C++).
5. Significantly less memory footprint and faster build time compared to current nmslib's implementation.

Description of the algorithm parameters can be found in [ALGO_PARAMS.md](https://github.com/nmslib/hnswlib/blob/master/ALGO_PARAMS.md).