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
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        action(element);
    }
}

- (NSArray *)map:(id(^)(id object))action;
{
    NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        id result = action(element);
        [mutatedArray addObject:result];
    }
    
    return mutatedArray;
}

- (id)reduce:(id(^)(id object, id previousObject))action;
{
    id reducedValue = nil;
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
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
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        if (action(element)) {
            [filteredArray addObject:element];
        }
    }
    
    return filteredArray;
}

- (BOOL)every:(BOOL(^)(id object))action;
{
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        if (!action(element)) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)some:(BOOL(^)(id object))action;
{
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        if (action(element)) {
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *)pluck:(NSString *)propertyName;
{
    NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        id result = [element valueForKey:propertyName];
        [mutatedArray addObject:result];
    }
    
    return mutatedArray;
}

@end
