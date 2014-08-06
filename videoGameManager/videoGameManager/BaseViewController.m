//
//  BaseViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadingView.h"
#import "ImageWithCaptionView.h"
#import "UIHelper.h"
#import "UIView+Additions.h"

@interface BaseViewController ()
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) ToastView *toastView;
@property (nonatomic, strong) ToastView *loadingToastView;
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupBaseViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.screenName = NSStringFromClass([self class]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBaseViewController
{
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.loadingView];
    
    self.imageWithCaptionsView = [[ImageWithCaptionView alloc] init];
    [self.view addSubview:self.imageWithCaptionsView];
    [self.imageWithCaptionsView setHidden:YES];
    [self.imageWithCaptionsView centerInFrame:self.view.bounds];
    
    [self createOverlayView];
}

- (void)updateNavigationBarTitle:(NSString*)title
{
    [self.navigationController.navigationItem.titleView applyFadeTransition];
    self.navigationItem.title = title;
}

#pragma mark - Loading view methods

- (void)showLoadingView
{
    [self.view bringSubviewToFront:self.loadingView];
    [self.loadingView show];
}

- (void)showLoadingViewWithMessage:(NSString*)message
{
    if (!self.loadingToastView) {
        self.loadingToastView = [[[NSBundle mainBundle] loadNibNamed:@"ToastView" owner:self options:nil] lastObject];
        [self.loadingToastView setHidden:YES];
        self.loadingToastView.delegate = self;
        [self.view addSubview:self.loadingToastView];
    }
    
    [self showLoadingView];
    
    [self.loadingToastView shiftToXCenter:CGRectGetMidX(self.view.bounds)];
    [self.loadingToastView shiftToYOrigin:CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(self.loadingToastView.bounds) - 80.0f];
    [self.loadingToastView updateWithMessage:message];
    
    [self.loadingToastView applyFadeTransition];
    [self.loadingToastView setHidden:NO];
}

- (void)hideLoadingView
{
    [self.loadingView hide];
    [self.toastView applyFadeTransition];
    [self.loadingToastView setHidden:YES];
}

- (void)createOverlayView
{
    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.overlayView setBackgroundColor:kUI_COLOR_DEFAULT_TINT];
    [self.overlayView setAlpha:0.4];
    [self.view addSubview:self.overlayView];
    
    UITapGestureRecognizer *touchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOverlay)];
    [self.overlayView addGestureRecognizer:touchRecognizer];
    [self.overlayView setHidden:YES];
    
}

- (void)adjustOverlayViewYOrigin:(CGFloat)yOrigin
{
    [self.overlayView resizeHeight:CGRectGetHeight(self.overlayView.bounds) - yOrigin];
    [self.overlayView shiftToYOrigin:yOrigin];
}

- (void)showOverlay
{
    [self.view bringSubviewToFront:self.overlayView];
    [self.overlayView applyFadeTransition];
    [self.overlayView setHidden:NO];
    
}

- (void)dismissOverlay
{
    [self.overlayView applyFadeTransition];
    [self.overlayView setHidden:YES];
    [self dismissKeyboard];
}

#pragma mark - ImageViewWithCaption

- (void)showImageViewWithCaption
{
    [self.imageWithCaptionsView applyFadeTransition];
    [self.view bringSubviewToFront:self.imageWithCaptionsView];
    [self.imageWithCaptionsView setHidden:NO];
}

- (void)hideImageViewWithCaption
{
    [self.imageWithCaptionsView applyFadeTransition];
    [self.imageWithCaptionsView setHidden:YES];
}

#pragma mark - AlertView

- (void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message
{
    if (!self.alertView) {
        self.alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    

    [self.alertView setTitle:title];
    [self.alertView setMessage:message];
    [self.alertView show];
}

- (void)showInvalidAlertWithMessage:(NSString*)message
{
    [self showAlertViewWithTitle:@"Invalid Input" andMessage:message];
}

#pragma mark - ToastView

- (void)showToastWithMessage:(NSString*)message
{
    static NSInteger count;
    
    if (!self.toastView) {
        self.toastView = [[[NSBundle mainBundle] loadNibNamed:@"ToastView" owner:self options:nil] lastObject];
        [self.toastView setHidden:YES];
        self.toastView.delegate = self;
        [self.view addSubview:self.toastView];
    }
    
    [self.toastView shiftToXCenter:CGRectGetMidX(self.view.bounds)];
    [self.toastView shiftToYOrigin:CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(self.toastView.bounds) - 80.0f];
    [self.toastView updateWithMessage:message];
    
    
    [self.toastView applyFadeTransition];
    [self.toastView setHidden:NO];
    
    count++;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        count--;
        
        if (count == 0) {
            [self.toastView applyFadeTransition];
            [self.toastView setHidden:YES];
        }
    });
}
- (void)toastPressed
{
    [self.toastView applyFadeTransition];
    [self.toastView setHidden:YES];
}

#pragma mark - Keyboard methods

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

@end
