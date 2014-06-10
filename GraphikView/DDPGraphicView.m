//
//  DDPGraphicView.m
//  GraphikView
//
//  Created by Delyana Todorova on 5/30/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "DDPGraphicView.h"
#import "DDPNumberGenerator.h"
#import "UIView+Extensions.h"
#import "DDPRender.h"
#import "DDPStatisticCalculator.h"
#import "NSArray+Slice.h"
#import "UIColor+CustomColors.h"

#define point(x, y) CGPointMake(x, y)

@interface DDPGraphicView()
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) NSOperationQueue *drawQueue;
@property (strong, nonatomic) CALayer *firstLineLayer;
@property (strong, nonatomic) CALayer *secondLineLayer;
@property (strong, nonatomic) CALayer *medianLineLayer;
@property (assign, nonatomic) CGPoint firstPoint;
@property (assign, nonatomic) CGPoint secondPoint;
@property (assign, nonatomic) BOOL shouldDrawMedian;
@end

@implementation DDPGraphicView

static inline CGAffineTransform
CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy,
                                    CGFloat dx, CGFloat dy)
{
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (void) commonInit {
    self.opaque = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode = UIViewContentModeRedraw;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    self.tapGesture = tapGesture;
    [self addGestureRecognizer:self.tapGesture];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    _drawQueue = queue;
    _firstLineLayer = [CALayer layer];
    _firstLineLayer.frame = self.bounds;
    [self.layer addSublayer:_firstLineLayer];
    
    _secondLineLayer = [CALayer layer];
    _secondLineLayer.frame = self.bounds;
    [self.layer addSublayer:_secondLineLayer];
    
    _medianLineLayer = [CALayer layer];
    _medianLineLayer.frame = self.bounds;
    [self.layer addSublayer:_medianLineLayer];
    
    _gridLineColor = [UIColor lightGrayColor];
    _graphColor = [UIColor greenColor];
    
    _gridSpacing = 20.f;
    
    if ([self isRetinaDisplay]) {
        _lineWidth = 0.5;
        _yOffset = 0.25;
        _xOffset = 0.25;
    } else {
        _lineWidth = 1;
        _yOffset = 0.5;
        _xOffset = 0.5;
    }
    
}

- (void) didTap:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self];
    [self drawVerticalLineAtPoint:point];
}

- (void) drawVerticalLineAtPoint:(CGPoint)point {
    [self.drawQueue addOperationWithBlock:^{
//        CGRect rect = CGRectMake(point.x - 1., 0.f, 44.f, self.bounds.size.height);
        CGSize size = CGSizeMake(44.f, self.bounds.size.height);
        
        UIImage *image = [DDPRender drawImageForVerticalLineForPoint:point height:[self yAxis] size:self.bounds.size];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (!self.firstLineLayer.contents) {
                self.firstLineLayer.contents = (__bridge id)image.CGImage;
                self.firstPoint = point;
            }
            else if (!self.secondLineLayer.contents) {
//                self.secondLineLayer.frame = rect;
                self.secondLineLayer.contents = (__bridge id)image.CGImage;
                self.secondPoint = point;
                NSArray *values = [self dataSourceForPoint:self.firstPoint toPoint:self.secondPoint];
                self.shouldDrawMedian = YES;
                [self drawMedian:values];
            }
            
        }];
    }];
}

- (void) drawMedian:(NSArray *)values {
    [self.drawQueue addOperationWithBlock:^{
        NSNumber *median = [DDPStatisticCalculator calculateMedianForPoints:values];
        UIImage *image = [self drawImageForMedian:median.floatValue forPoints:values begin:self.firstPoint endPoint:self.secondPoint size:self.bounds.size];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.medianLineLayer.contents = (__bridge id)image.CGImage;
        }];
    }];
}

- (NSArray *) dataSourceForPoint:(CGPoint)start toPoint:(CGPoint)end {
    
    NSUInteger firstIndex = [self xIndexForPoint:start];
    NSUInteger secondIndex = [self xIndexForPoint:end];
    
    NSArray *values = [self.dataSource valuesGraphView:self];
    NSArray *subarray = [values arrayFromIndex:firstIndex toIndex:secondIndex];
    return subarray;
}

- (void) drawRect:(CGRect)rect
{
    [self drawGrid];
    [self drawGraphics];
    if (self.shouldDrawMedian) {
        NSArray *values = [self dataSourceForPoint:self.firstPoint toPoint:self.secondPoint];
        [self drawMedian:values];
    }
}

- (void) drawGrid {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.lineWidth;
    
    CGFloat x = self.xOffset;
    while (x <= width) {
        [path moveToPoint:point(x, 0.0)];
        [path addLineToPoint:point(x, height)];
        CGFloat pattern[] = {5.f, 3.f};
        [path setLineDash:pattern count:2 phase:5.f];
        x += self.gridSpacing;
    }
    
    CGFloat y = self.yOffset;
    while (y <= height) {
        [path moveToPoint:point(0.0, y)];
        [path addLineToPoint:point(width, y)];
        y += self.gridSpacing;
    }
    
    [self.gridLineColor setStroke];
    [path stroke];
}

- (void)  drawGraphics {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.graphColor.CGColor);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat yOffset = self.yAxis;
    CGAffineTransform transform = CGAffineTransformMakeScaleTranslate(self.gridSpacing, -yOffset / 4., 0, yOffset / 2.);
    
    NSArray *values = [self.dataSource valuesGraphView:self];
    
    [values enumerateObjectsUsingBlock:^(NSNumber *data, NSUInteger index, BOOL *stop){
        CGFloat dataFloat = [data floatValue];
        
        if (index == 0) {
            CGPathMoveToPoint(path, &transform, index, dataFloat);
        }
        
        CGPathAddLineToPoint(path, &transform, index, dataFloat);
    }];
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
}

- (UIImage *) drawImageForMedian:(CGFloat)median forPoints:(NSArray *)points begin:(CGPoint)start endPoint:(CGPoint)end size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.lineWidth;
    
    CGPoint point1 = point(start.x, median);
    CGPoint point2 = point(end.x, median);
    
    CGFloat yOffset = self.yAxis;
    CGAffineTransform transform = CGAffineTransformMakeScaleTranslate(self.gridSpacing, -yOffset / 4., 0, yOffset / 2.);
    point1 = CGPointApplyAffineTransform(point1, transform);
    point1.x = start.x;
    point2 = CGPointApplyAffineTransform(point2, transform);
    point2.x = end.x;
    
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];

    [[UIColor blackColor] setStroke];
    [path stroke];
    CGFloat width = point2.x - point1.x;
    CGRect rect = CGRectMake(point1.x, point1.y, width , 10.);
    [self drawText:[self textForData:median] inRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) drawText:(NSString *)text atPoint:(CGPoint)point {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10.],
                                 NSStrokeColorAttributeName : self.graphColor};
    
    CGFloat yOffset = self.yAxis;
    CGAffineTransform transform = CGAffineTransformMakeScaleTranslate(self.gridSpacing, - yOffset / 4., 0, yOffset / 2.);
    CGPoint translatedPoint = CGPointApplyAffineTransform(point, transform);
    [text drawAtPoint:translatedPoint withAttributes:attributes];
}

- (void) drawText:(NSString *)text inRect:(CGRect)rect {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10.],
                                 NSStrokeColorAttributeName : self.graphColor};
    [text drawInRect:rect withAttributes:attributes];
}

- (NSString *) textForData:(CGFloat)data {
    return [NSString stringWithFormat:@"Median: %.5f", data];
}
@end
