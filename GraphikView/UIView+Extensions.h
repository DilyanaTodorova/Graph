//
//  UIView+Extensions.h
//  GraphikView
//
//  Created by Delyana Todorova on 6/4/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)
- (BOOL) isRetinaDisplay;
- (CGFloat) yAxis;
- (CGFloat) xAxis;
- (NSUInteger) yIndexForPoint:(CGPoint)point;
- (NSUInteger) xIndexForPoint:(CGPoint)point;
@end
