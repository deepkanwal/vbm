//
//  BaseViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "ToastView.h"

@class ImageWithCaptionView;

@interface BaseViewController : GAITrackedViewController <ToastViewDelegate>

@property (nonatomic, strong) ImageWithCaptionView *imageWithCaptionsView;

- (void)updateNavigationBarTitle:(NSString*)title;

- (void)showLoadingView;
- (void)showLoadingViewWithMessage:(NSString*)message;
- (void)hideLoadingView;

- (void)showOverlay;
- (void)dismissOverlay;
- (void)adjustOverlayViewYOrigin:(CGFloat)yOrigin;

- (void)showImageViewWithCaption;
- (void)hideImageViewWithCaption;

- (void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message;
- (void)showInvalidAlertWithMessage:(NSString*)message;

- (void)showToastWithMessage:(NSString*)message;

- (void)dismissKeyboard;

@end
