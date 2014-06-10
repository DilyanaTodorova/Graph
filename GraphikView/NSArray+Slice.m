//
//  NSArray+Slice.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/9/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "NSArray+Slice.h"

@implementation NSArray (Slice)
- (NSArray *) arrayFromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex {
    NSUInteger count = self.count;
    
    startIndex = MIN(startIndex, count);
    endIndex = MIN(endIndex, count);
    
    NSUInteger length = [self lengthForStartIndex:startIndex andEndIndex:endIndex];
    NSUInteger start = MIN(startIndex, endIndex);
    NSRange range = NSMakeRange(start, length);
    
    NSArray *subarray = [self subarrayWithRange:range];
    return subarray;
}

- (NSUInteger) lengthForStartIndex:(NSUInteger)startIndex andEndIndex:(NSUInteger)endIndex {
    NSUInteger length = 0;
    NSUInteger count = self.count;
    
    length = MAX(endIndex, startIndex) - MIN(endIndex, startIndex);
    
    if (length > count - MIN(startIndex, endIndex)) {
        length = count - startIndex;
    }
    
    return length;
}
@end
