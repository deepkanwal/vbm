//
//  ProgressBarView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-21.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "ProgressBarView.h"
#import "UIHelper.h"
#import "UIView+Additions.h"

@interface ProgressBarView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *progressLabel;
@end

@implementation ProgressBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundView = [UIView roundedViewWithRect:self.bounds andRadius:5.0f];
    [self.backgroundView setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.75f]];
    [self.backgroundView applyBorderOfColor:kUI_COLOR_DEFAULT_TINT width:1.0f];
    [self addSubview:self.backgroundView];
    
    self.barView = [UIView roundedViewWithRect:self.backgroundView.bounds andRadius:5.0f];
    [self.barView setBackgroundColor:kUI_COLOR_BLUE_ACCENT];
    [self.backgroundView addSubview:self.barView];
    
    self.progressLabel = [[UILabel alloc] init];
    [self.progressLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.progressLabel setTextColor:kUI_COLOR_DEFAULT_TINT];
    [self.progressLabel setText:@"0%%"];
    [self.progressLabel sizeToFit];
    [self.progressLabel shiftToYCenter:CGRectGetMidY(self.backgroundView.bounds)];
    [self.progressLabel shiftToXOrigin:CGRectGetMaxX(self.backgroundView.bounds) - CGRectGetWidth(self.progressLabel.bounds) - kUI_PADDING_10];
    [self.backgroundView addSubview:self.progressLabel];
}

- (void)setProgress:(NSInteger)progress
{
    if (progress < 0) progress = 0;
    else if (progress > 100) progress = 100;
    
    CGFloat width = floorf((progress/100.0f) * CGRectGetWidth(self.backgroundView.bounds));
    
    [self.barView resizeWidth:width];
    
    [self.progressLabel setText:[NSString stringWithFormat:@"%ld%%", (long)progress]];
    [self.progressLabel sizeToFit];
    [self.progressLabel shiftToXOrigin:CGRectGetMaxX(self.backgroundView.bounds) - CGRectGetWidth(self.progressLabel.bounds) - kUI_PADDING_10];
}

@end
