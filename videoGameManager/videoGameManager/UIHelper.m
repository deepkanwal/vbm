//
//  UIHelper.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

- (void) test {
    [UIColor colorWithRed:166.0f/255.0f green:100.0f/255.0f blue:0.0f/255.0f alpha:1];
}

+ (UIView*)addDividerBelowView:(UIView*)view inView:(UIView*)superView
{
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(kUI_PADDING_10, CGRectGetMaxY(view.frame) + kUI_PADDING_10, kUI_FULL_SCREEN_SIZE.width - 2 * kUI_PADDING_10, 1.0f)];
    [divider setBackgroundColor:kUI_COLOR_DIVIDER];
    [superView addSubview:divider];
    return divider;
}

+ (CGFloat)heightWithoutStatusBar:(BOOL)statusBar navbar:(UINavigationBar*)navbar tabBar:(UITabBar*)tabBar
{
    CGFloat height = kUI_FULL_SCREEN_SIZE.height;
    if (statusBar) height -= kSTATUS_BAR_HEIGHT;
    if (navbar) height -= CGRectGetHeight(navbar.bounds);
    if (tabBar) height -= CGRectGetHeight(tabBar.bounds);
    
    return height;
}

@end
