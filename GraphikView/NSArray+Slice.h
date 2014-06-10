//
//  NSArray+Slice.h
//  GraphikView
//
//  Created by Delyana Todorova on 6/9/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Slice)
- (NSArray *) arrayFromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex;
@end
