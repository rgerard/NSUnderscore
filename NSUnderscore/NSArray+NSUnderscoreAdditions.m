//
//  NSUnderscore.m
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import "NSArray+NSUnderscoreAdditions.h"

@implementation NSArray (NSUnderscoreAdditions)

- (void)each:(void(^)(NSUInteger, id))action;
{
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        action(i, element);
    }
}

- (NSArray *)map:(id(^)(NSUInteger index, id object))action;
{
    NSMutableArray *mutatedArray = [NSMutableArray arrayWithCapacity:self.count];
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        id result = action(i, element);
        [mutatedArray addObject:result];
    }
    
    return mutatedArray;
}

- (NSArray *)filter:(bool(^)(NSUInteger, id))action;
{
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        if (action(i, element)) {
            [filteredArray addObject:element];
        }
    }
    
    return filteredArray;
}

- (id)reduce:(id(^)(NSUInteger, id, id))action;
{
    id reducedValue = nil;
    for(int i=0; i < self.count; i++) {
        id element = [self objectAtIndex:i];
        if (!reducedValue) {
            reducedValue = element;
        } else {
            reducedValue = action(i, element, reducedValue);
        }
    }
    
    return reducedValue;
}

@end
