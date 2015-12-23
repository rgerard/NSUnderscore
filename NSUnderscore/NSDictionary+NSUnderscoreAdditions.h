//
//  NSUnderscore.h
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSUnderscoreAdditions)

/*
 * Iterates over a list of elements, yielding each in turn to an action function.
 */
- (void)each:(void(^)(id))action;

/*
 * Produces a new array of values by mapping each value in list through a transformation function (action).
 */
- (NSArray *)map:(id(^)(id))action;

/*
 * Reduce boils down a list of values into a single value. Each successive step of it should be returned by action.
 */
- (id)reduce:(id(^)(id, id))action;

/*
 * Looks through each value in the list, returning an array of all the values that pass a truth test
 */
- (NSArray *)filter:(bool(^)(id))action;

/*
 * Returns the values in list without the elements that the truth test (predicate) passes. The opposite of filter.
 */
- (NSArray *)reject:(bool(^)(id))action;

/*
 * Returns true if all of the values in the list pass the predicate truth test.
 */
- (BOOL)every:(BOOL(^)(id))action;

/*
 * Returns true if any of the values in the list pass the predicate truth test. Short-circuits and stops traversing the list if a true element is found.
 */
- (BOOL)some:(BOOL(^)(id))action;

/*
 * A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.
 */
- (NSArray *)pluck:(NSString *)propertyName;

/*
 * Returns the maximum value in list.
 */
- (id)max:(NSInteger(^)(id))action;

/*
 * Returns the minimum value in list.
 */
- (id)min:(NSInteger(^)(id))action;

/*
 * Splits a collection into sets, grouped by the result of running each value through action.
 */
- (NSDictionary *)groupBy:(id(^)(id))action;

/*
 * Given a list, and an action function that returns a key for each element in the list, returns an object with an index of each item.
 * Just like groupBy, but for when you know your keys are unique.
 */
- (NSDictionary *)indexBy:(id(^)(id))action;

/*
 * Sorts a list into groups and returns a count for the number of objects in each group.
 * Similar to groupBy, but instead of returning a list of values, returns a count for the number of values in that group.
 */
- (NSDictionary *)countBy:(id(^)(id))action;

/*
 * Split array into two arrays: one whose elements all satisfy action and one whose elements all do not satisfy action.
 */
- (NSArray *)partition:(BOOL(^)(id))action;

@end
