//
//  NSUnderscoreDictionaryTests.m
//  NSUnderscoreDictionaryTests
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NSUnderscore/NSDictionary+NSUnderscoreAdditions.h>

@interface NSUnderscoreDictionaryTests : XCTestCase

@end

@implementation NSUnderscoreDictionaryTests

- (void)testEachBasic {
    NSDictionary *test = @{ @"one": @(1), @"two": @(2) };
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 3);
}

- (void)testEachWhenEmpty {
    NSDictionary *test = @{};
    __block NSInteger total = 0;
    [test each:^(NSNumber *object) {
        total += object.integerValue;
    }];
    XCTAssert(total == 0);
}

- (void)testMap {
    NSDictionary *test = @{ @"one": @(2), @"two": @(3) };
    NSArray *multipliedArray = [test map:(id)^(NSNumber *object) {
        return @(object.integerValue * 2);
    }];
    XCTAssert(multipliedArray.count == 2);
    NSNumber *modifiedValue = multipliedArray[0];
    XCTAssert(modifiedValue.integerValue == 4);
    modifiedValue = multipliedArray[1];
    XCTAssert(modifiedValue.integerValue == 6);
}

- (void)testMapWithInvalidBlock {
    NSDictionary *test = @{ @"one": @(2), @"two": @(3) };
    NSArray *multipliedArray = [test map:(id)^(NSNumber *object) {
        return nil;
    }];
    XCTAssertNotNil(multipliedArray);
    XCTAssert(multipliedArray.count == 0);
}

- (void)testReduce {
    NSDictionary *test = @{ @"one": @(4), @"two": @(6) };
    NSNumber *reduced = [test reduce:(id)^(NSNumber *object, NSNumber *previousValue) {
        return @(object.integerValue + previousValue.integerValue);
    }];
    XCTAssert(reduced.integerValue == 10);
}

- (void)testFilter {
    NSDictionary *test = @{ @"one": @(1), @"two": @(2) };
    NSArray *modified = [test filter:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 2);
}

- (void)testReject {
    NSDictionary *test = @{ @"one": @(1), @"two": @(2) };
    NSArray *modified = [test reject:(id)^(NSNumber *object) {
        return object.integerValue == 2;
    }];
    XCTAssert(modified.count == 1);
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 1);
}

- (void)testEveryValid {
    NSDictionary *test = @{ @"one": @(1), @"two": @(2) };
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testEveryInvalid {
    NSDictionary *test = @{ @"one": @(1), @"two": @(-2) };
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == NO);
}

- (void)testEveryWhenEmpty {
    NSDictionary *test = @{};
    BOOL every = [test every:^BOOL(NSNumber *object) {
        return object.integerValue > 0;
    }];
    XCTAssert(every == YES);
}

- (void)testSomeValid {
    NSDictionary *test = @{ @"one": @(-1), @"two": @(2) };
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == YES);
}

- (void)testSomeInvalid {
    NSDictionary *test = @{ @"one": @(1), @"two": @(2) };
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}


- (void)testSomeWhenEmpty {
    NSDictionary *test = @{};
    BOOL some = [test some:^BOOL(NSNumber *object) {
        return object.integerValue < 0;
    }];
    XCTAssert(some == NO);
}

- (void)testPluck {
    NSDictionary *testObjects = @{@"one": @{@"id": @(1)}, @"two": @{@"id": @(2)}};
    NSArray *plucked = [testObjects pluck:@"id"];
    XCTAssert(plucked.count == 2);
    XCTAssert([plucked containsObject:@(1)]);
    XCTAssert([plucked containsObject:@(2)]);
}

- (void)testPluckWithInvalidProperty {
    NSDictionary *testObjects = @{@"one": @{@"id": @(1)}, @"two": @{@"id": @(2)}};
    NSArray *plucked = [testObjects pluck:@"name"];
    XCTAssertNotNil(plucked);
    XCTAssert(plucked.count == 0);
}

- (void)testMax {
    NSDictionary *testObjects = @{ @"one": @(10), @"two": @(20) };
    NSNumber *maxValue = [testObjects max:^NSInteger(id val) {
        NSNumber *dictVal = (NSNumber *)val;
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(maxValue);
    XCTAssert(maxValue.integerValue == 20);
}

- (void)testMaxEmpty {
    NSDictionary *testObjects = @{};
    id maxValue = [testObjects max:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(maxValue == nil);
}

- (void)testMin {
    NSDictionary *testObjects = @{ @"one": @(10), @"two": @(20) };
    NSNumber *minValue = [testObjects min:^NSInteger(id val) {
        NSNumber *dictVal = (NSNumber *)val;
        return dictVal.integerValue;
    }];
    XCTAssertNotNil(minValue);
    XCTAssert(minValue.integerValue == 10);
}

- (void)testMinEmpty {
    NSDictionary *testObjects = @{};
    id minValue = [testObjects min:^NSInteger(id val) {
        return -1;
    }];
    XCTAssert(minValue == nil);
}

- (void)testGroupBy {
    NSDictionary *testObjects = @{ @"one": @{@"token": @"ryan-1"}, @"two": @{@"token": @"ryan-2"}, @"three": @{@"token": @"test-1"} };
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

- (void)testGroupByWithInvalidKey {
    NSDictionary *testObjects = @{ @"one": @{@"token": @"ryan-1"}, @"two": @{@"token": @"ryan-2"} };
    NSDictionary *groupedObjects = [testObjects groupBy:^id(NSDictionary *val) {
        return nil;
    }];
    XCTAssertNotNil(groupedObjects);
    XCTAssert(groupedObjects.allKeys.count == 0);
}

- (void)testIndexBy {
    NSDictionary *testObjects = @{ @"one": @{@"token": @"1"}, @"two": @{@"token": @"2"}, @"three": @{@"token": @"3"} };
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

- (void)testIndexByWithInvalidKey {
    NSDictionary *testObjects = @{ @"one": @{@"token": @"1"}, @"two": @{@"token": @"2"} };
    NSDictionary *indexedObjects = [testObjects indexBy:^id(NSDictionary *val) {
        return nil;
    }];
    XCTAssertNotNil(indexedObjects);
    XCTAssert(indexedObjects.allKeys.count == 0);
}

- (void)testIndexByWithDuplicateKey {
    NSDictionary *testObjects = @{ @"one": @{@"token": @"1"}, @"two": @{@"token": @"2"}, @"three": @{@"token": @"1"} };
    XCTAssertThrows([testObjects indexBy:^id(NSDictionary *val) {
        return [val objectForKey:@"token"];
    }]);
}

- (void)testCountBy {
    NSDictionary *testObjects = @{ @"one": @(1), @"two": @(2), @"three": @(3) };
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


- (void)testCountByWithInvalidKey {
    NSDictionary *testObjects = @{ @"one": @(1), @"two": @(2), @"three": @(3) };
    NSDictionary *countedObjects = [testObjects countBy:^id(NSNumber *val) {
        return nil;
    }];
    XCTAssertNotNil(countedObjects);
    XCTAssert(countedObjects.allKeys.count == 0);
}

- (void)testPartitionSuccessAndFail {
    NSDictionary *testObjects = @{ @"one": @(1), @"two": @(2), @"three": @(3) };
    NSArray *result = [testObjects partition:^BOOL(NSNumber *object) {
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
    NSDictionary *testObjects = @{ @"one": @(2), @"two": @(4), @"three": @(6) };
    NSArray *result = [testObjects partition:^BOOL(NSNumber *object) {
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
    NSDictionary *testObjects = @{ @"one": @(1), @"two": @(3), @"three": @(5) };
    NSArray *result = [testObjects partition:^BOOL(NSNumber *object) {
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
