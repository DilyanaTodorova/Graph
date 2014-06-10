//
//  DDPStatisticCalculator.h
//  GraphikView
//
//  Created by Delyana Todorova on 6/8/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPStatisticCalculator : NSObject
+ (NSNumber *) calculateMedianForPoints:(NSArray *)points;
@end
