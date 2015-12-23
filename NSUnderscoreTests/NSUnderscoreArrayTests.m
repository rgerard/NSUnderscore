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
    NSArray *test = @[@(2), @(8)];
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 10);
}

- (void)testEachWhenEmpty {
    NSArray *test = @[];
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 0);
}

- (void)testMap {
    NSArray *test = @[@(2), @(3)];
    NSArray *multipliedArray = [test map:(id)^(NSNumber *object) {
        return @(object.integerValue * 2);
    }];
    XCTAssert(multipliedArray.count == 2);
    NSNumber *modifiedValue = multipliedArray[0];
    XCTAssert(modifiedValue.integerValue == 4);
    modifiedValue = multipliedArray[1];
    XCTAssert(modifiedValue.integerValue == 6);
}

- (void)testReduce {
    NSArray *test = @[@(2), @(4)];
    NSNumber *reduced = [test reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
        return @(object.integerValue + previousValue.integerValue);
    }];
    XCTAssert(reduced.integerValue == 6);
}

- (void)testFilter {
    NSArray *test = @[@(2), @(4)];
    NSArray *modified = [test filter:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 2);
}

- (void)testReject {
    NSArray *test = @[@(2), @(4)];
    NSArray *modified = [test reject:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 4);
}

- (void)testEveryValid {
    NSArray *test = @[@(2), @(4)];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testEveryInvalid {
    NSArray *test = @[@(2), @(-4)];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == NO);
}

- (void)testEveryWhenEmpty {
    NSArray *test = @[];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testSomeValid {
    NSArray *test = @[@(-2), @(4)];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == YES);
}

- (void)testSomeInvalid {
    NSArray *test = @[@(2), @(4)];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}


- (void)testSomeWhenEmpty {
    NSArray *test = @[];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}

- (void)testPluck {
    NSArray *testObjects = @[@{@"id": @(1)}, @{@"id": @(2)}];
    NSArray *plucked = [testObjects pluck:@"id"];
    XCTAssert(plucked.count == 2);
    XCTAssert([plucked containsObject:@(1)]);
    XCTAssert([plucked containsObject:@(2)]);
}

- (void)testMax {
    NSArray *testObjects = @[@{@"id": @(10)}, @{@"id": @(20)}];
    NSDictionary *maxValue = [testObjects max:^NSInteger(id val) {
        NSDictionary *dict = (NSDictionary *)val;
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(maxValue);
    XCTAssert([[maxValue objectForKey:@"id"] integerValue] == 20);
}

- (void)testMaxEmpty {
    NSArray *testObjects = @[];
    id maxValue = [testObjects max:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(maxValue == nil);
}

- (void)testMin {
    NSArray *testObjects = @[@{@"id": @(10)}, @{@"id": @(20)}];
    NSDictionary *minValue = [testObjects min:^NSInteger(id val) {
        NSDictionary *dict = (NSDictionary *)val;
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(minValue);
    XCTAssert([[minValue objectForKey:@"id"] integerValue] == 10);
}

- (void)testMinEmpty {
    NSArray *testObjects = @[];
    id minValue = [testObjects min:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(minValue == nil);
}

- (void)testGroupBy {
    NSArray *testObjects = @[@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}];
    NSDictionary *groupedObjects = [testObjects groupBy:^id(NSDictionary *val) {
        NSString *token = [val objectForKey:@"token"];
        return [token substringToIndex:4];
    }];
    XCTAssertNotNil(groupedObjects);
    NSArray *groupOne = [groupedObjects objectForKey:@"ryan"];
    XCTAssert(groupOne.count == 2);
    NSArray *groupTwo = [groupedObjects objectForKey:@"test"];
    XCTAssert(groupTwo.count == 1);
}

- (void)testIndexBy {
    NSArray *testObjects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}];
    NSDictionary *indexedObjects = [testObjects indexBy:^id(NSDictionary *val) {
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

- (void)testIndexByWithDuplicateKey {
    NSArray *testObjects = @[@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"1"}];
    XCTAssertThrows([testObjects indexBy:^id(NSDictionary *val) {
        return [val objectForKey:@"token"];
    }]);
}

- (void)testCountBy {
    NSArray *testObjects = @[@(1), @(2), @(3)];
    NSDictionary *countedObjects = [testObjects countBy:^id(NSNumber *val) {
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

- (void)testPartitionSuccessAndFail {
    NSArray *test = @[@(1), @(2), @(3)];
    NSArray *result = [test partition:^BOOL(NSNumber *object) {
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
    NSArray *test = @[@(2), @(4), @(6)];
    NSArray *result = [test partition:^BOOL(NSNumber *object) {
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
    NSArray *test = @[@(1), @(3), @(5)];
    NSArray *result = [test partition:^BOOL(NSNumber *object) {
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
