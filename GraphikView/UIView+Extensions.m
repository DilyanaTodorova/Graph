//
//  UIView+Extensions.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/4/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)
- (BOOL) isRetinaDisplay {
    return self.contentScaleFactor == 2.;
}

- (CGFloat) yAxis {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        return self.bounds.size.height;
    } else {
        return self.bounds.size.width;
    }
}

- (CGFloat) xAxis {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        return self.bounds.size.width;
    } else {
        return self.bounds.size.height;
    }
}

- (NSUInteger) yIndexForPoint:(CGPoint)point {
    CGFloat slice = self.yAxis / point.y;
    NSUInteger index = (NSUInteger) slice;
    return index;
}

- (NSUInteger) xIndexForPoint:(CGPoint)point {
    CGFloat slice = self.xAxis / point.x;
    NSUInteger index = (NSUInteger) slice;
    return index;
}

@end
