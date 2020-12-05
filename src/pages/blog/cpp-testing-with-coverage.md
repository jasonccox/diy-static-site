---
pagetitle: Basic C++ Unit Testing with Coverage Using Catch2 and Gcov
---

# Basic C++ Unit Testing with Coverage Using Catch2 and Gcov

<div class="text-center">*[Last updated October 14, 2019]*</div>

I recently wrote a basic C++ linked list implementation to sharpen my skills, and I quickly found myself in need of a good way to test my code. I found [Catch2](https://github.com/catchorg/Catch2?target=_blank), a simple C++ testing framework, and then used [Gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html?target=_blank) to ensure that my tests were covering all the code. By no means am I an expert, but I'll go ahead and share what I've learned so far.

Here's the code we'll be testing in this example:

```cpp
// adds a value to the end of the list
void add(const T& value) {
    if (head == nullptr) {
        head = new Node<T>(value);
    } else {
        getNode(len - 1)->next = new Node<T>(value);
    }

    len++;
};
```

> If you want to actually compile and run this example, you'll need the `LinkedList.h` (which contains the `add` method) and `Node.h` files from [this repo](https://github.com/jasonccox/cpp-linked-list?target=_blank).

The `add` method is fairly simple and needs two basic tests: calling `add` on an empty list, and calling `add` on a non-empty list. Let's take a look at how to write those tests with Catch2.

## Setting up Catch2

First we need to set up Catch2. The easiest way to get it is by downloading the [single header file version](https://raw.githubusercontent.com/catchorg/Catch2/master/single_include/catch2/catch.hpp?target=_blank). Then you'll need to create a `.cpp` file containing the following code:

```cpp
#define CATCH_CONFIG_MAIN
#include "catch.hpp"
```

This file is essentially the `main` file for running your tests, and I'll save it as `catch-runner.cpp` for our example. The `#define` statement indicates that Catch2 should provide a main function with which to run the tests (this statement must only appear in one file); the `#include` statement references the header file containing the Catch2 code. You can put tests inside this file if you want, but [it's recommended](https://github.com/catchorg/Catch2/blob/master/docs/tutorial.md?target=_blank#scaling-up) that you put them in a separate file instead.

## Writing the Tests

At the most basic level, Catch2 provides a `REQUIRE` macro to assert the results of your code. For example,
```cpp
REQUIRE(list.length() == 1)
```

If a `REQUIRE` statement evaluates to false, the test will fail and the offending values will be printed out. Note that although the `REQUIRE` macro takes a statement that evaluates to a boolean value, it is able to expand that statement to show you what the failing values were. For example, if `list.length()` were actually 2, Catch2 would output something like the following:
```
Test.cpp:5: FAILED:
    REQUIRE(list.length() == 1)
with expansion:
    2 == 1
```

`REQUIRE` statements are the key piece of creating tests, but Catch2 also provides several other macros to structure the tests. The `SCENARIO` macro provides a top-level description of a test case. The `GIVEN` macro allows you to set up the conditions needed for the test, and the `WHEN` macro is used to execute the code under test. Finally, the `THEN` macro typically contains one or more `REQUIRE` statements to assert that everything went as planned.

> Catch2 provides more generic `TEST_CASE` and `SECTION` macros if that's what you prefer. Read more about any of the macros [here](https://github.com/catchorg/Catch2/blob/master/docs/test-cases-and-sections.md?target=_blank#top).

The following example file for testing our `add` method should make things a bit clearer:
```cpp
#include "catch.hpp"
#include "LinkedList.h"

SCENARIO("elements can be added to the end of a LinkedList", "[linkedlist]") {
    GIVEN("an empty LinkedList") {
        LinkedList<int> list;

        WHEN("an element is added") {
            list.add(4);

            THEN("the length increases by 1") {
                REQUIRE(list.length() == 1);
            }

            THEN("the element is added at index 0") {
                REQUIRE(list.get(0) == 4);
            }
        }
    }
}
```

Importantly, each `THEN` block is run in isolation. In other words, any code inside the enclosing `SCENARIO`, `GIVEN`, and `WHEN` blocks is executed separately for each `THEN` block. So the above code runs two tests: first, it creates a `LinkedList<int>`, adds a 4 to it, and asserts that the list contains 1 element; then it creates a new `LinkedList<int>`, adds a 4 to it, and asserts that the first element of the list is 4.

Using these macros also allows Catch2 to provide human-readable descriptions of the tests being run. For example, the first `THEN` block in the above code would be reported as follows:
```
Scenario: elements can be added to the end of a LinkedList
    Given: an empty LinkedList
     When: an element is added
     Then: the length increases by 1
```

> Wondering about the `"[linkedlist]"` argument to the `SCENARIO` macro? It's a tag. Tags allow you to group test cases and specify which ones to run. Read more [here](https://github.com/catchorg/Catch2/blob/master/docs/test-cases-and-sections.md?target=_blank#tags).

At this point we've tested the `add` method on an empty list. Now we just need to test it on a non-empty list. We can do so by adding another `GIVEN` block inside our `SCENARIO` block:
```cpp
#include "catch.hpp"
#include "LinkedList.h"

SCENARIO("elements can be added to the end of a LinkedList", "[linkedlist]") {
    GIVEN("an empty LinkedList") {
        LinkedList<int> list;

        WHEN("an element is added") {
            list.add(4);

            THEN("the length increases by 1") {
                REQUIRE(list.length() == 1);
            }

            THEN("the element is added at index 0") {
                REQUIRE(list.get(0) == 4);
            }
        }
    }
    
    GIVEN("a non-empty LinkedList") {
        LinkedList<int> list;
        list.add(3);
        list.add(7);
        list.add(2);
        int oldLen = list.length();

        WHEN("an element is added") {
            list.add(5);

            THEN("the length increases by 1") {
                REQUIRE(list.length() == oldLen + 1);
            }

            THEN("it is added to the end of the list") {
                REQUIRE(list.get(oldLen) == 5);
            }

            THEN("the rest of the list remains the same") {
                REQUIRE(list.get(0) == 3);
                REQUIRE(list.get(1) == 7);
                REQUIRE(list.get(2) == 2);
            }
        }
    }
}
```

## Running the Tests

Now we can save this file and compile everything. For the sake of this example, I'll just call the file `Test.cpp`. In order to generate a coverage report later with Gcov, we'll use g++ to compile everything as follows: 
```bash
$ g++ -o test-runner Test.cpp catch-runner.cpp
```

To run the tests, simply run the `test-runner` executable:
```bash
$ ./test-runner
```

And there you have it! The `add` method now has working unit tests.

## Checking Test Coverage with Gcov

In order to ensure that our tests are adequate, we need to get a test coverage report with [Gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html?target=_blank). The first step is to re-compile the test runner with the `--coverage` flag:
```bash
$ g++ -o test-runner Test.cpp catch-runner.cpp --coverage
```

Then, run the tests:
```bash
$ ./test-runner
```

Finally, run Gcov, giving it the name of the `.cpp` file(s) containing the tests:
```bash
$ gcov Test.cpp
```

This will output a basic report of the test coverage:
```
File 'Test.cpp'
Lines executed:100.00% of 26
Creating 'Test.cpp.gcov'

File 'catch.hpp'
Lines executed:86.67% of 45
Creating 'catch.hpp.gcov'

File 'LinkedList.h'
Lines executed:95.83% of 24
Creating 'LinkedList.h.gcov'

File 'Node.h'
Lines executed:100.00% of 1
Creating 'Node.h.gcov'

File '/usr/include/c++/9.2.0/bits/basic_string.h'
No executable lines
Removing 'basic_string.h.gcov'
```

If you want to see exactly which lines of a file were covered, open the corresponding `.gcov` file in a text editor. In this report, each line is preceded by the execution count, or `-` if the line contains no executable code. A count of `#####` indicates that the line was not executed. Here's what the `add` method looks like in `LinkedList.h.gcov`:

```
14:   63:    void add(const T& value) {
14:   64:        if (head == nullptr) {
 5:   65:            head = new Node<T>(value);
 -:   66:        } else {
 9:   67:            getNode(len - 1)->next = new Node<T>(value);
 -:   68:        }
 -:   69:
14:   70:        len++;
14:   71:    };
```

> You may notice that many lines that appear to be executable are marked with a `-` in `LinkedList.h.gcov` (such as the entire `remove` method). That's because Gcov is claiming that after linking the binary, there was no chance of executing them (for example, because the method they're in never got called in the tests). There's a [Stack Overflow post](https://stackoverflow.com/questions/24321099/why-does-gcov-report-in-class-function-definitions-as-not-executable?target=_blank) with a bit more info if you want to check it out.

Well, that's it! This is just a basic example of [Catch2](https://github.com/catchorg/Catch2?target=_blank) and [Gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html?target=_blank) -- both are powerful tools capable of much more than I've shown here, but hopefully this is enough to help you get started.
