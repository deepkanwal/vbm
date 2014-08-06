//
//  UITableView+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-07.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UITableView+Additions.h"
#import "UIHelper.h"

#import "UIView+Additions.h"
#import "UILabel+Additions.h"

@implementation UITableView (Additions)

- (void)setUpHeaderWithTitle:(NSString *)title title:(BOOL)isTitle
{
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel resizeWidth:CGRectGetWidth(self.bounds) - 2 * kUI_PADDING_20];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setText:title];
    [headerLabel setNumberOfLines:0];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [headerLabel sizeToFitWithWidthConserved];
    
    if (isTitle) [headerLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    else [headerLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    
    [headerView resize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(headerLabel.bounds) + 2 * kUI_PADDING_20)];
    [headerView addSubview:headerLabel];
    [headerLabel setCenter:headerView.center];
    
    [self setTableHeaderView:headerView];
}

- (void)setupDefaultApperance
{
    [self setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
    [self setSeparatorColor:kUI_COLOR_SEPERATOR_COLOR];
}

@end
