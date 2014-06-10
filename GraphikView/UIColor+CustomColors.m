//
//  UIColor+CustomColors.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/10/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)
+ (UIColor *) colorWithHex:(NSUInteger)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *) veryLightGrayColor {
    return [UIColor colorWithHex:0xe0e0e0];
}
@end
