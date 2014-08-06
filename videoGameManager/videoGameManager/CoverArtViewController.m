//
//  CoverArtViewController.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-27.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "CoverArtViewController.h"
#import "Game.h"

#import "UIHelper.h"
#import "UIView+Additions.h"
#import "UIImageView+Additions.h"

@interface CoverArtViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation CoverArtViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setupGestureRecognizer];
    [self loadImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)loadImage
{
    [self showLoadingView];
    [self.imageView setImageWithURLString:self.urlString placeHolderImageName:@"default" fade:YES completed:^(BOOL isSuccess){
        [self hideLoadingView];
        if (isSuccess) {
            [self.imageView sizeToFitImage];
        } else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not load image." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.scrollView.contentSize.height > CGRectGetHeight(self.scrollView.bounds)) {
        [self.imageView setCenter:CGPointMake(floorf(self.scrollView.contentSize.width/2), floorf(self.scrollView.contentSize.height/2))];
    } else {
        [self.imageView shiftToYCenter:CGRectGetMidY(self.scrollView.frame)];
    }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    }
}

- (void)showLoadingView
{
    if (!self.spinner) {
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.spinner setCenter:self.view.center];
        [self.view addSubview:self.spinner];
    }
    [self.spinner startAnimating];
}

- (void)hideLoadingView
{
    [self.spinner applyFadeTransition];
    [self.spinner setHidden:YES];
}

@end
