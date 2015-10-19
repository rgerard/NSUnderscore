//
//  NSUnderscoreTests.m
//  NSUnderscoreTests
//
//  Created by Ryan Gerard on 10/18/15.
//  Copyright © 2015 Ryan Gerard. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NSUnderscore/NSArray+NSUnderscoreAdditions.h>

@interface NSUnderscoreTests : XCTestCase

@end

@implementation NSUnderscoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEach {
    NSArray *test = @[@(2)];
    __block NSInteger count = 0;
    [test each:^(NSUInteger index, NSNumber *object) {
        count++;
    }];
    XCTAssert(count == 1);
}

- (void)testMap {
    NSArray *test = @[@(2)];
    NSArray *modified = [test map:(id)^(NSUInteger index, NSNumber *object) {
        return @(object.integerValue * 2);
    }];
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 4);
}

- (void)testFilter {
    NSArray *test = @[@(2), @(4)];
    NSArray *modified = [test filter:(id)^(NSUInteger index, NSNumber *object) {
        return object.integerValue == 2;
    }];
    NSNumber *modifiedValue = modified[0];
    XCTAssert(modifiedValue.integerValue == 2);
}

- (void)testReduce {
    NSArray *test = @[@(2), @(4)];
    NSNumber *reduced = [test reduce:(id)^(NSUInteger index, NSNumber *object, NSNumber *previousValue) {
        return @(object.integerValue + previousValue.integerValue);
    }];
    XCTAssert(reduced.integerValue == 6);
}

@end
