//
//  DDPNumberGenerator.h
//  GraphikView
//
//  Created by Delyana Todorova on 5/30/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPNumberGenerator : NSObject
+ (instancetype) sharedInstance;
- (CGFloat) nextFloat;
@end
