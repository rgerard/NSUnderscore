//
//  NSUnderscoreArrayTests.m
//  NSUnderscoreArrayTests
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NSUnderscore/NSArray+NSUnderscoreAdditions.h>

@interface NSUnderscoreArrayTests : XCTestCase

@end

@implementation NSUnderscoreArrayTests

- (void)testEachBasic {
    NSArray *objects = @[@(2), @(8)];
    __block NSInteger total = 0;
    [objects each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 10);
}

- (void)testEachWhenEmpty {
    NSArray *objects = @[];
    __block NSInteger total = 0;
    [objects each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 0);
}

- (void)testMap {
    NSArray *objects = @[@(2), @(3)];
    NSArray *multipliedArray = [objects map:(id)^(NSNumber *object) {
        return @(object.integerValue * 2);
    }];
    XCTAssert(multipliedArray.count == 2);
    NSNumber *modifiedValue = multipliedArray[0];
    XCTAssert(modifiedValue.integerValue == 4);
    modifiedValue = multipliedArray[1];
    XCTAssert(modifiedValue.integerValue == 6);
}

- (void)testMapWithInvalidBlock {
    NSArray *objects = @[@(2), @(3)];
    NSArray *multipliedArray = [objects map:(id)^(NSNumber *object) {
        return nil;
    }];
    XCTAssertNotNil(multipliedArray);
    XCTAssert(multipliedArray.count == 0);
}

- (void)testReduce {
    NSArray *objects = @[@(2), @(4)];
    NSNumber *reduced = [objects reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
        return @(object.integerValue + previousValue.integerValue);
    }];
    XCTAssert(reduced.integerValue == 6);
}

- (void)testFilter {
    NSArray *objects = @[@(2), @(4)];
    NSArray *modified = [objects filter:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 2);
}

- (void)testReject {
    NSArray *objects = @[@(2), @(4)];
    NSArray *modified = [objects reject:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 4);
}

- (void)testEveryValid {
    NSArray *objects = @[@(2), @(4)];
    BOOL every = [objects every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testEveryInvalid {
    NSArray *objects = @[@(2), @(-4)];
    BOOL every = [objects every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == NO);
}

- (void)testEveryWhenEmpty {
    NSArray *objects = @[];
    BOOL every = [objects every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testSomeValid {
    NSArray *objects = @[@(-2), @(4)];
    BOOL some = [objects some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == YES);
}

- (void)testSomeInvalid {
    NSArray *objects = @[@(2), @(4)];
    BOOL some = [objects some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}


- (void)testSomeWhenEmpty {
    NSArray *objects = @[];
    BOOL some = [objects some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}

- (void)testPluck {
    NSArray *objects = @[@{@"id": @(1)}, @{@"id": @(2)}];
    NSArray *plucked = [objects pluck:@"id"];
    XCTAssert(plucked.count == 2);
    XCTAssert([plucked containsObject:@(1)]);
    XCTAssert([plucked containsObject:@(2)]);
}

- (void)testPluckWithInvalidProperty {
    NSArray *objects = @[@{@"id": @(1)}, @{@"id": @(2)}];
    NSArray *plucked = [objects pluck:@"name"];
    XCTAssertNotNil(plucked);
    XCTAssert(plucked.count == 0);
}

- (void)testMax {
    NSArray *objects = @[@{@"id": @(10)}, @{@"id": @(20)}];
    NSDictionary *maxValue = [objects max:^NSInteger(NSDictionary *dict) {
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(maxValue);
    XCTAssert([[maxValue objectForKey:@"id"] integerValue] == 20);
}

- (void)testMaxEmpty {
    NSArray *objects = @[];
    id maxValue = [objects max:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(maxValue == nil);
}

- (void)testMin {
    NSArray *objects = @[@{@"id": @(10)}, @{@"id": @(20)}];
    NSDictionary *minValue = [objects min:^NSInteger(id val) {
        NSDictionary *dict = (NSDictionary *)val;
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(minValue);
    XCTAssert([[minValue objectForKey:@"id"] integerValue] == 10);
}

- (void)testMinEmpty {
    NSArray *objects = @[];
    id minValue = [objects min:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(minValue == nil);
}

- (void)testGroupBy {
    NSArray *objects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
    NSDictionary *groupedObjects = [objects groupBy:^id(NSDictionary *val) {
        NSString *token = [val objectForKey:@"token"];
        return [token substringToIndex:4];
    }];
    XCTAssertNotNil(groupedObjects);
    NSArray *groupOne = [groupedObjects objectForKey:@"ryan"];
    XCTAssert(groupOne.count == 2);
    NSArray *groupTwo = [groupedObjects objectForKey:@"test"];
    XCTAssert(groupTwo.count == 1);
}

- (void)testGroupByWithInvalidKey {
    NSArray *objects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
    NSDictionary *groupedObjects = [objects groupBy:^id(NSDictionary *val) {
        return nil;
    }];
    XCTAssertNotNil(groupedObjects);
    XCTAssert(groupedObjects.allKeys.count == 0);
}

- (void)testIndexBy {
    NSArray *objects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
    NSDictionary *indexedObjects = [objects indexBy:^id(NSDictionary *val) {
        return [val objectForKey:@"token"];
    }];
    XCTAssertNotNil(indexedObjects);
    NSArray *groupOne = [indexedObjects objectForKey:@"1"];
    XCTAssert(groupOne.count == 1);
    NSArray *groupTwo = [indexedObjects objectForKey:@"2"];
    XCTAssert(groupTwo.count == 1);
    NSArray *groupThree = [indexedObjects objectForKey:@"3"];
    XCTAssert(groupThree.count == 1);
}

- (void)testIndexByWithInvalidKey {
    NSArray *objects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
    NSDictionary *indexedObjects = [objects indexBy:^id(NSDictionary *val) {
        return nil;
    }];
    XCTAssertNotNil(indexedObjects);
    XCTAssert(indexedObjects.allKeys.count == 0);
}

- (void)testIndexByWithDuplicateKey {
    NSArray *objects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"1"}];
    XCTAssertThrows([objects indexBy:^id(NSDictionary *val) {
        return [val objectForKey:@"token"];
    }]);
}

- (void)testCountBy {
    NSArray *objects = @[@(1), @(2), @(3)];
    NSDictionary *countedObjects = [objects countBy:^id(NSNumber *val) {
        return val.integerValue % 2 == 0 ? @"even": @"odd";
    }];
    XCTAssertNotNil(countedObjects);
    NSNumber *countOne = [countedObjects objectForKey:@"even"];
    XCTAssertNotNil(countOne);
    XCTAssert(countOne.integerValue == 1);
    NSNumber *countTwo = [countedObjects objectForKey:@"odd"];
    XCTAssertNotNil(countTwo);
    XCTAssert(countTwo.integerValue == 2);
}

- (void)testCountByWithInvalidKey {
    NSArray *objects = @[@(1), @(2), @(3)];
    NSDictionary *countedObjects = [objects countBy:^id(NSNumber *val) {
        return nil;
    }];
    XCTAssertNotNil(countedObjects);
    XCTAssert(countedObjects.allKeys.count == 0);
}

- (void)testPartitionSuccessAndFail {
    NSArray *objects = @[@(1), @(2), @(3)];
    NSArray *result = [objects partition:^BOOL(NSNumber *object) {
        return object.integerValue % 2 == 0;
    }];
    XCTAssertNotNil(result);
    XCTAssert(result.count == 2);
    NSArray *passed = [result objectAtIndex:0];
    NSArray *failed = [result objectAtIndex:1];
    XCTAssert(passed.count == 1);
    XCTAssert(failed.count == 2);
}

- (void)testPartitionOnlySuccess {
    NSArray *objects = @[@(2), @(4), @(6)];
    NSArray *result = [objects partition:^BOOL(NSNumber *object) {
        return object.integerValue % 2 == 0;
    }];
    XCTAssertNotNil(result);
    XCTAssert(result.count == 2);
    NSArray *passed = [result objectAtIndex:0];
    NSArray *failed = [result objectAtIndex:1];
    XCTAssert(passed.count == 3);
    XCTAssert(failed.count == 0);
}

- (void)testPartitionOnlyFail {
    NSArray *objects = @[@(1), @(3), @(5)];
    NSArray *result = [objects partition:^BOOL(NSNumber *object) {
        return object.integerValue % 2 == 0;
    }];
    XCTAssertNotNil(result);
    XCTAssert(result.count == 2);
    NSArray *passed = [result objectAtIndex:0];
    NSArray *failed = [result objectAtIndex:1];
    XCTAssert(passed.count == 0);
    XCTAssert(failed.count == 3);
}

@end
