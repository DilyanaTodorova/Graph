//
//  DDPGraphicView.h
//  GraphikView
//
//  Created by Delyana Todorova on 5/30/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DDPGraphicViewDataSource;

@interface DDPGraphicView : UIView
@property (weak, nonatomic) id<DDPGraphicViewDataSource> dataSource;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGFloat xOffset;
@property (assign, nonatomic) CGFloat yOffset;
@property (assign, nonatomic) CGFloat gridSpacing;
@property (assign, nonatomic) UIColor *gridLineColor;
@property (assign, nonatomic) UIColor *graphColor;
@end

@protocol DDPGraphicViewDataSource <NSObject>
- (NSArray *) valuesGraphView:(DDPGraphicView *)graphicView;
@end