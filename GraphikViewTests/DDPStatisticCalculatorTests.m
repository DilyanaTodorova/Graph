//
//  DDPStatisticCalculatorTests.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/8/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDPStatisticCalculator.h"

@interface DDPStatisticCalculatorTests : XCTestCase

@end

@implementation DDPStatisticCalculatorTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void) testShortSequence {
    NSArray *sequence = @[@(12), @(3), @(5)];
    NSNumber *num = [DDPStatisticCalculator calculateMedianForPoints:sequence];
    XCTAssertEqualObjects(num, @(5), @"The median should be 5, instead is %@", num);
}

- (void) testLongSequence {
    NSArray *sequence = @[@(3), @(13), @(7), @(5), @(21), @(23), @(39), @(23), @(40), @(23), @(14), @(12), @(56), @(23), @(29)];
    NSNumber *num = [DDPStatisticCalculator calculateMedianForPoints:sequence];
    XCTAssertEqualObjects(num, @(23), @"The median should  be 23, instead is %@", num);
}

- (void) testOddSequence {
    NSArray *sequence = @[@(3), @(13), @(7), @(5), @(21), @(23), @(23), @(40), @(23), @(14), @(12), @(56), @(23), @(29)];
    NSNumber *num = [DDPStatisticCalculator calculateMedianForPoints:sequence];
    XCTAssertEqualObjects(num, @(22), @"The median should be 22, instead is %@", num);
}
@end
