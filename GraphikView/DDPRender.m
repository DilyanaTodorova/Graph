//
//  DDPRender.m
//  GraphikView
//
//  Created by Delyana Todorova on 6/7/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "DDPRender.h"

static inline CGAffineTransform
CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy,
                                    CGFloat dx, CGFloat dy)
{
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

@implementation DDPRender

+ (UIImage *) drawImageForVerticalLineForPoint:(CGPoint)point height:(CGFloat)height size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5f;
    CGPoint startPoint = CGPointMake(point.x, 0.);
    CGPoint endPoint = CGPointMake(point.x, height);
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [[UIColor redColor] setStroke];
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) drawImageForMedian:(CGFloat)median begin:(CGFloat)start endPoint:(CGFloat)end size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5f;
    CGFloat y = median;
    CGPoint startPoint = CGPointMake(start, y);
    CGPoint endPoint = CGPointMake(end, y);
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [[UIColor blackColor] setStroke];
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
