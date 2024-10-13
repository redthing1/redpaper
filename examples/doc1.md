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

# Math Examples

## Probability

1. Probability of at least one success in n independent trials:

   $P(\text{at least one success}) = 1 - (1-p)^n$

2. Binomial probability distribution:

   $P(X = k) = \binom{n}{k} p^k (1-p)^{n-k}$

3. Expected value of a discrete random variable:

   $E[X] = \sum_{i=1}^{n} x_i \cdot P(X = x_i)$

4. Variance of a discrete random variable:

   $\text{Var}(X) = E[(X - \mu)^2] = \sum_{i=1}^{n} (x_i - \mu)^2 \cdot P(X = x_i)$

5. Bayes' Theorem:

   $P(A|B) = \frac{P(B|A) \cdot P(A)}{P(B)}$

6. Law of Total Probability:

   $P(A) = \sum_{i=1}^{n} P(A|B_i) \cdot P(B_i)$

7. Continuous probability density function:

   $f_X(x) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}$

8. Expectation of a continuous random variable:

   $E[X] = \int_{-\infty}^{\infty} x \cdot f_X(x) \, dx$

9. Double summation:

   $\sum_{i=1}^{m} \sum_{j=1}^{n} a_{ij} = \sum_{j=1}^{n} \sum_{i=1}^{m} a_{ij}$

10. Product of summations:

    $\left(\sum_{i=1}^{m} a_i\right) \left(\sum_{j=1}^{n} b_j\right) = \sum_{i=1}^{m} \sum_{j=1}^{n} a_i b_j$

## Mathematical Proofs

1. Proof that the sum of the first n positive integers is $\frac{n(n+1)}{2}$:

   Let $S_n = 1 + 2 + 3 + \cdots + n$
   
   $S_n = 1 + 2 + 3 + \cdots + (n-1) + n$
   $S_n = n + (n-1) + (n-2) + \cdots + 2 + 1$
   
   Adding these equations:
   
   $2S_n = (n+1) + (n+1) + (n+1) + \cdots + (n+1)$ [n times]
   
   $2S_n = n(n+1)$
   
   $S_n = \frac{n(n+1)}{2}$

2. Proof of the Pythagorean theorem:

   Given a right triangle with sides a, b, and hypotenuse c:
   
   Consider the square of side $(a+b)$:
   
   Area of the large square: $(a+b)^2$
   
   Area of four triangles: $4 \cdot \frac{1}{2}ab = 2ab$
   
   Area of inner square: $c^2$
   
   Therefore: $(a+b)^2 = 2ab + c^2$
   
   Expanding: $a^2 + 2ab + b^2 = 2ab + c^2$
   
   Cancelling $2ab$ from both sides: $a^2 + b^2 = c^2$

3. Proof that $\sqrt{2}$ is irrational:

   Assume $\sqrt{2}$ is rational. Then $\sqrt{2} = \frac{a}{b}$ where $a$ and $b$ are coprime integers.
   
   Squaring both sides: $2 = \frac{a^2}{b^2}$
   
   $2b^2 = a^2$
   
   This implies $a^2$ is even, so $a$ must be even. Let $a = 2k$.
   
   Substituting: $2b^2 = (2k)^2 = 4k^2$
   
   $b^2 = 2k^2$
   
   This implies $b^2$ is even, so $b$ must be even.
   
   But if both $a$ and $b$ are even, they are not coprime, contradicting our initial assumption.
   
   Therefore, $\sqrt{2}$ cannot be expressed as a ratio of integers and is irrational.

4. Euler's Identity proof sketch:

   $e^{ix} = \cos x + i \sin x$ (Euler's formula)
   
   Let $x = \pi$:
   
   $e^{i\pi} = \cos \pi + i \sin \pi = -1 + 0 = -1$
   
   Therefore: $e^{i\pi} + 1 = 0$

# Algorithm Pseudocode

## 1. Binary Search

```
function binary_search(A, n, T):
    L := 0
    R := n - 1
    while L <= R:
        m := floor((L + R) / 2)
        if A[m] < T:
            L := m + 1
        else if A[m] > T:
            R := m - 1
        else:
            return m
    return unsuccessful
```

Time Complexity: $O(\log n)$

## 2. Quicksort

```
function quicksort(A, low, high):
    if low < high:
        p := partition(A, low, high)
        quicksort(A, low, p - 1)
        quicksort(A, p + 1, high)

function partition(A, low, high):
    pivot := A[high]
    i := low - 1
    for j := low to high - 1:
        if A[j] <= pivot:
            i := i + 1
            swap A[i] with A[j]
    swap A[i + 1] with A[high]
    return i + 1
```

Average Time Complexity: $O(n \log n)$

## 3. Dijkstra's Algorithm

```
function dijkstra(Graph, source):
    dist[source] := 0
    create vertex set Q

    for each vertex v in Graph:
        if v ≠ source:
            dist[v] := infinity
            prev[v] := undefined
        Q.add_with_priority(v, dist[v])
    
    while Q is not empty:
        u := Q.extract_min()
        for each neighbor v of u:
            alt := dist[u] + length(u, v)
            if alt < dist[v]:
                dist[v] := alt
                prev[v] := u
                Q.decrease_priority(v, alt)
    
    return dist[], prev[]
```

Time Complexity: $O((|V| + |E|) \log |V|)$ with binary heap

## 4. Knapsack Problem (Dynamic Programming)

```
function knapsack(v, w, n, W):
    K := array of size [n+1][W+1]
    
    for i := 0 to n:
        for w := 0 to W:
            if i = 0 or w = 0:
                K[i][w] := 0
            else if w[i-1] <= w:
                K[i][w] := max(v[i-1] + K[i-1][w-w[i-1]], K[i-1][w])
            else:
                K[i][w] := K[i-1][w]
    
    return K[n][W]
```

Time Complexity: $O(nW)$, where $n$ is the number of items and $W$ is the knapsack capacity.

## 5. Floyd-Warshall Algorithm

```
function floyd_warshall(Graph):
    dist := |V| × |V| array initialized from the adjacency matrix of Graph
    
    for k := 1 to |V|:
        for i := 1 to |V|:
            for j := 1 to |V|:
                if dist[i][j] > dist[i][k] + dist[k][j]:
                    dist[i][j] := dist[i][k] + dist[k][j]
    
    return dist
```

Time Complexity: $O(|V|^3)$
