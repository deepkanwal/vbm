//
//  FavouriteGamesViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-21.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "FavouriteGamesViewController.h"
#import "ImageWithCaptionView.h"
#import "AddedGame.h"
#import "NSFetchedResultsController+Additions.h"

@interface FavouriteGamesViewController ()

@end

@implementation FavouriteGamesViewController

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
    
    [self.imageWithCaptionsView configureWithImageName:@"favourite" caption:@"You have no favourite games."];
    self.fetchedResultsController = [NSFetchedResultsController fetchResultsControllerForEntityName:AddedGame.entityName sortDescriptors:self.sortDescriptors];
    [self.fetchedResultsController.fetchRequest setPredicate:self.predicate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        [self showImageViewWithCaption];
    } else {
        [self hideImageViewWithCaption];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
