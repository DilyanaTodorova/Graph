//
//  DDPNumberGenerator.m
//  GraphikView
//
//  Created by Delyana Todorova on 5/30/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "DDPNumberGenerator.h"


@implementation DDPNumberGenerator
static DDPNumberGenerator *sharedInstance = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DDPNumberGenerator alloc] init];
        srand48(time(0));
    });
    
    return sharedInstance;
}

- (CGFloat) nextFloat {
    double nextValue = sin(CFAbsoluteTimeGetCurrent()) + ((double)rand() / (double)RAND_MAX);
    return nextValue;
}

@end
