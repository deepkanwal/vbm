//
//  UIView+Additions.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-27.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)shiftToYOrigin:(CGFloat)yOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = yOrigin;
    self.frame = newFrame;
}

- (void)shiftToXOrigin:(CGFloat)xOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = xOrigin;
    self.frame = newFrame;
}


- (void)resize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size.height = size.height;
    newFrame.size.width = size.width;
    self.frame = newFrame;
}

- (void)resizeHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

- (void)resizeWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (void)move:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = origin.x;
    newFrame.origin.y = origin.y;
    self.frame = newFrame;
}

- (void)shiftToXCenter:(CGFloat)xCenter
{
    self.center = CGPointMake(xCenter, CGRectGetMidY(self.frame));
}

- (void)shiftToYCenter:(CGFloat)yCenter
{
    self.center = CGPointMake(CGRectGetMidX(self.frame), yCenter);
}

- (void)centerInFrame:(CGRect)frame
{
    [self setCenter:CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))];
}

- (void)applyBorder
{
    [self applyBorderOfColor:[UIColor lightGrayColor] width:1.0f];
}

- (void)applyBorderOfColor:(UIColor*)color width:(CGFloat)width
{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)applyFadeTransition
{
    CATransition *fadeTransition = [CATransition animation];
    fadeTransition.duration = 0.2f;
    [self.layer addAnimation:fadeTransition forKey:nil];
}

- (void)applyMoveUpTransition
{
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionMoveIn];
    [transition setSubtype:kCATransitionFromTop];
    [self.layer addAnimation:transition forKey:nil];
}

- (void)applyMoveDownTransition
{
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionMoveIn];
    [transition setSubtype:kCATransitionFromTop];
    [self.layer addAnimation:transition forKey:nil];
}

- (void)applyPushTransitionWithSubtype:(NSString*)subtype
{
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionPush];
    [transition setSubtype:subtype];
    [self.layer addAnimation:transition forKey:nil];
}


+ (UIView*)roundedViewWithRect:(CGRect)rect andRadius:(CGFloat)radius
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view.layer setCornerRadius:radius];
    return view;
}

- (void)applyRoundedCorners:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
}

- (void)applyInnerShadow
{
    UIImage *shadowImage = [UIImage imageNamed:@"drop_shadow"];
    shadowImage = [shadowImage stretchableImageWithLeftCapWidth:floorf(shadowImage.size.width/2.0f) topCapHeight:floorf(shadowImage.size.width/2.0f)];
    UIImageView *shadowImageView = [[UIImageView alloc] initWithImage:shadowImage];
    [shadowImageView setContentMode:UIViewContentModeScaleToFill];
    [shadowImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [shadowImageView setAlpha:0.5f];
    shadowImageView.frame = self.bounds;
    [self addSubview:shadowImageView];
}

- (void)applyDropShadow
{
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 4.0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

@end
