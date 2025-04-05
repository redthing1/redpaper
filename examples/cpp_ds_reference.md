---
title: "C++ Data Structures Reference Manual for Algorithmic Problem Solving"
author: Claude 3.7 Sonnet
date: 2025-04-05
fontsize: 10pt
numbersections: true
vibe: classic
---

# Introduction

## Overview

Data structures form the backbone of efficient algorithm design and implementation. In competitive programming environments like LeetCode, Codeforces, or technical interviews, the right data structure can transform an intractable problem into a straightforward solution. This reference manual provides a comprehensive guide to C++'s core data structures, focusing on their application in algorithmic problem-solving.

## The C++ Standard Template Library (STL)

C++ offers powerful data structures through its Standard Template Library (STL), which provides a collection of template classes and functions. The STL is divided into several components:

1. **Container Classes**: Implement common data structures like vectors, lists, stacks, queues, maps, and sets
2. **Algorithms**: Provide implementations for searching, sorting, and transforming container elements
3. **Iterators**: Act as a bridge between containers and algorithms, offering a uniform way to traverse elements
4. **Function Objects**: Allow customization of algorithm behavior

The STL's template-based design enables type-safe, efficient, and reusable code while abstracting away low-level implementation details.

## Selecting the Right Data Structure

Choosing an appropriate data structure depends on the operations required by your algorithm:

| Operation Type | Common Data Structures |
|----------------|------------------------|
| Sequential Access | `vector`, `array`, `deque` |
| Stack Operations (LIFO) | `stack` |
| Queue Operations (FIFO) | `queue` |
| Priority Queue | `priority_queue` |
| Associative Lookup | `unordered_map`, `unordered_set` |
| Ordered Traversal | `map`, `set` |
| Bidirectional Traversal | `list` |
| Interval Operations | Segment Trees, Fenwick Trees |
| Graph Representation | Adjacency List, Adjacency Matrix |

## Time and Space Complexity

When solving algorithmic problems, understanding the time and space complexity of each data structure is crucial:

```
O(1)       - Constant time: Direct access operations (array/vector indexing)
O(log n)   - Logarithmic time: Operations on balanced trees (map/set insertion)
O(n)       - Linear time: Traversing a container (vector iteration)
O(n log n) - Linearithmic time: Efficient sorting algorithms (sort())
O(n²)      - Quadratic time: Nested iterations (simple graph algorithms)
```

Each data structure in this manual includes complexity information to help you evaluate tradeoffs between different implementations.

## Common Problem Patterns

Certain problem patterns appear frequently in algorithmic challenges, each with preferred data structures:

1. **Two Pointers**: Arrays, vectors (`vector<int>`)
2. **Sliding Window**: Deques, maps (`deque<int>`, `unordered_map<>`)
3. **Binary Search**: Sorted arrays, vectors (`vector<int>`)
4. **Depth-First Search**: Stacks, recursion (`stack<>`, adjacency list)
5. **Breadth-First Search**: Queues (`queue<>`, adjacency list)
6. **Dynamic Programming**: Arrays, vectors, maps (`vector<vector<int>>`, `unordered_map<>`)
7. **Greedy Algorithms**: Priority queues (`priority_queue<>`)
8. **Union-Find**: Disjoint set data structure
9. **Backtracking**: Recursion with vectors or arrays
10. **Graph Algorithms**: Adjacency lists, matrices, priority queues

## Using This Reference Manual

This manual is organized into logical sections based on data structure types:

+ **Linear Containers**: Vector, array, deque, list
+ **Adapter Containers**: Stack, queue, priority queue
+ **Associative Containers**: Maps, sets, their unordered variants
+ **Advanced Tree Structures**: Binary search trees, balanced trees
+ **Graph Representations**: Adjacency lists, matrices
+ **Specialized Data Structures**: Trie, union-find, segment tree
+ **Utility Functions and Algorithms**: Sorting, binary search, bit manipulation

Each section provides:
- A brief description of the data structure
- Its time and space complexity
- Common operations with syntax examples
- Typical application scenarios
- Implementation details when relevant

For effective algorithmic problem-solving:

1. **Analyze the problem requirements** to determine the necessary operations
2. **Select an appropriate data structure** based on those operations
3. **Implement using the provided syntax examples** as templates
4. **Optimize by considering time and space complexity tradeoffs**

The examples in this manual are designed to illustrate typical usage patterns while maintaining readability and efficiency—principles that should guide your own implementations.

Let's begin with the fundamentals of linear containers, the workhorses of many algorithmic solutions.

# Linear Containers

## Vector
```cpp
#include <vector>
```

A dynamic array that grows as needed; the most commonly used container.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Access    | O(1)           |
| Insert/erase at end | O(1) amortized |
| Insert/erase elsewhere | O(n) |
| Search (unsorted) | O(n) |

### Common Operations
```cpp
// initialization
vector<int> v;                    // empty vector
vector<int> v(10);                // 10 elements with value 0
vector<int> v(10, 5);             // 10 elements with value 5
vector<int> v = {1, 2, 3, 4, 5};  // initialization with values

// size operations
int size = v.size();              // number of elements
bool empty = v.empty();           // check if empty
v.resize(20);                     // resize to 20 elements
v.resize(20, 7);                  // resize to 20, fill new with 7
v.reserve(100);                   // reserve capacity for 100 elements

// element access
int first = v[0];                 // no bounds checking
int last = v.back();              // last element
int first_safe = v.at(0);         // bounds checking, throws exception

// modifiers
v.push_back(6);                   // add element to end
v.pop_back();                     // remove last element
v.insert(v.begin() + 2, 8);       // insert 8 at index 2
v.erase(v.begin() + 3);           // erase element at index 3
v.clear();                        // clear all elements

// iterating
for (auto it = v.begin(); it != v.end(); ++it) {
    // use *it
}

// range-based for loop
for (int num : v) {
    // use num
}
```

### Example: 2D Vectors
```cpp
// 2D vector (matrix)
vector<vector<int>> matrix(3, vector<int>(4, 0));  // 3x4 matrix of zeros

// access elements
matrix[1][2] = 5;

// get dimensions
int rows = matrix.size();
int cols = matrix[0].size();
```

## Array
```cpp
#include <array>
```

Fixed-size array with bounds checking capabilities.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Access    | O(1)           |
| Search    | O(n)           |

### Common Operations
```cpp
// initialization
array<int, 5> arr = {1, 2, 3, 4, 5};

// size operations
int size = arr.size();
bool empty = arr.empty();

// element access
int first = arr[0];               // no bounds checking
int first_safe = arr.at(0);       // bounds checking
int first_element = arr.front();  // first element
int last_element = arr.back();    // last element

// modifiers (note: cannot change size)
arr.fill(10);                     // fill entire array with 10

// iterating
for (auto it = arr.begin(); it != arr.end(); ++it) {
    // use *it
}

// range-based for loop
for (int num : arr) {
    // use num
}
```

## Deque
```cpp
#include <deque>
```

Double-ended queue allowing fast insertion/deletion at both ends.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Access    | O(1)           |
| Insert/erase at ends | O(1) |
| Insert/erase in middle | O(n) |

### Common Operations
```cpp
// initialization
deque<int> dq;
deque<int> dq = {1, 2, 3, 4, 5};

// size operations
int size = dq.size();
bool empty = dq.empty();
dq.resize(10);

// element access
int first = dq[0];               // no bounds checking
int first_safe = dq.at(0);       // bounds checking
int first_element = dq.front();  // first element
int last_element = dq.back();    // last element

// modifiers
dq.push_back(6);                 // add to end
dq.push_front(0);                // add to front
dq.pop_back();                   // remove from end
dq.pop_front();                  // remove from front
dq.insert(dq.begin() + 2, 8);    // insert 8 at position 2
dq.erase(dq.begin() + 3);        // erase element at position 3
dq.clear();                      // remove all elements
```

## List
```cpp
#include <list>
```

Doubly linked list allowing constant time insertion/deletion anywhere in the list.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Access    | O(n)           |
| Insert/erase with iterator | O(1) |
| Search    | O(n)           |

### Common Operations
```cpp
// initialization
list<int> lst;
list<int> lst = {1, 2, 3, 4, 5};

// size operations
int size = lst.size();
bool empty = lst.empty();

// element access (note: no random access)
int first = lst.front();         // first element
int last = lst.back();           // last element

// modifiers
lst.push_back(6);                // add to end
lst.push_front(0);               // add to front
lst.pop_back();                  // remove from end
lst.pop_front();                 // remove from front

// with iterators
auto it = lst.begin();
advance(it, 2);                  // move iterator forward 2 positions
lst.insert(it, 8);               // insert 8 before position of iterator
lst.erase(it);                   // erase element at iterator position

// special operations
lst.sort();                      // sort the list
lst.unique();                    // remove consecutive duplicates
lst.reverse();                   // reverse the list
lst.remove(3);                   // remove all elements with value 3
lst.remove_if([](int x) { return x > 10; });  // remove elements > 10
```

## Forward List
```cpp
#include <forward_list>
```

Singly linked list optimized for forward traversal.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Access    | O(n)           |
| Insert/erase after position | O(1) |
| Search    | O(n)           |

### Common Operations
```cpp
// initialization
forward_list<int> fl;
forward_list<int> fl = {1, 2, 3, 4, 5};

// size operations (note: no size() function)
bool empty = fl.empty();

// element access
int first = fl.front();          // first element

// modifiers
fl.push_front(0);                // add to front
fl.pop_front();                  // remove from front

// with iterators
auto it = fl.begin();
auto prev = fl.before_begin();   // iterator before first element
fl.insert_after(prev, 8);        // insert 8 after position
fl.erase_after(it);              // erase element after iterator position

// special operations
fl.sort();                       // sort the list
fl.unique();                     // remove consecutive duplicates
fl.reverse();                    // reverse the list
fl.remove(3);                    // remove all elements with value 3
```

# Adapter Containers

## Stack
```cpp
#include <stack>
```

Last-in-first-out (LIFO) data structure.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| push/pop  | O(1)           |
| top       | O(1)           |

### Common Operations
```cpp
// initialization
stack<int> s;

// size operations
int size = s.size();
bool empty = s.empty();

// element access
int top_element = s.top();       // access top element

// modifiers
s.push(10);                      // add element to top
s.pop();                         // remove top element

// typical use case in problems
bool isValid(string s) {
    stack<char> stk;
    for (char c : s) {
        if (c == '(') {
            stk.push(c);
        } else if (c == ')') {
            if (stk.empty() || stk.top() != '(') return false;
            stk.pop();
        }
    }
    return stk.empty();
}
```

## Queue
```cpp
#include <queue>
```

First-in-first-out (FIFO) data structure.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| push/pop  | O(1)           |
| front/back| O(1)           |

### Common Operations
```cpp
// initialization
queue<int> q;

// size operations
int size = q.size();
bool empty = q.empty();

// element access
int front_element = q.front();    // first element
int back_element = q.back();      // last element

// modifiers
q.push(10);                       // add element to back
q.pop();                          // remove front element

// typical use in BFS
void bfs(vector<vector<int>>& graph, int start) {
    vector<bool> visited(graph.size(), false);
    queue<int> q;
    
    visited[start] = true;
    q.push(start);
    
    while (!q.empty()) {
        int node = q.front();
        q.pop();
        cout << node << " ";
        
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                q.push(neighbor);
            }
        }
    }
}
```

## Priority Queue (Heap)
```cpp
#include <queue>
```

A container that provides constant time extraction of the largest element, implemented as a max-heap by default.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| push/pop  | O(log n)       |
| top       | O(1)           |

### Common Operations
```cpp
// initialization (max heap by default)
priority_queue<int> pq;
priority_queue<int> pq_from_vector(v.begin(), v.end());

// min heap (two ways)
priority_queue<int, vector<int>, greater<int>> min_pq;
// or negate values when inserting/extracting:
priority_queue<int> min_pq_trick;  // push -x, get -top()

// size operations
int size = pq.size();
bool empty = pq.empty();

// element access
int top_element = pq.top();       // largest element

// modifiers
pq.push(10);                      // add element
pq.pop();                         // remove largest element

// custom comparator for complex types
struct Compare {
    bool operator()(const pair<int, int>& a, const pair<int, int>& b) {
        return a.first > b.first; // min heap based on first element
    }
};
priority_queue<pair<int, int>, vector<pair<int, int>>, Compare> custom_pq;

// typical use in Dijkstra's algorithm
void dijkstra(vector<vector<pair<int, int>>>& graph, int start) {
    int n = graph.size();
    vector<int> dist(n, INT_MAX);
    dist[start] = 0;
    
    // min heap of (distance, node) pairs
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, start});
    
    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        
        if (d > dist[u]) continue;  // skip outdated entries
        
        for (auto [v, weight] : graph[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push({dist[v], v});
            }
        }
    }
}
```

# Associative Containers

## Unordered Map (Hash Table)
```cpp
#include <unordered_map>
```

Hash table implementation for key-value pairs with amortized constant-time access.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Insert/Erase/Access | O(1) average, O(n) worst |
| Search    | O(1) average, O(n) worst |

### Common Operations
```cpp
// initialization
unordered_map<string, int> um;
unordered_map<string, int> um = {{"one", 1}, {"two", 2}};

// size operations
int size = um.size();
bool empty = um.empty();

// element access and insertion
um["key"] = 42;                  // insert or update
int val = um["key"];             // access (creates key if not exists)
int val_safe = um.at("key");     // access with bounds checking

// check if key exists
bool exists = um.count("key");   // 1 if exists, 0 if not
auto it = um.find("key");        // iterator to element or um.end()
if (it != um.end()) {
    // key exists
}

// modifiers
um.insert({"key", 100});         // insert only if not exists
um.insert(make_pair("key", 100));// same as above
um.erase("key");                 // remove by key
um.clear();                      // remove all elements

// iterate
for (const auto& [key, value] : um) {
    // use key and value
}

// typical use in problems
vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> map;  // value -> index
    for (int i = 0; i < nums.size(); i++) {
        int complement = target - nums[i];
        if (map.count(complement)) {
            return {map[complement], i};
        }
        map[nums[i]] = i;
    }
    return {};
}
```

## Unordered Set (Hash Set)
```cpp
#include <unordered_set>
```

Hash table implementation for storing unique values.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Insert/Erase/Contains | O(1) average, O(n) worst |

### Common Operations
```cpp
// initialization
unordered_set<int> us;
unordered_set<int> us = {1, 2, 3, 4, 5};

// size operations
int size = us.size();
bool empty = us.empty();

// check if value exists
bool exists = us.count(3);       // 1 if exists, 0 if not
auto it = us.find(3);            // iterator to element or us.end()

// modifiers
us.insert(6);                    // insert if not exists
us.erase(3);                     // remove element
us.clear();                      // remove all elements

// iterate
for (int num : us) {
    // use num
}

// typical use in problems
bool containsDuplicate(vector<int>& nums) {
    unordered_set<int> seen;
    for (int num : nums) {
        if (seen.count(num)) {
            return true;
        }
        seen.insert(num);
    }
    return false;
}
```

## Map (Ordered Map)
```cpp
#include <map>
```

Tree-based implementation (typically red-black tree) for key-value pairs with ordered keys.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Insert/Erase/Access | O(log n) |
| Search    | O(log n) |

### Common Operations
```cpp
// initialization
map<string, int> m;
map<string, int> m = {{"one", 1}, {"two", 2}};

// size operations
int size = m.size();
bool empty = m.empty();

// element access and insertion
m["key"] = 42;                   // insert or update
int val = m["key"];              // access (creates key if not exists)
int val_safe = m.at("key");      // access with bounds checking

// check if key exists
bool exists = m.count("key");    // 1 if exists, 0 if not
auto it = m.find("key");         // iterator to element or m.end()

// modifiers
m.insert({"key", 100});          // insert only if not exists
m.erase("key");                  // remove by key
m.clear();                       // remove all elements

// additional operations (using ordered property)
auto it1 = m.lower_bound("key"); // first element >= key
auto it2 = m.upper_bound("key"); // first element > key

// typical use when order matters
void printSortedFrequency(vector<string>& words) {
    map<string, int> freq;
    for (const string& word : words) {
        freq[word]++;
    }
    
    for (const auto& [word, count] : freq) {
        cout << word << ": " << count << endl;
    }
}
```

## Set (Ordered Set)
```cpp
#include <set>
```

Tree-based implementation for storing unique values in sorted order.

### Complexity
| Operation | Time Complexity |
|-----------|----------------|
| Insert/Erase/Contains | O(log n) |

### Common Operations
```cpp
// initialization
set<int> s;
set<int> s = {5, 2, 8, 1, 3};    // will be stored as {1, 2, 3, 5, 8}

// size operations
int size = s.size();
bool empty = s.empty();

// check if value exists
bool exists = s.count(3);        // 1 if exists, 0 if not
auto it = s.find(3);             // iterator to element or s.end()

// modifiers
s.insert(6);                     // insert if not exists
s.erase(3);                      // remove element
s.clear();                       // remove all elements

// additional operations (using ordered property)
auto it1 = s.lower_bound(3);     // iterator to first element >= 3
auto it2 = s.upper_bound(3);     // iterator to first element > 3

// iterate (in sorted order)
for (int num : s) {
    // use num
}

// typical use for keeping unique sorted elements
vector<int> removeDuplicatesAndSort(vector<int>& nums) {
    set<int> s(nums.begin(), nums.end());
    return vector<int>(s.begin(), s.end());
}
```

## Multimap and Multiset
```cpp
#include <map>
#include <set>
```

Variants of map and set that allow duplicate keys/values.

### Common Operations
```cpp
// multimap (allows duplicate keys)
multimap<string, int> mm;
mm.insert({"key", 1});
mm.insert({"key", 2});  // now has two entries for "key"

// getting all values for a key
auto range = mm.equal_range("key");
for (auto it = range.first; it != range.second; ++it) {
    // use it->second (the value)
}

// multiset (allows duplicate values)
multiset<int> ms;
ms.insert(5);
ms.insert(5);  // now has two 5s

// erase a single instance
ms.erase(ms.find(5));  // removes one 5
ms.erase(5);           // removes all 5s
```

# Utility Functions and Algorithms

## Sorting
```cpp
#include <algorithm>
```

### Basic Sorting
```cpp
// sort vector
vector<int> v = {5, 2, 8, 1, 9};
sort(v.begin(), v.end());        // ascending: {1, 2, 5, 8, 9}
sort(v.rbegin(), v.rend());      // descending: {9, 8, 5, 2, 1}

// sort with custom comparator
sort(v.begin(), v.end(), [](int a, int b) {
    return a > b;  // descending order
});

// sort part of container
sort(v.begin() + 1, v.begin() + 4);  // sort only elements at index 1,2,3

// stable sort (preserves order of equal elements)
stable_sort(v.begin(), v.end());

// sort array
int arr[5] = {5, 2, 8, 1, 9};
sort(arr, arr + 5);
```

### Partial Sorting
```cpp
// partial_sort: puts the first n elements in sorted order
vector<int> v = {5, 2, 8, 1, 9, 3, 7};
partial_sort(v.begin(), v.begin() + 3, v.end());
// Result: {1, 2, 3, ?, ?, ?, ?} where ? are remaining elements in any order

// nth_element: ensures nth element is in correct position
// elements before are <= and elements after are >=
nth_element(v.begin(), v.begin() + 2, v.end());
// Result: v[2] is the 3rd smallest element, and partition is maintained
```

### Heap Operations
```cpp
vector<int> v = {5, 2, 8, 1, 9};

// make heap
make_heap(v.begin(), v.end());        // {9, 5, 8, 1, 2}

// push heap: add element to back then fix heap
v.push_back(10);
push_heap(v.begin(), v.end());        // {10, 5, 9, 1, 2, 8}

// pop heap: move largest element to end and fix heap
pop_heap(v.begin(), v.end());         // {9, 5, 8, 1, 2, 10}
int largest = v.back();
v.pop_back();

// check if container is a heap
bool is_heap = is_heap(v.begin(), v.end());
```

## Binary Search
```cpp
#include <algorithm>
```

### Binary Search Functions
```cpp
vector<int> v = {1, 2, 3, 5, 7, 9, 11};  // must be sorted

// check if value exists
bool exists = binary_search(v.begin(), v.end(), 5);  // true

// find first element >= value
auto it1 = lower_bound(v.begin(), v.end(), 4);
// *it1 == 5, it1 - v.begin() == 3

// find first element > value
auto it2 = upper_bound(v.begin(), v.end(), 5);
// *it2 == 7, it2 - v.begin() == 4

// find range of elements equal to value
auto [first, last] = equal_range(v.begin(), v.end(), 5);
// first points to first occurrence, last points to after last occurrence
```

### Manual Binary Search
```cpp
// finding a specific element
int binarySearch(vector<int>& nums, int target) {
    int left = 0, right = nums.size() - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (nums[mid] == target) {
            return mid;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    
    return -1;  // not found
}

// finding first position where condition is true
int findFirstTruePosition(vector<bool>& conditions) {
    int left = 0, right = conditions.size() - 1;
    int result = conditions.size();  // default if no true found
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (conditions[mid]) {
            result = mid;  // found a candidate, but keep searching left
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    
    return result;
}
```

## Random Number Generation
```cpp
#include <random>
```

### Random Engines and Distributions
```cpp
// modern C++ random number generation
random_device rd;              // true random number generator, if available
mt19937 gen(rd());             // standard mersenne twister engine
uniform_int_distribution<> dis(1, 6);  // uniform distribution from 1 to 6

int random_dice_roll = dis(gen);  // generate random number

// other distributions
uniform_real_distribution<> real_dist(0.0, 1.0);  // floating point between 0 and 1
normal_distribution<> normal_dist(0.0, 1.0);      // normal distribution with mean 0, std dev 1

// random shuffling
vector<int> v = {1, 2, 3, 4, 5};
shuffle(v.begin(), v.end(), gen);

// random selection
int random_index = uniform_int_distribution<>(0, v.size() - 1)(gen);
int random_element = v[random_index];
```

### Simple Random for LeetCode Style Problems
```cpp
// quick way for random integer in a range
int randInt(int min, int max) {
    return min + rand() % (max - min + 1);
}

// random permutation
vector<int> randomPermutation(int n) {
    vector<int> perm(n);
    iota(perm.begin(), perm.end(), 0);  // fill with 0, 1, ..., n-1
    
    for (int i = 0; i < n; i++) {
        swap(perm[i], perm[randInt(i, n - 1)]);
    }
    
    return perm;
}
```

## String Manipulation
```cpp
#include <string>
#include <sstream>
```

### String Operations
```cpp
// string construction
string s = "hello";
string s2 = s + " world";           // concatenation

// access and modification
char c = s[1];                      // 'e'
s[1] = 'a';                         // changes "hello" to "hallo"

// size operations
int len = s.length();               // or s.size()
bool empty = s.empty();

// substring
string sub = s.substr(1, 3);        // "all" (from index 1, length 3)
string suffix = s.substr(1);        // "allo" (from index 1 to end)

// searching
size_t pos = s.find("ll");          // returns index of first occurrence or string::npos if not found
bool contains = s.find("ll") != string::npos;

// modifying
s.insert(1, "ey");                  // insert at position: "heyallo"
s.erase(1, 2);                      // erase from position 1, length 2: "hllo"
s.replace(1, 2, "ey");              // replace substring: "heylo"

// string to number conversions
int num = stoi("123");              // string to int
long num_l = stol("123456789");     // string to long
float num_f = stof("3.14");         // string to float
double num_d = stod("3.1415926");   // string to double

// number to string
string str = to_string(123);        // int to string
string str_d = to_string(3.14159);  // double to string

// case conversion (in-place)
transform(s.begin(), s.end(), s.begin(), ::toupper);  // to uppercase
transform(s.begin(), s.end(), s.begin(), ::tolower);  // to lowercase
```

### String Splitting and Joining
```cpp
// splitting string by delimiter
vector<string> split(const string& s, char delimiter) {
    vector<string> tokens;
    string token;
    istringstream tokenStream(s);
    
    while (getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    
    return tokens;
}

// joining strings with delimiter
string join(const vector<string>& strings, const string& delimiter) {
    string result;
    for (size_t i = 0; i < strings.size(); i++) {
        result += strings[i];
        if (i < strings.size() - 1) {
            result += delimiter;
        }
    }
    return result;
}
```

# Custom Data Structures

## Trie
Efficient for string search operations.

```cpp
class Trie {
private:
    struct TrieNode {
        TrieNode* children[26] = {nullptr};
        bool isEndOfWord = false;
    };
    
    TrieNode* root;
    
public:
    Trie() {
        root = new TrieNode();
    }
    
    // Insert a word into the trie
    void insert(string word) {
        TrieNode* node = root;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                node->children[index] = new TrieNode();
            }
            node = node->children[index];
        }
        node->isEndOfWord = true;
    }
    
    // Search for a word in the trie
    bool search(string word) {
        TrieNode* node = root;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                return false;
            }
            node = node->children[index];
        }
        return node->isEndOfWord;
    }
    
    // Check if the trie has any words with the given prefix
    bool startsWith(string prefix) {
        TrieNode* node = root;
        for (char c : prefix) {
            int index = c - 'a';
            if (!node->children[index]) {
                return false;
            }
            node = node->children[index];
        }
        return true;
    }
};

// Usage
Trie trie;
trie.insert("apple");
bool exists = trie.search("apple");      // true
bool exists2 = trie.search("app");       // false
bool prefix = trie.startsWith("app");    // true
```

## Disjoint Set (Union-Find)
Used for grouping elements into disjoint sets.

```cpp
class DisjointSet {
private:
    vector<int> parent;
    vector<int> rank;
    
public:
    DisjointSet(int n) {
        // initialize with each element as its own parent
        parent.resize(n);
        rank.resize(n, 0);
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }
    
    // find the representative of the set (with path compression)
    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);  // path compression
        }
        return parent[x];
    }
    
    // union two sets (using rank for balancing)
    void unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return;
        
        // union by rank
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
    
    // check if two elements are in the same set
    bool areConnected(int x, int y) {
        return find(x) == find(y);
    }
    
    // count number of distinct sets
    int countSets() {
        int count = 0;
        for (int i = 0; i < parent.size(); i++) {
            if (parent[i] == i) {
                count++;
            }
        }
        return count;
    }
};

// Usage for number of islands
int numIslands(vector<vector<char>>& grid) {
    if (grid.empty()) return 0;
    
    int m = grid.size();
    int n = grid[0].size();
    DisjointSet ds(m * n);
    
    int zeros = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '0') {
                zeros++;
                continue;
            }
            
            int idx = i * n + j;
            
            // check adjacent cells (right and down)
            if (i + 1 < m && grid[i + 1][j] == '1') {
                ds.unionSets(idx, (i + 1) * n + j);
            }
            if (j + 1 < n && grid[i][j + 1] == '1') {
                ds.unionSets(idx, i * n + (j + 1));
            }
        }
    }
    
    return ds.countSets() - zeros;
}
```

## Segment Tree
Efficient for range queries and updates.

```cpp
class SegmentTree {
private:
    int n;
    vector<int> tree;
    
    // Build the tree
    void build(vector<int>& nums, int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
            return;
        }
        
        int mid = (start + end) / 2;
        build(nums, 2 * node + 1, start, mid);
        build(nums, 2 * node + 2, mid + 1, end);
        
        // internal nodes store sum of children
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }
    
    // Query in range [qstart, qend]
    int query(int node, int start, int end, int qstart, int qend) {
        // no overlap
        if (qstart > end || qend < start) {
            return 0;
        }
        
        // complete overlap
        if (qstart <= start && qend >= end) {
            return tree[node];
        }
        
        // partial overlap - recurse on children
        int mid = (start + end) / 2;
        int left = query(2 * node + 1, start, mid, qstart, qend);
        int right = query(2 * node + 2, mid + 1, end, qstart, qend);
        
        return left + right;
    }
    
    // Update value at index
    void update(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = val;
            return;
        }
        
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node + 1, start, mid, idx, val);
        } else {
            update(2 * node + 2, mid + 1, end, idx, val);
        }
        
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }
    
public:
    SegmentTree(vector<int>& nums) {
        n = nums.size();
        // segment tree needs 4n space in worst case
        tree.resize(4 * n, 0);
        if (n > 0) {
            build(nums, 0, 0, n - 1);
        }
    }
    
    // Query sum in range [start, end]
    int queryRange(int start, int end) {
        if (start < 0 || end >= n || start > end) {
            return 0;
        }
        return query(0, 0, n - 1, start, end);
    }
    
    // Update value at index
    void updateValue(int idx, int val) {
        if (idx < 0 || idx >= n) {
            return;
        }
        update(0, 0, n - 1, idx, val);
    }
};

// Usage
vector<int> nums = {1, 3, 5, 7, 9, 11};
SegmentTree segTree(nums);
int sum_0_3 = segTree.queryRange(0, 3);  // 1+3+5+7 = 16
segTree.updateValue(1, 10);              // change 3 to 10
int new_sum = segTree.queryRange(0, 3);  // 1+10+5+7 = 23
```

# Advanced Tree Structures

## Binary Search Tree
```cpp
#include <memory>
```

An ordered binary tree data structure.

### Implementation
```cpp
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class BinarySearchTree {
private:
    TreeNode* root;
    
    // helper function for insertion
    TreeNode* insertRecursive(TreeNode* node, int val) {
        if (node == nullptr) {
            return new TreeNode(val);
        }
        
        if (val < node->val) {
            node->left = insertRecursive(node->left, val);
        } else if (val > node->val) {
            node->right = insertRecursive(node->right, val);
        }
        
        return node;
    }
    
    // helper function for search
    TreeNode* searchRecursive(TreeNode* node, int val) {
        if (node == nullptr || node->val == val) {
            return node;
        }
        
        if (val < node->val) {
            return searchRecursive(node->left, val);
        }
        
        return searchRecursive(node->right, val);
    }
    
    // helper function for in-order traversal
    void inOrderTraversal(TreeNode* node, vector<int>& result) {
        if (node == nullptr) return;
        
        inOrderTraversal(node->left, result);
        result.push_back(node->val);
        inOrderTraversal(node->right, result);
    }
    
public:
    BinarySearchTree() : root(nullptr) {}
    
    void insert(int val) {
        if (root == nullptr) {
            root = new TreeNode(val);
            return;
        }
        
        insertRecursive(root, val);
    }
    
    bool search(int val) {
        return searchRecursive(root, val) != nullptr;
    }
    
    vector<int> inOrder() {
        vector<int> result;
        inOrderTraversal(root, result);
        return result;
    }
    
    // other tree operations would go here (delete, etc.)
};
```

## Balanced Binary Search Trees

### AVL Tree
```cpp
struct AVLNode {
    int val;
    int height;
    AVLNode* left;
    AVLNode* right;
    
    AVLNode(int x) : val(x), height(1), left(nullptr), right(nullptr) {}
};

class AVLTree {
private:
    AVLNode* root;
    
    // get height of node
    int height(AVLNode* node) {
        if (node == nullptr) return 0;
        return node->height;
    }
    
    // get balance factor
    int getBalance(AVLNode* node) {
        if (node == nullptr) return 0;
        return height(node->left) - height(node->right);
    }
    
    // update height of node
    void updateHeight(AVLNode* node) {
        if (node == nullptr) return;
        node->height = 1 + max(height(node->left), height(node->right));
    }
    
    // right rotation
    AVLNode* rightRotate(AVLNode* y) {
        AVLNode* x = y->left;
        AVLNode* T2 = x->right;
        
        // perform rotation
        x->right = y;
        y->left = T2;
        
        // update heights
        updateHeight(y);
        updateHeight(x);
        
        return x;
    }
    
    // left rotation
    AVLNode* leftRotate(AVLNode* x) {
        AVLNode* y = x->right;
        AVLNode* T2 = y->left;
        
        // perform rotation
        y->left = x;
        x->right = T2;
        
        // update heights
        updateHeight(x);
        updateHeight(y);
        
        return y;
    }
    
    // insert helper
    AVLNode* insertRecursive(AVLNode* node, int val) {
        // standard BST insert
        if (node == nullptr) {
            return new AVLNode(val);
        }
        
        if (val < node->val) {
            node->left = insertRecursive(node->left, val);
        } else if (val > node->val) {
            node->right = insertRecursive(node->right, val);
        } else {
            // duplicate values not allowed
            return node;
        }
        
        // update height
        updateHeight(node);
        
        // get balance factor
        int balance = getBalance(node);
        
        // left-left case
        if (balance > 1 && val < node->left->val) {
            return rightRotate(node);
        }
        
        // right-right case
        if (balance < -1 && val > node->right->val) {
            return leftRotate(node);
        }
        
        // left-right case
        if (balance > 1 && val > node->left->val) {
            node->left = leftRotate(node->left);
            return rightRotate(node);
        }
        
        // right-left case
        if (balance < -1 && val < node->right->val) {
            node->right = rightRotate(node->right);
            return leftRotate(node);
        }
        
        return node;
    }
    
public:
    AVLTree() : root(nullptr) {}
    
    void insert(int val) {
        root = insertRecursive(root, val);
    }
    
    // other operations would go here
};
```

# Graph Algorithms

## Graph Representations
```cpp
// Adjacency Matrix
vector<vector<int>> createAdjMatrix(int n, vector<vector<int>>& edges, bool isDirected = false) {
    vector<vector<int>> adjMatrix(n, vector<int>(n, 0));
    
    for (const auto& edge : edges) {
        int from = edge[0];
        int to = edge[1];
        int weight = edge.size() > 2 ? edge[2] : 1;
        
        adjMatrix[from][to] = weight;
        if (!isDirected) {
            adjMatrix[to][from] = weight;
        }
    }
    
    return adjMatrix;
}

// Adjacency List
vector<vector<pair<int, int>>> createAdjList(int n, vector<vector<int>>& edges, bool isDirected = false) {
    vector<vector<pair<int, int>>> adjList(n);
    
    for (const auto& edge : edges) {
        int from = edge[0];
        int to = edge[1];
        int weight = edge.size() > 2 ? edge[2] : 1;
        
        adjList[from].push_back({to, weight});
        if (!isDirected) {
            adjList[to].push_back({from, weight});
        }
    }
    
    return adjList;
}
```

## Graph Traversal

### DFS (Depth-First Search)
```cpp
void dfs(vector<vector<int>>& adjList, int node, vector<bool>& visited) {
    visited[node] = true;
    cout << node << " ";
    
    for (int neighbor : adjList[node]) {
        if (!visited[neighbor]) {
            dfs(adjList, neighbor, visited);
        }
    }
}

// Iterative DFS (using stack)
void dfsIterative(vector<vector<int>>& adjList, int start) {
    vector<bool> visited(adjList.size(), false);
    stack<int> s;
    
    s.push(start);
    visited[start] = true;
    
    while (!s.empty()) {
        int node = s.top();
        s.pop();
        cout << node << " ";
        
        // Visit neighbors in reverse order to match recursive DFS
        for (int i = adjList[node].size() - 1; i >= 0; i--) {
            int neighbor = adjList[node][i];
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                s.push(neighbor);
            }
        }
    }
}
```

### BFS (Breadth-First Search)
```cpp
void bfs(vector<vector<int>>& adjList, int start) {
    vector<bool> visited(adjList.size(), false);
    queue<int> q;
    
    visited[start] = true;
    q.push(start);
    
    while (!q.empty()) {
        int node = q.front();
        q.pop();
        cout << node << " ";
        
        for (int neighbor : adjList[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                q.push(neighbor);
            }
        }
    }
}
```

## Shortest Path Algorithms

### Dijkstra's Algorithm
```cpp
// Single source shortest path for weighted graphs (no negative weights)
vector<int> dijkstra(vector<vector<pair<int, int>>>& adjList, int start) {
    int n = adjList.size();
    vector<int> dist(n, INT_MAX);
    dist[start] = 0;
    
    // Min heap of (distance, node) pairs
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, start});
    
    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        
        if (d > dist[u]) continue;  // Skip outdated entries
        
        for (auto [v, weight] : adjList[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push({dist[v], v});
            }
        }
    }
    
    return dist;
}
```

### Bellman-Ford Algorithm
```cpp
// Single source shortest path that works with negative weights
// Returns false if negative cycle exists
bool bellmanFord(int n, vector<vector<int>>& edges, int start, vector<int>& dist) {
    dist.assign(n, INT_MAX);
    dist[start] = 0;
    
    // Relax all edges |V| - 1 times
    for (int i = 0; i < n - 1; i++) {
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            
            if (dist[u] != INT_MAX && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
            }
        }
    }
    
    // Check for negative cycles
    for (const auto& edge : edges) {
        int u = edge[0];
        int v = edge[1];
        int w = edge[2];
        
        if (dist[u] != INT_MAX && dist[u] + w < dist[v]) {
            return false;  // Negative cycle exists
        }
    }
    
    return true;
}
```

### Floyd-Warshall Algorithm
```cpp
// All pairs shortest path
void floydWarshall(vector<vector<int>>& graph) {
    int n = graph.size();
    
    // Initialize
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j && graph[i][j] == 0) {
                graph[i][j] = INT_MAX;  // No direct edge
            }
        }
    }
    
    // Main algorithm
    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (graph[i][k] != INT_MAX && graph[k][j] != INT_MAX && 
                    graph[i][k] + graph[k][j] < graph[i][j]) {
                    graph[i][j] = graph[i][k] + graph[k][j];
                }
            }
        }
    }
}
```

## Minimum Spanning Tree

### Kruskal's Algorithm
```cpp
// Find minimum spanning tree using Kruskal's algorithm
vector<vector<int>> kruskalMST(int n, vector<vector<int>>& edges) {
    // Sort edges by weight
    sort(edges.begin(), edges.end(), [](vector<int>& a, vector<int>& b) {
        return a[2] < b[2];
    });
    
    // Initialize disjoint set
    DisjointSet ds(n);
    
    // Store MST edges
    vector<vector<int>> mst;
    
    for (const auto& edge : edges) {
        int u = edge[0];
        int v = edge[1];
        int w = edge[2];
        
        if (!ds.areConnected(u, v)) {
            ds.unionSets(u, v);
            mst.push_back(edge);
        }
    }
    
    return mst;
}
```

### Prim's Algorithm
```cpp
// Find minimum spanning tree using Prim's algorithm
vector<vector<int>> primMST(vector<vector<pair<int, int>>>& adjList) {
    int n = adjList.size();
    vector<bool> inMST(n, false);
    vector<int> key(n, INT_MAX);
    vector<int> parent(n, -1);
    
    // Min heap of (weight, vertex) pairs
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    
    // Start with vertex 0
    key[0] = 0;
    pq.push({0, 0});
    
    while (!pq.empty()) {
        int u = pq.top().second;
        pq.pop();
        
        inMST[u] = true;
        
        for (auto& [v, weight] : adjList[u]) {
            if (!inMST[v] && weight < key[v]) {
                parent[v] = u;
                key[v] = weight;
                pq.push({key[v], v});
            }
        }
    }
    
    // Construct MST
    vector<vector<int>> mst;
    for (int i = 1; i < n; i++) {
        mst.push_back({parent[i], i, key[i]});
    }
    
    return mst;
}
```

# String Algorithms

## String Matching Algorithms

### Knuth-Morris-Pratt (KMP)
```cpp
// Build the lps array (longest proper prefix which is also suffix)
vector<int> computeLPS(string pattern) {
    int m = pattern.length();
    vector<int> lps(m, 0);
    
    int len = 0;
    int i = 1;
    
    while (i < m) {
        if (pattern[i] == pattern[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
    
    return lps;
}

// KMP algorithm for pattern matching
vector<int> kmpSearch(string text, string pattern) {
    int n = text.length();
    int m = pattern.length();
    vector<int> lps = computeLPS(pattern);
    vector<int> matches;
    
    int i = 0;  // index for text
    int j = 0;  // index for pattern
    
    while (i < n) {
        if (pattern[j] == text[i]) {
            i++;
            j++;
        }
        
        if (j == m) {
            matches.push_back(i - j);
            j = lps[j - 1];
        } else if (i < n && pattern[j] != text[i]) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }
    
    return matches;
}
```

### Z Algorithm
```cpp
// Calculate Z array (Z[i] = length of longest substring starting at i that is also a prefix)
vector<int> computeZ(string s) {
    int n = s.length();
    vector<int> z(n, 0);
    
    int l = 0, r = 0;
    for (int i = 1; i < n; i++) {
        if (i <= r) {
            z[i] = min(r - i + 1, z[i - l]);
        }
        
        while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
            z[i]++;
        }
        
        if (i + z[i] - 1 > r) {
            l = i;
            r = i + z[i] - 1;
        }
    }
    
    return z;
}

// Z algorithm for pattern matching
vector<int> zSearch(string text, string pattern) {
    string s = pattern + "$" + text;
    vector<int> z = computeZ(s);
    vector<int> matches;
    
    for (int i = 0; i < z.size(); i++) {
        if (z[i] == pattern.length()) {
            matches.push_back(i - pattern.length() - 1);
        }
    }
    
    return matches;
}
```

## Trie-based Algorithms

### Suffix Trie
```cpp
class SuffixTrie {
private:
    struct Node {
        unordered_map<char, Node*> children;
        bool isEndOfWord;
        
        Node() : isEndOfWord(false) {}
    };
    
    Node* root;
    
public:
    SuffixTrie() {
        root = new Node();
    }
    
    // Insert all suffixes of a string
    void insertAllSuffixes(string s) {
        for (int i = 0; i < s.length(); i++) {
            insertSuffix(s.substr(i));
        }
    }
    
    // Insert a single suffix
    void insertSuffix(string suffix) {
        Node* node = root;
        for (char c : suffix) {
            if (node->children.find(c) == node->children.end()) {
                node->children[c] = new Node();
            }
            node = node->children[c];
        }
        node->isEndOfWord = true;
    }
    
    // Search for a pattern
    bool search(string pattern) {
        Node* node = root;
        for (char c : pattern) {
            if (node->children.find(c) == node->children.end()) {
                return false;
            }
            node = node->children[c];
        }
        return true;
    }
};
```

# Bit Manipulation

## Common Bit Operations
```cpp
// Check if the kth bit is set
bool isKthBitSet(int n, int k) {
    return (n & (1 << k)) != 0;
}

// Set the kth bit
int setKthBit(int n, int k) {
    return n | (1 << k);
}

// Clear the kth bit
int clearKthBit(int n, int k) {
    return n & ~(1 << k);
}

// Toggle the kth bit
int toggleKthBit(int n, int k) {
    return n ^ (1 << k);
}

// Count the number of set bits (popcount)
int countSetBits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

// Count set bits using built-in function
int countSetBitsFast(int n) {
    return __builtin_popcount(n);  // GCC compiler intrinsic
}

// Check if n is a power of 2
bool isPowerOfTwo(int n) {
    return n > 0 && (n & (n - 1)) == 0;
}

// Find the position of the rightmost set bit
int rightmostSetBit(int n) {
    if (n == 0) return -1;
    return log2(n & -n);
}

// Set all bits from MSB to given position
int setAllBitsFromMSBToPos(int n, int pos) {
    return n | ((1 << (pos + 1)) - 1);
}

// Clear all bits from LSB to given position
int clearAllBitsFromLSBToPos(int n, int pos) {
    return n & (~((1 << (pos + 1)) - 1));
}
```

## Bit Manipulation Tricks
```cpp
// Get the lowest set bit
int lowestBit(int n) {
    return n & -n;
}

// Turn off the rightmost set bit
int turnOffRightmostSetBit(int n) {
    return n & (n - 1);
}

// Check if exactly one bit is set
bool exactlyOneBitSet(int n) {
    return n > 0 && (n & (n - 1)) == 0;
}

// Swap two numbers without using a temporary variable
void swapWithBits(int& a, int& b) {
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
}

// Get the absolute value without branching
int absoluteValue(int n) {
    int mask = n >> 31;  // all 1's if negative, all 0's if positive
    return (n + mask) ^ mask;
}

// Count number of different bits between two numbers
int hammingDistance(int x, int y) {
    return countSetBits(x ^ y);
}
```

## Advanced Bit Operations 
```cpp
// Find non-repeating number in an array where all other numbers appear twice
int findSingleNumber(vector<int>& nums) {
    int result = 0;
    for (int num : nums) {
        result ^= num;
    }
    return result;
}

// Find two non-repeating numbers in an array where all other numbers appear twice
pair<int, int> findTwoSingleNumbers(vector<int>& nums) {
    int xorResult = 0;
    for (int num : nums) {
        xorResult ^= num;
    }
    
    // Find any set bit in xorResult
    int rightmostSetBit = xorResult & -xorResult;
    
    int x = 0, y = 0;
    for (int num : nums) {
        if (num & rightmostSetBit) {
            x ^= num;
        } else {
            y ^= num;
        }
    }
    
    return {x, y};
}

// Generate all subsets of a set (power set)
vector<vector<int>> generateSubsets(vector<int>& nums) {
    int n = nums.size();
    vector<vector<int>> subsets;
    
    for (int i = 0; i < (1 << n); i++) {
        vector<int> subset;
        for (int j = 0; j < n; j++) {
            if (i & (1 << j)) {
                subset.push_back(nums[j]);
            }
        }
        subsets.push_back(subset);
    }
    
    return subsets;
}
```

# Dynamic Programming Patterns

## Memoization Template
```cpp
// Top-down DP with memoization
int solve(vector<int>& nums, int i, unordered_map<int, int>& memo) {
    // Base cases
    if (i >= nums.size()) return 0;
    
    // Check memo
    if (memo.find(i) != memo.end()) {
        return memo[i];
    }
    
    // Recursive case with memoization
    int result = max(nums[i] + solve(nums, i + 2, memo), solve(nums, i + 1, memo));
    memo[i] = result;
    
    return result;
}

// Usage
int rob(vector<int>& nums) {
    unordered_map<int, int> memo;
    return solve(nums, 0, memo);
}
```

## Tabulation Template
```cpp
// Bottom-up DP with tabulation
int robTabulation(vector<int>& nums) {
    int n = nums.size();
    if (n == 0) return 0;
    if (n == 1) return nums[0];
    
    vector<int> dp(n);
    dp[0] = nums[0];
    dp[1] = max(nums[0], nums[1]);
    
    for (int i = 2; i < n; i++) {
        dp[i] = max(dp[i - 1], dp[i - 2] + nums[i]);
    }
    
    return dp[n - 1];
}
```

## Space-Optimized DP
```cpp
// Space-optimized version of DP solution
int robOptimized(vector<int>& nums) {
    int n = nums.size();
    if (n == 0) return 0;
    if (n == 1) return nums[0];
    
    int prev2 = nums[0];
    int prev1 = max(nums[0], nums[1]);
    
    for (int i = 2; i < n; i++) {
        int current = max(prev1, prev2 + nums[i]);
        prev2 = prev1;
        prev1 = current;
    }
    
    return prev1;
}
```

# Advanced Techniques

## Sliding Window
```cpp
// Fixed-size sliding window
int maxSumFixedWindow(vector<int>& nums, int k) {
    int n = nums.size();
    if (n < k) return -1;
    
    int maxSum = 0;
    int windowSum = 0;
    
    // First window
    for (int i = 0; i < k; i++) {
        windowSum += nums[i];
    }
    
    maxSum = windowSum;
    
    // Slide window
    for (int i = k; i < n; i++) {
        windowSum = windowSum - nums[i - k] + nums[i];
        maxSum = max(maxSum, windowSum);
    }
    
    return maxSum;
}

// Variable-size sliding window
int longestSubarrayWithSumK(vector<int>& nums, int k) {
    int n = nums.size();
    int maxLength = 0;
    int sum = 0;
    int left = 0;
    
    for (int right = 0; right < n; right++) {
        sum += nums[right];
        
        while (left <= right && sum > k) {
            sum -= nums[left];
            left++;
        }
        
        if (sum == k) {
            maxLength = max(maxLength, right - left + 1);
        }
    }
    
    return maxLength;
}

// Sliding window with hash map for strings
int lengthOfLongestSubstringWithoutRepeating(string s) {
    int n = s.length();
    int maxLength = 0;
    unordered_map<char, int> charIndex;
    int left = 0;
    
    for (int right = 0; right < n; right++) {
        if (charIndex.find(s[right]) != charIndex.end()) {
            left = max(left, charIndex[s[right]] + 1);
        }
        
        charIndex[s[right]] = right;
        maxLength = max(maxLength, right - left + 1);
    }
    
    return maxLength;
}
```

## Two Pointers
```cpp
// Two pointers moving from both ends
bool isPalindrome(string s) {
    int left = 0;
    int right = s.length() - 1;
    
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    
    return true;
}

// Two pointers for sorted array problems
vector<int> twoSum(vector<int>& numbers, int target) {
    int left = 0;
    int right = numbers.size() - 1;
    
    while (left < right) {
        int sum = numbers[left] + numbers[right];
        if (sum == target) {
            return {left + 1, right + 1};  // 1-indexed result
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }
    
    return {};
}

// Fast and slow pointers for cycle detection
bool hasCycle(ListNode* head) {
    if (!head || !head->next) return false;
    
    ListNode* slow = head;
    ListNode* fast = head;
    
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
        
        if (slow == fast) {
            return true;
        }
    }
    
    return false;
}
```

## Monotonic Stack/Queue
```cpp
// Next greater element using monotonic stack
vector<int> nextGreaterElement(vector<int>& nums) {
    int n = nums.size();
    vector<int> result(n, -1);
    stack<int> s;  // indices
    
    for (int i = 0; i < n; i++) {
        while (!s.empty() && nums[s.top()] < nums[i]) {
            result[s.top()] = nums[i];
            s.pop();
        }
        s.push(i);
    }
    
    return result;
}

// Sliding window maximum using monotonic queue
vector<int> maxSlidingWindow(vector<int>& nums, int k) {
    vector<int> result;
    deque<int> dq;  // indices
    
    for (int i = 0; i < nums.size(); i++) {
        // Remove elements outside the window
        if (!dq.empty() && dq.front() == i - k) {
            dq.pop_front();
        }
        
        // Remove smaller elements that won't be useful
        while (!dq.empty() && nums[dq.back()] < nums[i]) {
            dq.pop_back();
        }
        
        dq.push_back(i);
        
        // Add to result once window is fully formed
        if (i >= k - 1) {
            result.push_back(nums[dq.front()]);
        }
    }
    
    return result;
}
```
