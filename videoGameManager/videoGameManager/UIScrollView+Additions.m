//
//  UIScrollView+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UIScrollView+Additions.h"
#import "UIHelper.h"

@implementation UIScrollView (Additions)

- (void)setInitialPositionBelowNavigationBar:(UINavigationBar*)navigationBar
{
    CGFloat height = kSTATUS_BAR_HEIGHT + CGRectGetHeight(navigationBar.bounds);
    [self setContentInset:UIEdgeInsetsMake(height, self.contentInset.left, self.contentInset.bottom, self.contentInset.right)];
    [self setScrollIndicatorInsets:self.contentInset];
}

- (void)setInitialPositionAboveTabBar:(UITabBar*)tabBar
{
    CGFloat height = CGRectGetHeight(tabBar.bounds);
    [self setContentInset:UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, height, self.contentInset.right)];
    [self setScrollIndicatorInsets:self.contentInset];
}

@end
