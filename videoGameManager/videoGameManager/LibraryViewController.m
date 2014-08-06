//
//  LibraryViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryGamesViewController.h"
#import "AddedGameTableViewController.h"
#import "ImageWithCaptionView.h"
#import "AddedPlatform.h"
#import "AddedGame.h"
#import "UITableViewCell+Additions.h"
#import "UITableView+Additions.h"
#import "NSFetchedResultsController+Additions.h"


#define kSEGUE_LIBRARY_TO_ADDED_GAMES @"LibraryToAddedGamesSegue"
#define kSEGUE_LIBRARY_TO_FAVOURITE_GAMES @"LibraryToFavouriteGamesSegue"

@interface LibraryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, assign) NSInteger numberOfFavourites;
@end

@implementation LibraryViewController

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
    
    [self.tableView setupDefaultApperance];
    
    [self.imageWithCaptionsView configureWithImageName:@"controller" caption:@"You have no games in your library."];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:AddedPlatformAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)];
	self.fetchedResultsController = [NSFetchedResultsController fetchResultsControllerForEntityName:AddedPlatform.entityName sortDescriptors:@[sort]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetchRequest];
    [self.tableView reloadData];
    self.numberOfFavourites = [AddedGame getFavouriteGames].count;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.fetchedResultsController.fetchedObjects.count > 0) return 2;
    else return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return self.fetchedResultsController.fetchedObjects.count;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"PlatformCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell formatAsGroupedCell];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.section == 0) {
        AddedPlatform* platform = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [cell.textLabel setText:platform.name];
        [cell.detailTextLabel setText:[platform.count stringValue]];
    } else {
        [cell.textLabel setText:@"Favourites"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld", (long)self.numberOfFavourites]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:kSEGUE_LIBRARY_TO_ADDED_GAMES sender:nil];
    } else {
        [self performSegueWithIdentifier:kSEGUE_LIBRARY_TO_FAVOURITE_GAMES sender:nil];
    }
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSEGUE_LIBRARY_TO_ADDED_GAMES]) {
        AddedPlatform *addedPlatform = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"platform.name = %@", addedPlatform.name];
        [(LibraryGamesViewController*)segue.destinationViewController setPlatformName:addedPlatform.name];
        [(LibraryGamesViewController*)segue.destinationViewController setPredicate:predicate];
    } else if ([segue.identifier isEqualToString:kSEGUE_LIBRARY_TO_FAVOURITE_GAMES]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedGameAttributes.isFavourite, [NSNumber numberWithBool:YES]];
        [(AddedGameTableViewController*)segue.destinationViewController setPredicate:predicate];
    }
}

@end
