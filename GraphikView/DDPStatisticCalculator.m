//
//  DDPStatisticCalculator.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/8/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "DDPStatisticCalculator.h"

@implementation DDPStatisticCalculator
+ (NSNumber *) calculateMedianForPoints:(NSArray *)points {
    if (points.count == 0) {
        return 0;
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedPoints = [points sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSUInteger count = sortedPoints.count;
    
    NSNumber *toReturn = nil;
    if (count % 2 == 0) {
        NSUInteger middleIndex = sortedPoints.count / 2;
        NSUInteger nextIndex = sortedPoints.count/2 - 1;
        NSNumber *middleElement = sortedPoints[middleIndex];
        NSNumber *nextMiddleElement = sortedPoints[nextIndex];
        CGFloat median = (middleElement.floatValue + nextMiddleElement.floatValue) / 2.f;
        toReturn = @(median);
    } else {
        NSUInteger middlePoint = sortedPoints.count / 2;
        toReturn = sortedPoints[middlePoint];
    }
    
    return toReturn;
}

@end
