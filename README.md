# Introduction
NSUnderscore is a set of categories added to NSArray, NSDictionary, and NSSet. This project is an attempt to bring some of the useful functionality found in [Underscore.js](http://underscorejs.org/) to the world of iOS programming. Not every single function has been ported over, as some functions are already implemented on the collection objects.

## NSArray

Start by importing the category:

`#import <NSUnderscore/NSArray+NSUnderscoreAdditions.h>`

The following functions are available to you:

* (void) each
  * Iterates over a list of elements, yielding each in turn to an action function.

* (NSArray *) map
  * Produces a new array of values by mapping each value in list through a transformation function (action).

* (id) reduce
  * Reduce boils down a list of values into a single value. Each successive step of it should be returned by action.

* (NSArray *) filter
  * Looks through each value in the list, returning an array of all the values that pass a truth test

* (NSArray *) reject
  * Returns the values in list without the elements that the truth test (predicate) passes. The opposite of filter.

* (BOOL) every
  * Returns true if all of the values in the list pass the predicate truth test.

* (BOOL) some
  * Returns true if any of the values in the list pass the predicate truth test. Short-circuits and stops traversing the list if a true element is found.

* (NSArray *) pluck
  * A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.

* (id) max
  * Returns the maximum value in list.

* (id) min
  * Returns the minimum value in list.

* (NSDictionary *) groupBy
  * Splits a collection into sets, grouped by the result of running each value through action.
  * For example:
  ```
  NSArray *testObjects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
  NSDictionary *groupedObjects = [testObjects groupBy:^id(NSDictionary *val) {
      NSString *token = [val objectForKey:@"token"];
      return [token substringToIndex:4];
  }];
  ```
  * Should produce the result: @{ @"ryan": [@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}], @"test": [@{@"token": @"test-1"}] }

* (NSDictionary *) indexBy
  * Given a list, and an action function that returns a key for each element in the list, returns an object with an index of each item.
  * Just like groupBy, but for when you know your keys are unique.
  * For example:
  ```
  NSArray *testObjects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
  NSDictionary *indexedObjects = [testObjects indexBy:^id(NSDictionary *val) {
     return [val objectForKey:@"token"];
  }];
  ```
  * Should produce the result: @{ @"1": @{@"token": @"1"}, @"2": @{@"token": @"ryan-2"}, @"3": @{@"token": @"3"}] }

* (NSDictionary *) countBy
  * Sorts a list into groups and returns a count for the number of objects in each group. 
  * Similar to groupBy, but instead of returning a list of values, returns a count for the number of values in that group.
  ```
  NSArray *testObjects = @[@(1), @(2), @(3)];
  NSDictionary *countedObjects = [testObjects countBy:^id(NSNumber *val) {
    return val.integerValue % 2 == 0 ? @"even": @"odd";
  }];
  ```
  * Should produce the result: @{ @"even": 1, @"odd": 2 }

* (NSArray *) partition
  * Split array into two arrays: one whose elements all satisfy action and one whose elements all do not satisfy action.
  * For example:
  ```
  NSArray *testObjects = @[@(1), @(2), @(3)];
  NSDictionary *indexedObjects = [testObjects partition:^BOOL(NSNumber *val) {
    return val.integerValue % 2 == 0;
  }];
  ```
  * Should produce the result: @[ @[ @(2) ], @[ @(1), @(3) ] ]