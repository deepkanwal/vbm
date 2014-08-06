//
//  NowPlayingViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-22.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "GameDetailsViewController.h"
#import "NowPlayingView.h"
#import "ImageWithCaptionView.h"
#import "AddedGame.h"
#import "UIHelper.h"
#import "NSFetchedResultsController+Additions.h"
#import "UIView+Additions.h"

#define kSEGUE_NOW_PLAYING_TO_GAME_DETAILS @"NowPlayingToGameDetailsSegue"

@interface NowPlayingViewController ()
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) CGSize nowPlayingViewSize;
@end

@implementation NowPlayingViewController

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
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:AddedGameAttributes.gameName ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:YES]];
    self.fetchedResultsController = [NSFetchedResultsController fetchResultsControllerForEntityName:AddedGame.entityName sortDescriptors:@[sort]];
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    [self.view setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
    
    [self.swipeView shiftToYOrigin:CGRectGetMaxY(self.navigationController.navigationBar.frame)];
    [self.swipeView setBackgroundColor:[UIColor clearColor]];
    [self.swipeView setAlignment:SwipeViewAlignmentCenter];
    [self.swipeView setPagingEnabled:YES];
    [self.swipeView setItemsPerPage:1];
    [self.swipeView setAlpha:0.95];
    
    [self.pageControl shiftToYOrigin:CGRectGetMaxY(self.swipeView.frame) - kUI_PADDING_10];
    [self.pageControl setCurrentPageIndicatorTintColor:kUI_COLOR_DEFAULT_TINT];
    
    [self.imageWithCaptionsView configureWithImageName:@"controller" caption:@"You have no games being played."];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nowPlayingViewSize = CGSizeMake(CGRectGetWidth(self.swipeView.bounds), CGRectGetHeight(self.swipeView.bounds));
    
    [self.fetchedResultsController performFetchRequest];
    [self.swipeView reloadData];
    
    [self.pageControl setNumberOfPages:self.fetchedResultsController.fetchedObjects.count];
    
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        [self.swipeView setHidden:YES];
        [self showImageViewWithCaption];
    } else {
        [self.swipeView setHidden:NO];
        [self hideImageViewWithCaption];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SwipeViewDataSource methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UIView*)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NowPlayingView *nowPlayingView = (NowPlayingView*)view;
    if (!nowPlayingView) {
        nowPlayingView = [[NowPlayingView alloc] init];
        [nowPlayingView resize:CGSizeMake(self.nowPlayingViewSize.width - 2 * kUI_PADDING_10, self.nowPlayingViewSize.height - 2 * kUI_PADDING_10)];
    }
    [nowPlayingView updateWithAddedGame:[self.fetchedResultsController.fetchedObjects objectAtIndex:index]];
    return nowPlayingView;
}

#pragma mark - SwipeViewDelegate methods

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.nowPlayingViewSize;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    [self performSegueWithIdentifier:kSEGUE_NOW_PLAYING_TO_GAME_DETAILS sender:nil];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [self.pageControl setCurrentPage:swipeView.currentPage];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSEGUE_NOW_PLAYING_TO_GAME_DETAILS]) {
        NSInteger index = self.swipeView.currentItemIndex;
        [segue.destinationViewController setDetailItem:[self.fetchedResultsController.fetchedObjects objectAtIndex:index]];
    }
}

@end
