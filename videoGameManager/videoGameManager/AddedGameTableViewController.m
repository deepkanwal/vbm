//
//  AddedGameTableViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "AddedGameTableViewController.h"
#import "GameDetailsViewController.h"
#import "GameTableViewCell.h"
#import "AddedGame.h"
#import "NSFetchedResultsController+Additions.h"

#define kSEGUE_ADDED_GAMES_TO_DETAILS @"AddedGamesToDetailsSegue"

@interface AddedGameTableViewController ()
@end

@implementation AddedGameTableViewController

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

    if (self.sortDescriptors.count == 0) {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:AddedGameAttributes.gameName ascending:YES selector:@selector(caseInsensitiveCompare:)];
        self.sortDescriptors = @[sort];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetchRequest];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *GameCellIdentifier = @"GameCell";
    
    GameTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:GameCellIdentifier];
    if (cell == nil) {
        cell = [[GameTableViewCell alloc] initWithReuseIdentifier:GameCellIdentifier];
    }
    
    AddedGame *game = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCellForAddedGame:game];
    [self updateColourOfCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGAME_TABLE_VIEW_CELL_HEIGHT;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSEGUE_ADDED_GAMES_TO_DETAILS sender:nil];
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSEGUE_ADDED_GAMES_TO_DETAILS]) {
        AddedGame *addedGame = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        [segue.destinationViewController setDetailItem:addedGame];
    }
}

@end
