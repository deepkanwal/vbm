//
//  LoadingSpinner.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-21.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "LoadingSpinner.h"
#import "UIHelper.h"
#import "UIView+Additions.h"

@interface LoadingSpinner ()
@property (nonatomic, strong) UIActivityIndicatorView* loadingSpinner;
@property (nonatomic, strong) UIView* loadingBackgroundView;
@end

@implementation LoadingSpinner

- (id)initWithFrame:(CGRect)frame large:(BOOL)large
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviewsForFrame:frame large:large];
    }
    return self;
}

- (void)setupSubviewsForFrame:(CGRect)frame large:(BOOL)large
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGFloat radius = large ? 20.0f : 10.0f;
    CGFloat size = large ? 60.0f : 35.0f;
    UIActivityIndicatorViewStyle style = large ? UIActivityIndicatorViewStyleWhiteLarge : UIActivityIndicatorViewStyleWhite;
    
    self.loadingBackgroundView = [UIView roundedViewWithRect:CGRectZero andRadius:radius];
    [self.loadingBackgroundView resize:CGSizeMake(size, size)];
    [self.loadingBackgroundView setBackgroundColor:kUI_COLOR_DEFAULT_TINT];
    [self.loadingBackgroundView setAlpha:0.35f];
    [self.loadingBackgroundView centerInFrame:self.bounds];
    [self addSubview:self.loadingBackgroundView];
    
    self.loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [self.loadingSpinner centerInFrame:self.loadingBackgroundView.bounds];
    [self.loadingBackgroundView addSubview:self.loadingSpinner];
    
    [self.loadingBackgroundView setUserInteractionEnabled:NO];
    [self.loadingSpinner setUserInteractionEnabled:NO];
}

- (void)startAnimation
{
    [self.loadingSpinner startAnimating];
}

- (void)stopAnimation
{
    [self.loadingSpinner stopAnimating];
}

@end
