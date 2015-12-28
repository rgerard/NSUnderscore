//
//  NSUnderscoreArrayTests.m
//  NSUnderscoreArrayTests
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NSUnderscore/NSSet+NSUnderscoreAdditions.h>

@interface NSUnderscoreSetTests : XCTestCase

@end

@implementation NSUnderscoreSetTests

- (void)testEachBasic {
    NSSet *test = [NSSet setWithObjects:@(2), @(8), nil];
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 10);
}

- (void)testEachWhenEmpty {
    NSSet *test = [NSSet set];
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 0);
}

- (void)testMap {
    NSSet *test = [NSSet setWithObjects:@(2), @(3), nil];
    NSArray *multipliedArray = [test map:(id)^(NSNumber *object) {
        return @(object.integerValue * 2);
    }];
    XCTAssert(multipliedArray.count == 2);
    NSNumber *modifiedValue = multipliedArray[0];
    XCTAssert(modifiedValue.integerValue == 4 || modifiedValue.integerValue == 6);
    modifiedValue = multipliedArray[1];
    XCTAssert(modifiedValue.integerValue == 4 || modifiedValue.integerValue == 6);
}

- (void)testReduce {
    NSSet *test = [NSSet setWithObjects:@(2), @(4), nil];
    NSNumber *reduced = [test reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
        return @(object.integerValue + previousValue.integerValue);
    }];
    XCTAssert(reduced.integerValue == 6);
}

- (void)testFilter {
    NSSet *test = [NSSet setWithObjects:@(2), @(4), nil];
    NSArray *modified = [test filter:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 2);
}

- (void)testReject {
    NSSet *test = [NSSet setWithObjects:@(2), @(4), nil];
    NSArray *modified = [test reject:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 4);
}

- (void)testEveryValid {
    NSSet *test = [NSSet setWithObjects:@(2), @(4), nil];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testEveryInvalid {
    NSSet *test = [NSSet setWithObjects:@(2), @(-4), nil];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == NO);
}

- (void)testEveryWhenEmpty {
    NSSet *test = [NSSet set];
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testSomeValid {
    NSSet *test = @[@(-2), @(4)];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == YES);
}

- (void)testSomeInvalid {
    NSSet *test = [NSSet setWithObjects:@(2), @(4), nil];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}


- (void)testSomeWhenEmpty {
    NSSet *test = [NSSet set];
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}

- (void)testPluck {
    NSSet *testObjects = [NSSet setWithObjects:@{@"id": @(1)}, @{@"id": @(2)}, nil];
    NSArray *plucked = [testObjects pluck:@"id"];
    XCTAssert(plucked.count == 2);
    XCTAssert([plucked containsObject:@(1)]);
    XCTAssert([plucked containsObject:@(2)]);
}

- (void)testMax {
    NSSet *testObjects = [NSSet setWithObjects:@{@"id": @(10)}, @{@"id": @(20)}, nil];
    NSDictionary *maxValue = [testObjects max:^NSInteger(id val) {
        NSDictionary *dict = (NSDictionary *)val;
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(maxValue);
    XCTAssert([[maxValue objectForKey:@"id"] integerValue] == 20);
}

- (void)testMaxEmpty {
    NSSet *testObjects = [NSSet set];
    id maxValue = [testObjects max:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(maxValue == nil);
}

- (void)testMin {
    NSSet *testObjects = [NSSet setWithObjects:@{@"id": @(10)}, @{@"id": @(20)}, nil];
    NSDictionary *minValue = [testObjects min:^NSInteger(id val) {
        NSDictionary *dict = (NSDictionary *)val;
        NSNumber *dictVal = (NSNumber *)[dict objectForKey:@"id"];
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(minValue);
    XCTAssert([[minValue objectForKey:@"id"] integerValue] == 10);
}

- (void)testMinEmpty {
    NSSet *testObjects = [NSSet set];
    id minValue = [testObjects min:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(minValue == nil);
}

- (void)testGroupBy {
    NSSet *testObjects = [NSSet setWithObjects:@{@"token": @"ryan-1"}, @{@"token": @"ryan-2"}, @{@"token": @"test-1"}, nil];
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
    NSSet *testObjects = [NSSet setWithObjects:@{@"token": @"1"}, @{@"token": @"2"}, @{@"token": @"3"}, nil];
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

- (void)testCountBy {
    NSSet *testObjects = [NSSet setWithObjects:@(1), @(2), @(3), nil];
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
    NSSet *test = [NSSet setWithObjects:@(1), @(2), @(3), nil];
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
    NSSet *test = [NSSet setWithObjects:@(2), @(4), @(6), nil];
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
    NSSet *test = [NSSet setWithObjects:@(1), @(3), @(5), nil];
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
