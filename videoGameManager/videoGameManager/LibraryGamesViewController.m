//
//  LibraryGamesViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-15.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "LibraryGamesViewController.h"
#import "NSFetchedResultsController+Additions.h"
#import "AddedGame.h"

@interface LibraryGamesViewController ()

@end

@implementation LibraryGamesViewController

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
    
    [self.navigationItem setTitle:self.platformName];
    
    self.fetchedResultsController = [NSFetchedResultsController fetchResultsControllerForEntityName:AddedGame.entityName sortDescriptors:self.sortDescriptors];
    [self.fetchedResultsController.fetchRequest setPredicate:self.predicate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.tableView numberOfRowsInSection:0] == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
