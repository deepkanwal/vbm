//
//  UIView+Additions.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-27.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (void)shiftToYOrigin:(CGFloat)yOrigin;
- (void)shiftToXOrigin:(CGFloat)xOrigin;
- (void)resize:(CGSize)size;
- (void)resizeHeight:(CGFloat)height;
- (void)resizeWidth:(CGFloat)width;
- (void)move:(CGPoint)origin;
- (void)shiftToXCenter:(CGFloat)xCenter;
- (void)shiftToYCenter:(CGFloat)yCenter;
- (void)centerInFrame:(CGRect)frame;

- (void)applyBorder;
- (void)applyBorderOfColor:(UIColor*)color width:(CGFloat)width;

- (void)applyFadeTransition;
- (void)applyMoveUpTransition;
- (void)applyPushTransitionWithSubtype:(NSString*)subtype;

+ (UIView*)roundedViewWithRect:(CGRect)rect andRadius:(CGFloat)radius;
- (void)applyRoundedCorners:(CGFloat)radius;

- (void)applyInnerShadow;
- (void)applyDropShadow;

@end
