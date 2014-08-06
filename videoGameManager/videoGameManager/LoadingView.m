//
//  LoadingView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "LoadingView.h"
#import "LoadingSpinner.h"
#import "UIHelper.h"
#import "UIView+Additions.h"

@interface LoadingView ()
@property (nonatomic, strong) LoadingSpinner* loadingSpinner;
@end

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLoadingView];
    }
    return self;
}

- (void)createLoadingView
{
    self.loadingSpinner = [[LoadingSpinner alloc] initWithFrame:self.bounds large:YES];
    [self addSubview:self.loadingSpinner];
    
    [self setHidden:YES];
    
    [self.loadingSpinner setUserInteractionEnabled:NO];
    [self setUserInteractionEnabled:NO];
}

- (void)show
{
    [self setHidden:NO];
    [self.loadingSpinner startAnimation];
    [UIView animateWithDuration:kUI_ANIMATION_DURATION delay:kUI_ANIMATION_DURATION options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self setAlpha:1.0f];
    } completion:nil];
}

- (void)hide
{
    [UIView animateWithDuration:kUI_ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [self.loadingSpinner stopAnimation];
    }];
}


@end
