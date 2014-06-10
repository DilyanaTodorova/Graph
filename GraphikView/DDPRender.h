//
//  DDPRender.h
//  GraphikView
//
//  Created by Delyana Todorova on 6/7/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPRender : NSObject
+ (UIImage *) drawImageForVerticalLineForPoint:(CGPoint)point height:(CGFloat)height size:(CGSize)size;
+ (UIImage *) drawImageForMedian:(CGFloat)median begin:(CGFloat)startPoint endPoint:(CGFloat)endPoint size:(CGSize)size;
@end
