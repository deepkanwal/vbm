//
//  UIHelper.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUI_ANIMATION_DURATION 0.3f

#define kUI_PADDING_3 3.0
#define kUI_PADDING_5 5.0
#define kUI_PADDING_10 10.0
#define kUI_PADDING_15 15.0
#define kUI_PADDING_20 20.0

#define kUI_FULL_SCREEN_SIZE [UIScreen mainScreen].bounds.size

#define kUI_COLOR_DIVIDER [UIColor colorWithRed:225.0f/255.0f green:225.0f/255.0f blue:225.0f/255.0f alpha:1]
#define kUI_COLOR_DEFAULT_BACKGROUNG_GRAY [UIColor colorWithRed:238.0f/255.0f green:239.0f/255.0f blue:245.0f/255.0f alpha:1]

#define kUI_COLOR_LIGHT_GRAY [UIColor colorWithRed:243.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1]
#define kUI_COLOR_SEPERATOR_COLOR [UIColor colorWithRed:214.0f/255.0f green:218.0f/255.0f blue:222.0f/255.0f alpha:1]
#define kUI_COLOR_BLUE_ACCENT [UIColor colorWithRed:170.0f/255.0f green:180.0f/255.0f blue:190.0f/255.0f alpha:1]

#define kUI_COLOR_SEARCH_BAR [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:220.0f/255.0f alpha:1]
#define kUI_COLOR_MAIL_COMPOSER kUI_COLOR_SEARCH_BAR

#define kUI_COLOR_NAVBAR  [UIColor colorWithRed:25.0f/255.0f green:167.0f/255.0f blue:232.0f/255.0f alpha:0.97]

#define kUI_COLOR_DEFAULT_TINT [UIColor colorWithRed:82.0f/255.0f green:90.0f/255.0f blue:98.0f/255.0f alpha:0.97]

#define kSTATUS_BAR_HEIGHT CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)

@interface UIHelper : NSObject

+ (UIView*)addDividerBelowView:(UIView*)view inView:(UIView*)superView;
+ (CGFloat)heightWithoutStatusBar:(BOOL)statusBar navbar:(UINavigationBar*)navbar tabBar:(UITabBar*)tabBar;

@end
