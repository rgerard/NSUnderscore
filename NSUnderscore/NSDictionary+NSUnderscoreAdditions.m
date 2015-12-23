//
//  NSUnderscore.m
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import "NSDictionary+NSUnderscoreAdditions.h"

@implementation NSDictionary (NSUnderscoreAdditions)

- (void)each:(void(^)(id object))action;
{
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        action(obj);
    }];
}

- (NSArray *)map:(id(^)(id object))action;
{
    __block NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id result = action(obj);
        [mutatedArray addObject:result];
    }];
    
    return mutatedArray;
}

- (id)reduce:(id(^)(id object, id previousObject))action;
{
    __block id reducedValue = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        if (!reducedValue) {
            reducedValue = element;
        } else {
            reducedValue = action(element, reducedValue);
        }
    }];
    
    return reducedValue;
}

- (NSArray *)filter:(bool(^)(id object))action;
{
    __block NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        if (action(element)) {
            [filteredArray addObject:element];
        }
    }];
    
    return filteredArray;
}

- (NSArray *)reject:(bool(^)(id))action;
{
    __block NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        if (!action(element)) {
            [filteredArray addObject:element];
        }
    }];
    
    return filteredArray;
}

- (BOOL)every:(BOOL(^)(id object))action;
{
    for(id key in self) {
        id element = [self objectForKey:key];
        if (!action(element)) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)some:(BOOL(^)(id object))action;
{
    for(id key in self) {
        id element = [self objectForKey:key];
        if (action(element)) {
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *)pluck:(NSString *)propertyName;
{
    __block NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        id result = [element valueForKey:propertyName];
        [mutatedArray addObject:result];
    }];
    
    return mutatedArray;
}

- (id)max:(NSInteger(^)(id))action;
{
    __block id objectWithMaxValue = nil;
    __block NSInteger maxValue = NSIntegerMin;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        NSInteger tmpValue = action(element);
        if (tmpValue > maxValue) {
            objectWithMaxValue = element;
            maxValue = tmpValue;
        }
    }];
    
    return objectWithMaxValue;
}

- (id)min:(NSInteger(^)(id))action;
{
    __block id objectWithMinValue = nil;
    __block NSInteger minValue = NSIntegerMax;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        NSInteger tmpValue = action(element);
        if (tmpValue < minValue) {
            objectWithMinValue = element;
            minValue = tmpValue;
        }
    }];
    
    return objectWithMinValue;
}

- (NSDictionary *)groupBy:(id(^)(id))action;
{
    __block NSMutableDictionary *groupedObjects = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        id resultKey = action(element);
        
        NSMutableArray *existingGroup = [groupedObjects objectForKey:resultKey];
        if (!existingGroup) {
            existingGroup = [NSMutableArray array];
        }
        [existingGroup addObject:element];
        [groupedObjects setObject:existingGroup forKey:resultKey];
    }];
    
    return groupedObjects;
}

- (NSDictionary *)indexBy:(id(^)(id))action;
{
    __block NSMutableDictionary *indexedObjects = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        id resultKey = action(element);
        if ([indexedObjects objectForKey:resultKey] != nil) {
            [NSException raise:@"Duplicate Key" format:@"The key %@ is a duplicate", resultKey];
        }
        [indexedObjects setObject:element forKey:resultKey];
    }];
    
    return indexedObjects;
}

- (NSDictionary *)countBy:(id(^)(id))action;
{
    __block NSMutableDictionary *countedObjects = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        id resultKey = action(element);
        
        NSNumber *existingCount = [countedObjects objectForKey:resultKey];
        if (!existingCount) {
            existingCount = @(0);
        }
        existingCount = @(existingCount.integerValue + 1);
        [countedObjects setObject:existingCount forKey:resultKey];
    }];
    
    return countedObjects;
}

- (NSArray *)partition:(BOOL(^)(id))action;
{
    __block NSMutableArray *passed = [NSMutableArray array];
    __block NSMutableArray *failed = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        if (action(element)) {
            [passed addObject:element];
        } else {
            [failed addObject:element];
        }
    }];
    
    return @[passed, failed];
}

@end
