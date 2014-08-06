//
//  AddGameViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-06.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "AddGameViewController.h"
#import "SelectPlatformViewController.h"

#import "Game.h"
#import "AddedGame.h"
#import "AddedPlatform.h"
#import "CoreDataHelper.h"

#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.m"
#import "UIView+Additions.h"

// Row title constants
#define kROW_TITLE_PLATFORM @"Platform Owned On"

#define kROW_TITLE_OWNED_SINCE @"Owned Since"
#define kROW_TITLE_PROGRESS @"Completion Progress"
#define kROW_TITLE_RATING @"Rating"

#define kROW_TITLE_NOW_PLAYING @"Now Playing"
#define kROW_TITLE_BEATEN @"Main Game Beaten"
#define kROW_TITLE_FAVOURITE @"Favourite"

#define kROW_TITLE_NOTES @"Notes"
#define kROW_TITLE_RATING @"Rating"

#define kROW_TITLE_DELETE @"Delete"

#define kSEGUE_ADD_GAMES_TO_SELECT_PLATFORMS @"AddGamesToSelectPlatformsSegue"
#define kSEGUE_ADD_GAMES_TO_SELECT_PROGRESS @"AddGamesToProgressSegue"
#define kSEGUE_ADD_GAMES_TO_NOTES @"AddGamesToNotesSegue"
#define kSEGUE_ADD_GAMES_TO_SELECT_RATING @"AddGamesToRatingSegue"


typedef enum {
    AddGamesTableSectionPlatform = 0,
    AddGamesTableSectionProgress,
    AddGamesTableSectionBoolean,
    AddGamesTableSectionOther,
    AddGamesTableSectionDelete
} AddGamesTableSection;

@interface AddGameViewController ()

@property (nonatomic, strong) AddedGame *addedGame;
@property (nonatomic, strong) NSMutableArray *rowTitlesArray;
@property (nonatomic, assign) BOOL newGame;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AddGameViewController

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
	[self setupProperties];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupProperties
{
    if ([self.detailItem isKindOfClass:[Game class]]) {
        self.addedGame = [AddedGame createAddedGameForGame:self.detailItem inContext:[CoreDataHelper sharedContext]];
        self.newGame = YES;
    } else if ([self.detailItem isKindOfClass:[AddedGame class]]) {
        self.addedGame = (AddedGame*)self.detailItem;
        self.newGame = NO;
    }
    
    self.rowTitlesArray = [NSMutableArray arrayWithArray:@[
                                                           @[kROW_TITLE_PLATFORM],
                                                           @[kROW_TITLE_PROGRESS],
                                                           @[kROW_TITLE_NOW_PLAYING, kROW_TITLE_BEATEN, kROW_TITLE_FAVOURITE],
                                                           @[kROW_TITLE_NOTES, kROW_TITLE_RATING]
                                                           ]];
    
    if (!self.newGame) {
        [self.rowTitlesArray addObject:@[kROW_TITLE_DELETE]];
        self.title = @"Edit Game";
    }
    
    [self.tableView setUpHeaderWithTitle:self.addedGame.gameName title:YES];
    [self.tableView setupDefaultApperance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender
{
   [[CoreDataHelper sharedContext] rollback];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender
{
    if ([self validateForm]) {
        [CoreDataHelper saveCoreDataInContext:[CoreDataHelper sharedContext]];
        if (self.delegate) {
            [self.delegate toggleGameAdded:self.addedGame];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TableView Datasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* rowTitles = [self.rowTitlesArray objectAtIndex:section];
    return rowTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"AddGameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell formatAsGroupedCell];
    }
    
    [cell.textLabel setText:[[self.rowTitlesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    if ([self isSubtitleSection:indexPath.section]) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else if (indexPath.section == AddGamesTableSectionBoolean) {
        [self updateToggleCell:cell atIndexPath:indexPath selected:NO];
    } else if (indexPath.section == AddGamesTableSectionDelete) {
        [cell.textLabel setTextColor:[UIColor redColor]];
    } else {
        [cell.textLabel setTextColor:[UIColor darkTextColor]];
    }
    
    if ([self isSubtitleSection:indexPath.section]) {
        NSString *rowTitle = cell.textLabel.text;
        if ([rowTitle isEqualToString:kROW_TITLE_PLATFORM]) {
            NSArray *addedGames = [AddedGame getMatchesForGameId:self.addedGame.gameId andPlatform:[self.addedGame.platformsArray lastObject] inContext:[CoreDataHelper sharedContext]];
            if (self.addedGame.platform.name.length == 0 && self.addedGame.platformsArray.count == 1 && addedGames.count == 0) {
                [self.addedGame updateWithPlatformOfName:[self.addedGame.platformsArray lastObject] inContext:[CoreDataHelper sharedContext]];
            }
            [cell.detailTextLabel setText:self.addedGame.platform.name];
        } else if ([rowTitle isEqualToString:kROW_TITLE_PROGRESS]) {
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d %%", self.addedGame.progressValue]];
        } else if ([rowTitle isEqualToString:kROW_TITLE_NOTES]) {
            if (self.addedGame.notes.length == 0) {
                [cell.detailTextLabel setText:@"No Notes"];
            } else {
                [cell.detailTextLabel setText:self.addedGame.notes];
            }
        } else if ([rowTitle isEqualToString:kROW_TITLE_RATING]) {
            if (self.addedGame.ratingValue == 0) {
                [cell.detailTextLabel setText:@"Unrated"];
            } else {
                [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d/10", self.addedGame.ratingValue]];
            }
        }
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSEGUE_ADD_GAMES_TO_SELECT_PROGRESS] ||
        [segue.identifier isEqualToString:kSEGUE_ADD_GAMES_TO_NOTES] ||
        [segue.identifier isEqualToString:kSEGUE_ADD_GAMES_TO_SELECT_RATING]) {
        [segue.destinationViewController setDetailItem:self.addedGame];
    } else if ([segue.identifier isEqualToString:kSEGUE_ADD_GAMES_TO_SELECT_PLATFORMS]) {
        NSArray *arrayOfAddedGames = [AddedGame getMatchesForGameId:self.addedGame.gameId inContext:[CoreDataHelper sharedContext]];
        [segue.destinationViewController setAddedGame:self.addedGame];
        [segue.destinationViewController setArrayOfAddedGames:arrayOfAddedGames];
    }
}

#pragma mark - UITableViewDelegate methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *rowTitle = cell.textLabel.text;
    
    if ([self isSubtitleSection:indexPath.section]) {
        if ([rowTitle isEqualToString:kROW_TITLE_PLATFORM]) {
            [self performSegueWithIdentifier:kSEGUE_ADD_GAMES_TO_SELECT_PLATFORMS sender:nil];
        } else if ([rowTitle isEqualToString:kROW_TITLE_PROGRESS]) {
            [self performSegueWithIdentifier:kSEGUE_ADD_GAMES_TO_SELECT_PROGRESS sender:nil];
        } else if ([rowTitle isEqualToString:kROW_TITLE_NOTES]) {
            [self performSegueWithIdentifier:kSEGUE_ADD_GAMES_TO_NOTES sender:nil];
        } else if ([rowTitle isEqualToString:kROW_TITLE_RATING]) {
            [self performSegueWithIdentifier:kSEGUE_ADD_GAMES_TO_SELECT_RATING sender:nil];
        }
    } else if (indexPath.section == AddGamesTableSectionBoolean) {
        [self updateToggleCell:cell atIndexPath:indexPath selected:YES];
    }  else if (indexPath.section == AddGamesTableSectionDelete) {
        [self deletePressed];
    }
    
    [cell setSelected:NO animated:YES];
}

- (void)updateToggleCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath selected:(BOOL)isSelected
{
    NSString *rowTitle = cell.textLabel.text;
    BOOL showCheckmark = NO;
    
    if ([rowTitle isEqualToString:kROW_TITLE_BEATEN]) {
        if (isSelected) self.addedGame.isBeatenValue = !self.addedGame.isBeatenValue;
        showCheckmark = self.addedGame.isBeatenValue;
        
    } else if ([rowTitle isEqualToString:kROW_TITLE_NOW_PLAYING]) {
        if (isSelected) self.addedGame.nowPlayingValue = !self.addedGame.nowPlayingValue;
        showCheckmark = self.addedGame.nowPlayingValue;
        
    } else if ([rowTitle isEqualToString:kROW_TITLE_FAVOURITE]) {
        if (isSelected) self.addedGame.isFavouriteValue = !self.addedGame.isFavouriteValue;
        showCheckmark = self.addedGame.isFavouriteValue;
    }
    
    if (!showCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)deletePressed
{
    UIAlertView* confirmationAlertView = [[UIAlertView alloc] initWithTitle:@"Delete Game" message:[NSString stringWithFormat:@"Are you sure you want to delete %@.", self.addedGame.gameName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [confirmationAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        [AddedGame deleteAddedGame:self.addedGame inContext:[CoreDataHelper sharedContext]];
        [CoreDataHelper saveCoreDataInContext:[CoreDataHelper sharedContext]];
        if (self.delegate) {
            [self.delegate toggleGameAdded:NO];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)validateForm
{
    
    if (self.addedGame.platform.name.length == 0) {
        [self showInvalidAlertWithMessage:@"Please select a platform."];
        return NO;
    }
    
    return YES;
}


#pragma mark - helpers

- (BOOL)isSubtitleSection:(NSUInteger)index
{
    if (index == AddGamesTableSectionPlatform || index == AddGamesTableSectionProgress || index == AddGamesTableSectionOther) {
        return YES;
    }
    return NO;
}

@end
