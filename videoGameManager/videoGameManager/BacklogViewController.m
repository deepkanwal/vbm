//
//  BacklogViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-15.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BacklogViewController.h"
#import "AddedGame.h"
#import "GameDetailsViewController.h"
#import "ImageWithCaptionView.h"
#import "NSFetchedResultsController+Additions.h"
#import "UIView+Additions.h"

@interface BacklogViewController ()
@property (nonatomic, weak) IBOutlet UIBarButtonItem *toggleBacklogButton;
@property (nonatomic, assign) BOOL showingFullBacklog;
@property (nonatomic, strong) NSPredicate *backlogPredicate;
@property (nonatomic, strong) NSPredicate *fullBacklogPredicate;
@end

#define kSEGUE_BACKLOG_TO_DETAILS @"BacklogToDetailsSegue"

@implementation BacklogViewController

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
    
    self.backlogPredicate = [NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", AddedGameAttributes.isBeaten, [NSNumber numberWithBool:NO], AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:NO]];
    self.fullBacklogPredicate = [NSPredicate predicateWithFormat:@"%K != %@ AND %K = %@", AddedGameAttributes.progress, [NSNumber numberWithInteger:100], AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:NO]];
    
	NSArray *sortArray = @[[[NSSortDescriptor alloc] initWithKey:AddedGameAttributes.progress ascending:YES selector:@selector(compare:)]];
    self.fetchedResultsController = [NSFetchedResultsController fetchResultsControllerForEntityName:AddedGame.entityName sortDescriptors:sortArray];
    [self.fetchedResultsController.fetchRequest setPredicate:self.backlogPredicate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViewsForBacklog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewsForBacklog
{
    [self.navigationController.navigationBar applyFadeTransition];
    
    if (self.showingFullBacklog) {
        [self.navigationItem setTitle:@"Full Backlog"];
        [self.toggleBacklogButton setTitle:@"Basic"];
    } else {
        [self.navigationItem setTitle:@"Backlog"];
        [self.toggleBacklogButton setTitle:@"Full"];
    }
    
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        if (self.showingFullBacklog) {
            [self.imageWithCaptionsView configureWithImageName:@"controller" caption:@"You have no games in your full backlog."];
        } else {
            [self.imageWithCaptionsView configureWithImageName:@"controller" caption:@"You have no games in your backlog."];
        }
        [self showImageViewWithCaption];
    } else {
        [self hideImageViewWithCaption];
    }
}

#pragma mark - IBOutlets

- (IBAction)toggleBacklogButtonPressed:(id)sender {
    [self toggleBacklog];
}

- (void)toggleBacklog
{
    self.showingFullBacklog = !self.showingFullBacklog;
    
    if (self.showingFullBacklog) {
        [self.fetchedResultsController.fetchRequest setPredicate:self.fullBacklogPredicate];
    } else {
        [self.fetchedResultsController.fetchRequest setPredicate:self.backlogPredicate];
    }
    
    [self.fetchedResultsController performFetchRequest];
    [self updateViewsForBacklog];
    [self.tableView applyFadeTransition];
    [self.tableView reloadData];

}

@end
