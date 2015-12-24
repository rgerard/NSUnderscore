# Introduction
NSUnderscore is a set of categories added to NSArray, NSDictionary, and NSSet. This project is an attempt to bring some of the useful functionality found in [Underscore.js](http://underscorejs.org/) to the world of iOS programming. Not every single function has been ported over, as some functions are already implemented on the collection objects.

## NSArray

Start by importing the category:

`#import <NSUnderscore/NSArray+NSUnderscoreAdditions.h>`

The following functions are available to you:

* **each**
  * Iterates over a list of elements, yielding each in turn to an action function.
  * Example:
  ```
  NSArray *objects = @[@(2), @(4)];
  __block NSInteger total = 0;
  [objects each:^(NSNumber *object) {
      total += object.integerValue;
  }];
  // Result: total == 6
  ```  

* **map**
  * Produces a new array of values by mapping each value in list through a transformation function (action).
  * Example:
  ```
  NSArray *objects = @[@(2), @(3)];
  NSArray *modifiedObjects = [objects map:(id)^(NSNumber *object) {
      return @(object.integerValue * 2);
  }];
  // Result: modifiedObjects == @[ @(4), @(6) ]
  ```

* **reduce**
  * Reduce boils down a list of values into a single value. Each successive step of it should be returned by action.
  * Example:
  ```
  NSArray *objects = @[@(2), @(4)];
  NSNumber *reduced = [objects reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
      return @(object.integerValue + previousValue.integerValue);
  }];
  // Result: reduced == @(6)
  ```  

* **filter**
  * Looks through each value in the list, returning an array of all the values that pass a truth test

* **reject**
  * Returns the values in list without the elements that the truth test (predicate) passes. The opposite of filter.

* **every**
  * Returns true if all of the values in the list pass the predicate truth test.

* **some**
  * Returns true if any of the values in the list pass the predicate truth test. Short-circuits and stops traversing the list if a true element is found.

* **pluck**
  * A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.

* **max**
  * Returns the maximum value in list.

* **min**
  * Returns the minimum value in list.

* **groupBy**
  * Splits a collection into sets, grouped by the result of running each value through action.
  * Example:
  ```
  NSArray *testObjects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
  NSDictionary *groupedObjects = [testObjects groupBy:^id(NSDictionary *val) {
      NSString *token = [val objectForKey:@"token"];
      return [token substringToIndex:4];
  }];
  // Result: @{ @"ryan": [@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}], @"test": [@{@"token": @"test-1"}] }
  ```

* **indexBy**
  * Given a list, and an action function that returns a key for each element in the list, returns an object with an index of each item.
  * Just like groupBy, but for when you know your keys are unique.
  * Example:
  ```
  NSArray *testObjects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
  NSDictionary *indexedObjects = [testObjects indexBy:^id(NSDictionary *val) {
     return [val objectForKey:@"token"];
  }];
  // Result: @{ @"1": @{@"token": @"1"}, @"2": @{@"token": @"ryan-2"}, @"3": @{@"token": @"3"}] }
  ```

* **countBy**
  * Sorts a list into groups and returns a count for the number of objects in each group. 
  * Similar to groupBy, but instead of returning a list of values, returns a count for the number of values in that group.
  * Example:
  ```
  NSArray *testObjects = @[@(1), @(2), @(3)];
  NSDictionary *countedObjects = [testObjects countBy:^id(NSNumber *val) {
    return val.integerValue % 2 == 0 ? @"even": @"odd";
  }];
  // Result: @{ @"even": 1, @"odd": 2 }
  ```

* **partition**
  * Split array into two arrays: one whose elements all satisfy action and one whose elements all do not satisfy action.
  * Example:
  ```
  NSArray *testObjects = @[@(1), @(2), @(3)];
  NSDictionary *indexedObjects = [testObjects partition:^BOOL(NSNumber *val) {
    return val.integerValue % 2 == 0;
  }];
  // Result: @[ @[ @(2) ], @[ @(1), @(3) ] ]
  ```
