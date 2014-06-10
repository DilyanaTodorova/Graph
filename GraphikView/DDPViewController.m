//
//  DDPViewController.m
//  GraphikView
//
//  Created by Delyana Todorova on 5/30/14.
//  Copyright (c) 2014 Delyana Todorova. All rights reserved.
//

#import "DDPViewController.h"
#import "DDPGraphicView.h"
#import "DDPNumberGenerator.h"
#import "UIView+Extensions.h"

@interface DDPViewController () <DDPGraphicViewDataSource>
@property (weak, nonatomic) IBOutlet DDPGraphicView *graphView;
@property (strong, nonatomic) NSMutableArray *points;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation DDPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.graphView.dataSource = self;
    NSMutableArray *points = [[NSMutableArray alloc] init];
    self.points = points;
    [self invalidateTimer];
}

- (void) invalidateTimer {
    __weak id weakSelf = self;
    double delayInSeconds = 0.35;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                                        dispatch_get_main_queue());
    dispatch_source_set_timer(
                              _timer, dispatch_walltime(NULL, 0),
                              (unsigned)(delayInSeconds * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_timer, ^{
        [weakSelf updateGraph];
    });
    dispatch_resume(_timer);
}

- (void) updateGraph {
    NSNumber *value = @([[DDPNumberGenerator sharedInstance] nextFloat]);
    [self.points addObject:value];
    
    NSUInteger limit =  [self.view xAxis] / self.graphView.gridSpacing;
    if (self.points.count > limit) {
        [self.points removeObjectsInRange:NSMakeRange(0, self.points.count - limit)];
    }
    
    [self.graphView setNeedsDisplay];
}

- (NSArray *) valuesGraphView:(DDPGraphicView *)graphicView {
    return self.points;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    dispatch_source_cancel(_timer);
}

@end
