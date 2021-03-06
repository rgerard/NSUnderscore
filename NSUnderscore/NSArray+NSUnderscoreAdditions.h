//
//  NSUnderscore.h
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSUnderscoreAdditions)

/* 
 * Iterates over a list of elements, yielding each in turn to an action function.
 * Example:
 * NSArray *objects = @[@(2), @(4)];
 * __block NSInteger total = 0;
 * [objects each:^(NSNumber *object) {
 *   total += object.integerValue;
 * }];
 * Result: total == 6
 */
- (void)each:(void(^)(id))action;

/*
 * Produces a new array of values by mapping each value in list through a transformation function (action).
 * Example:
 * NSArray *objects = @[@(2), @(3)];
 * NSArray *modifiedObjects = [objects map:(id)^(NSNumber *object) {
 *   return @(object.integerValue * 2);
 * }];
 * Result: modifiedObjects == @[ @(4), @(6) ]
 */
- (NSArray *)map:(id(^)(id))action;

/* 
 * Reduce boils down a list of values into a single value. Each successive step of it should be returned by action.
 * Example:
 * NSArray *objects = @[@(2), @(4)];
 * NSNumber *reduced = [objects reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
 *   return @(object.integerValue + previousValue.integerValue);
 * }];
 * Result: reduced == @(6)
 */
- (id)reduce:(id(^)(id, id))action;

/*
 * Looks through each value in the list, returning an array of all the values that pass a truth test
 * Example:
 * NSArray *objects = @[@(2), @(4)];
 * NSArray *filtered = [objects filter:(id)^(NSNumber *object) {
 *   return object.integerValue == 2;
 * }];
 * Result: filtered == @[ @(2) ]
 */
- (NSArray *)filter:(bool(^)(id))action;

/*
 * Returns the values in list without the elements that the truth test (predicate) passes. The opposite of filter.
 * Example: 
 * NSArray *objects = @[@(2), @(4)];
 * NSArray *filtered = [objects reject:(id)^(NSNumber *object) {
 *   return object.integerValue == 2;
 * }];
 * Result: filtered == @[ @(5) ]
 */
- (NSArray *)reject:(bool(^)(id))action;

/*
 * Returns true if all of the values in the list pass the predicate truth test.
 * Example:
 * NSArray *objects = @[@(2), @(4)];
 * BOOL result = [objects every:^BOOL(NSNumber *object) {
 *   return object.integerValue > 0;
 * }];
 * Result: result == YES
 */
- (BOOL)every:(BOOL(^)(id))action;

/*
 * Returns true if any of the values in the list pass the predicate truth test. Short-circuits and stops traversing the list if a true element is found.
 * Example:
 * NSArray *objects = @[@(-2), @(4)];
 * BOOL result = [objects some:^BOOL(NSNumber *object) {
 *   return object.integerValue < 0;
 * }];
 * Result: result == YES
 */
- (BOOL)some:(BOOL(^)(id))action;

/*
 * A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.
 * Example:
 * NSArray *objects = @[@{@"id": @(1)}, @{@"id": @(2)}];
 * NSArray *plucked = [objects pluck:@"id"];
 * Result: plucked == [ @(1), @(2) ]
 */
- (NSArray *)pluck:(NSString *)propertyName;

/*
 * Returns the maximum value in list.
 * Example:
 * NSArray *objects = @[@{@"id": @(10)}, @{@"id": @(20)}];
 * NSDictionary *maxValue = [objects max:^NSInteger(NSDictionary *dict) {
 *   NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
 *   return dictVal.integerValue;
 * }];
 * Result: maxValue == @{@"id": @(20)}
 */
- (id)max:(NSInteger(^)(id))action;

/*
 * Returns the minimum value in list.
 * Example:
 * NSArray *objects = @[@{@"id": @(10)}, @{@"id": @(20)}];
 * NSDictionary *minValue = [objects max:^NSInteger(NSDictionary *dict) {
 *   NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
 *   return dictVal.integerValue;
 * }];
 * Result: minValue == @{@"id": @(10)}
 */
- (id)min:(NSInteger(^)(id))action;

/*
 * Splits a collection into sets, grouped by the result of running each value through action.
 * Example:
 *  NSArray *objects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
 *  NSDictionary *groupedObjects = [objects groupBy:^id(NSDictionary *val) {
 *      NSString *token = [val objectForKey:@"token"];
 *      return [token substringToIndex:4];
 *  }];
 *  groupedObjects is: @{ @"ryan": [@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}], @"test": [@{@"token": @"test-1"}] }
 */
- (NSDictionary *)groupBy:(id(^)(id))action;

/*
 * Given a list, and an action function that returns a key for each element in the list, returns an object with an index of each item.
 * Just like groupBy, but for when you know your keys are unique.
 * Example:
 *  NSArray *objects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
 *  NSDictionary *indexedObjects = [objects indexBy:^id(NSDictionary *val) {
 *      return [val objectForKey:@"token"];
 *  }];
 *  indexedObjects is: @{ @"1": @{@"token": @"1"}, @"2": @{@"token": @"ryan-2"}, @"3": @{@"token": @"3"}] }
 */
- (NSDictionary *)indexBy:(id(^)(id))action;

/*
 * Sorts a list into groups and returns a count for the number of objects in each group. 
 * Similar to groupBy, but instead of returning a list of values, returns a count for the number of values in that group.
 * Example:
 *  NSArray *objects = @[@(1), @(2), @(3)];
 *  NSDictionary *countedObjects = [objects countBy:^id(NSNumber *val) {
 *      return val.integerValue % 2 == 0 ? @"even": @"odd";
 *  }];
 *  countedObjects is: @{ @"even": 1, @"odd": 2 }
 */
- (NSDictionary *)countBy:(id(^)(id))action;

/*
 * Split array into two arrays: one whose elements all satisfy action and one whose elements all do not satisfy action.
 * Example:
 *  NSArray *objects = @[@(1), @(2), @(3)];
 *  NSDictionary *partitionedObjects = [objects partition:^BOOL(NSNumber *val) {
 *      return val.integerValue % 2 == 0;
 *  }];
 *  partitionedObjects is: @[ @[ @(2) ], @[ @(1), @(3) ] ]
 */
- (NSArray *)partition:(BOOL(^)(id))action;

@end
