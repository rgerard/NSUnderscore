//
//  NSUnderscore.h
//  NSUnderscore
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSUnderscoreAdditions)

- (void)each:(void(^)(NSUInteger, id))action;
- (NSArray *)map:(id(^)(NSUInteger, id))action;
- (NSArray *)filter:(bool(^)(NSUInteger, id))action;
- (id)reduce:(id(^)(NSUInteger, id, id))action;

@end
