//
//  NSUnderscore.m
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import "NSArray+NSUnderscoreAdditions.h"

@implementation NSArray (NSUnderscoreAdditions)

- (void)each:(void(^)(id object))action;
{
    for(id element in self) {
        action(element);
    }
}

- (NSArray *)map:(id(^)(id object))action;
{
    NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id element in self) {
        id result = action(element);
        if (result) {
            [mutatedArray addObject:result];
        }
    }
    
    return mutatedArray;
}

- (id)reduce:(id(^)(id object, id previousObject))action;
{
    id reducedValue = nil;
    for(id element in self) {
        if (!reducedValue) {
            reducedValue = element;
        } else {
            reducedValue = action(element, reducedValue);
        }
    }
    
    return reducedValue;
}

- (NSArray *)filter:(bool(^)(id object))action;
{
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id element in self) {
        if (action(element)) {
            [filteredArray addObject:element];
        }
    }
    
    return filteredArray;
}

- (NSArray *)reject:(bool(^)(id))action;
{
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id element in self) {
        if (!action(element)) {
            [filteredArray addObject:element];
        }
    }
    
    return filteredArray;
}

- (BOOL)every:(BOOL(^)(id object))action;
{
    for(id element in self) {
        if (!action(element)) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)some:(BOOL(^)(id object))action;
{
    for(id element in self) {
        if (action(element)) {
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *)pluck:(NSString *)propertyName;
{
    NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id element in self) {
        id result = [element valueForKey:propertyName];
        if (result) {
            [mutatedArray addObject:result];
        }
    }
    
    return mutatedArray;
}

- (id)max:(NSInteger(^)(id))action;
{
    id objectWithMaxValue = nil;
    NSInteger maxValue = NSIntegerMin;
    for(id element in self) {
        NSInteger tmpValue = action(element);
        if (tmpValue > maxValue) {
            objectWithMaxValue = element;
            maxValue = tmpValue;
        }
    }
    
    return objectWithMaxValue;
}

- (id)min:(NSInteger(^)(id))action;
{
    id objectWithMinValue = nil;
    NSInteger minValue = NSIntegerMax;
    for(id element in self) {
        NSInteger tmpValue = action(element);
        if (tmpValue < minValue) {
            objectWithMinValue = element;
            minValue = tmpValue;
        }
    }
    
    return objectWithMinValue;
}

- (NSDictionary *)groupBy:(id(^)(id))action;
{
    NSMutableDictionary *groupedObjects = [NSMutableDictionary dictionary];
    for(id element in self) {
        id resultKey = action(element);
        if (!resultKey) {
            continue;
        }
        
        NSMutableArray *existingGroup = [groupedObjects objectForKey:resultKey];
        if (!existingGroup) {
            existingGroup = [NSMutableArray array];
        }
        [existingGroup addObject:element];
        [groupedObjects setObject:existingGroup forKey:resultKey];
    }
    
    return groupedObjects;
}

- (NSDictionary *)indexBy:(id(^)(id))action;
{
    NSMutableDictionary *indexedObjects = [NSMutableDictionary dictionary];
    for(id element in self) {
        id resultKey = action(element);
        if (!resultKey) {
            continue;
        }
        
        if ([indexedObjects objectForKey:resultKey] != nil) {
            [NSException raise:@"Duplicate Key" format:@"The key %@ is a duplicate", resultKey];
        }
        [indexedObjects setObject:element forKey:resultKey];
    }
    
    return indexedObjects;
}

- (NSDictionary *)countBy:(id(^)(id))action;
{
    NSMutableDictionary *countedObjects = [NSMutableDictionary dictionary];
    for(id element in self) {
        id resultKey = action(element);
        if (!resultKey) {
            continue;
        }
        
        NSNumber *existingCount = [countedObjects objectForKey:resultKey];
        if (!existingCount) {
            existingCount = @(0);
        }
        existingCount = @(existingCount.integerValue + 1);
        [countedObjects setObject:existingCount forKey:resultKey];
    }
    
    return countedObjects;
}

- (NSArray *)partition:(BOOL(^)(id))action;
{
    NSMutableArray *passed = [NSMutableArray array];
    NSMutableArray *failed = [NSMutableArray array];
    for(id element in self) {
        if (action(element)) {
            [passed addObject:element];
        } else {
            [failed addObject:element];
        }
    }
    
    return @[passed, failed];
}

@end
