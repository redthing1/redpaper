---
title: Block Sorting Compressor
author: Red Thing
geometry: margin=0.5in
---

# Overview

Let's talk about the *m03* variant of Ilya Grebnov's **bsc** (block sorting compressor). This is a lossless compression algorithm designed for maximal compression ratios. It currently ranks **#23** on the [Large Text Compression Benchmark](http://mattmahoney.net/dc/text.html), as of November 1, 2023.

The underlying theory behind this algorithm comes from the [Burrows-Wheeler Transform](https://en.wikipedia.org/wiki/Burrows%E2%80%93Wheeler_transform) and is described in more detail in the paper [Block Sorting Text Compression](https://www.cs.auckland.ac.nz/~peter-f/FTPfiles/ACSC96paper.pdf).

Unlike most general purpose lossless compressors, **bsc** achieves extremely good compression ratios at the expense of being very slow.

# Project Information

`libbsc` (**249** stars):

+ original source: https://github.com/IlyaGrebnov/libbsc
+ my fork: https://github.com/redthing1/libbsc

# Building and Running the Workload

## Summary

+ First, ensure the `meson` and `ninja` build tools are installed. On Debian, these can be installed from the packages `meson` and `ninja-build`.
+ The sample script uses the input data `data/spec06/401.bzip2/input.combined` from the SPEC tests, so ensure the SPEC test data is available in the `build/run` work folder.
+ Clone the repository of **my fork** as noted above.
+ Follow the instructions in the README (or see below) to cross-compile using `riscv64-linux-gnu`.
+ Run the `test_bsc.sh` script (described below).

## Example

The full procedure to build is described here:
```sh
git clone https://github.com/redthing1/libbsc
cd libbsc
meson setup --cross-file cross/riscv64-linux-gnu.txt build-riscv
ninja -C build-riscv
```

This should output `build-riscv/bsc-m03_linux_riscv64`, a statically linked RISCV64 binary.
