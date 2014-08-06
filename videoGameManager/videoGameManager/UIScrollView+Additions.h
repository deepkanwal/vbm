//
//  UIScrollView+Additions.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

- (void)setInitialPositionBelowNavigationBar:(UINavigationBar*)navigationBar;
- (void)setInitialPositionAboveTabBar:(UITabBar*)tabBar;

@end
