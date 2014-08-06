//
//  SearchViewController.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "SearchViewController.h"
#import "GameTableViewCell.h"
#import "GameDetailsViewController.h"
#import "LoadingCell.h"
#import "ImageWithCaptionView.h"

#import "Game.h"
#import "GameList.h"
#import "AddedGame.h"

#import "GiantBombAPI.h"
#import "UIHelper.h"
#import "NetworkingHelper.h"
#import "CoreDataHelper.h"
#import "UIScrollView+Additions.h"
#import "UIView+Additions.h"
#import "AFHTTPClient.h"

#define kSEARCH_BAR_EDGE_PADDING 5
#define kSEARCH_BAR_HEIGHT 35

#define kSEARCH_TO_DETAILS_SEGUE_IDENTIFIER @"SearchToGameDetailsSegue"

@interface SearchViewController ()

@property (nonatomic, strong) GameList* gameList;
@property (nonatomic, assign) BOOL isLoadingItems;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSString* currentSearchTerm;
@property (nonatomic, strong) NSMutableArray *canceledOperations;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSearchBar];
    self.title = @"Add Games";
    self.gameList = [[GameList alloc] init];
    [self initializeProperties];
    
    [self.imageWithCaptionsView configureWithImageName:@"search" caption:[NSString stringWithFormat:@"Search for a game to add it."]];
    [self showImageViewWithCaption];
}

- (void)initializeProperties
{
    self.isLoadingItems = NO;
    self.currentPage = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((self.isLoadingItems || ![self allItemsLoaded]) && self.gameList.countOfGameList != 0) {
        return [self.gameList countOfGameList] + 1;
    } else {
        return [self.gameList countOfGameList];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *GameCellIdentifier = @"GameCell";
    static NSString *LoadCellIdentifier = @"LoadCell";
    
    if (indexPath.row != self.gameList.countOfGameList) {
        
        GameTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:GameCellIdentifier];
        if (cell == nil) {
            cell = [[GameTableViewCell alloc] initWithReuseIdentifier:GameCellIdentifier];
        }
        
        Game *game = [self.gameList gameAtIndex:indexPath.row];
        [cell configureCellForGame:game];
        [self updateColourOfCell:cell atIndexPath:indexPath];
        return cell;
        
    } else {
        if ([self shouldLoadNextPage:indexPath.row]) {
            [self getNextPageOfGames];
        }
        LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellIdentifier];
        if (cell == nil) {
            cell = [[LoadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadCellIdentifier];
        }
        [cell setUserInteractionEnabled:NO];
        [cell startAnimating];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != self.gameList.countOfGameList) {
        return kGAME_TABLE_VIEW_CELL_HEIGHT;
    } else if (self.gameList.countOfGameList != 0){
        return kLOADING_CELL_HEIGHT;
    } else {
        return 0.0f;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.gameList.countOfGameList) {
        [self performSegueWithIdentifier:kSEARCH_TO_DETAILS_SEGUE_IDENTIFIER sender:self];
    }
}

#pragma mark - SearchBar delagate methods


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [super searchBarSearchButtonClicked:searchBar];
    self.currentPage = 1;
    [self getGameDataFromSearchTerm:searchBar.text withPage:self.currentPage];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
}

#pragma mark - Helper methods

- (BOOL)allItemsLoaded
{
    if ([self.gameList countOfGameList] == self.gameList.totalCount) {
        return YES;
    }
    return NO;
}

- (BOOL)shouldLoadNextPage:(NSUInteger)row
{
    if (![self allItemsLoaded] && row == [self.gameList countOfGameList] && self.gameList.countOfGameList != 0) {
        return YES;
    }
    return NO;
}

#pragma mark - API Calls

- (void)getGameDataFromSearchTerm:(NSString*)searchTerm withPage:(NSUInteger)page
{
    if (self.isLoadingItems && ![searchTerm isEqualToString:self.currentSearchTerm] && self.currentSearchTerm.length > 0) {
        [GiantBombAPI cancelOperations];
        self.isLoadingItems = NO;
        [self.canceledOperations addObject:self.currentSearchTerm];
    }
    
    if (!self.isLoadingItems) {
        self.isLoadingItems = YES;
//        [self.searchBar applyFadeTransition];
//        [self.searchBar setAlpha:0.5];
        
        if (![searchTerm isEqualToString:self.currentSearchTerm]) {
            [self hideImageViewWithCaption];
            self.currentSearchTerm =  searchTerm;
            [self.tableView setScrollEnabled:YES];
            self.currentPage = 1;
            [self.gameList deleteAllGames];
            [self.tableView applyFadeTransition];
            [self.tableView reloadData];
            [self showLoadingView];
        }
        
        [GiantBombAPI fetchGameDataForSearchTerm:searchTerm withLimit:kSEARCH_ITEMS_PER_PAGE page:page results:
         ^(NSArray *results, BOOL isSuccess, NSUInteger totalCount) {
             
             if ([self.canceledOperations containsObject:searchTerm]) {
                 [self.canceledOperations removeObject:searchTerm];
                 return;
             } else if (isSuccess) {
                 
                 if (page == 1) {
                     [self.gameList updateWithNewGamesArray:results];
                     self.gameList.totalCount = totalCount;
                 } else {
                     [self.gameList appendGamesArray:results];
                 }
                 
                 NSLog(@"Search results: total = %lu, page %lu = %lu", (unsigned long)totalCount, (unsigned long)self.currentPage, (unsigned long)[results count]);
                 
                 if ([self.gameList countOfGameList] < self.gameList.totalCount && results.count != 0) {
                     self.currentPage = self.currentPage + 1;
                 }
                 
                 if (results.count == 0 && self.gameList.countOfGameList < kSEARCH_ITEMS_PER_PAGE) {
                     self.gameList.totalCount = self.gameList.countOfGameList;
                 }
                 
                 static NSInteger infiniteReqestGaurd = 0;
                 if (results.count == 0) {
                     infiniteReqestGaurd++;
                 } else {
                     infiniteReqestGaurd = 0;
                 }
                 
                 if (infiniteReqestGaurd == 3) {
                     self.gameList.totalCount = self.gameList.countOfGameList;
                 }
                 
                 if ([self.gameList countOfGameList] == 0) {
                     [self.imageWithCaptionsView configureWithImageName:@"search" caption:[NSString stringWithFormat:@"No results found for '%@'.", searchTerm]];
                     [self showImageViewWithCaption];
                     [self.tableView setScrollEnabled:NO];
                 }
                 self.isLoadingItems = NO;
                  [self.tableView reloadData];
             } else {
                 if (page == 1) {
                     [self showAlertViewWithTitle:@"Error" andMessage:@"Couldn't complete the search."];
                     self.currentSearchTerm = nil;
                 }
             }
             
             self.isLoadingItems = NO;
             [self hideLoadingView];
//             [self.searchBar applyFadeTransition];
//             [self.searchBar setAlpha:1.0];
         }];
    }
}

- (void)getNextPageOfGames
{
    if (!self.isLoadingItems) {
        [self getGameDataFromSearchTerm:self.currentSearchTerm withPage:self.currentPage];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Game *game = [self.gameList gameAtIndex:[self.tableView indexPathForSelectedRow].row];
    if ([[segue identifier] isEqualToString:kSEARCH_TO_DETAILS_SEGUE_IDENTIFIER]) {
//        AddedGame *addedGame = [AddedGame getAddedGameForGameId:game.gameId inContext:[CoreDataHelper sharedContext]];
        GameDetailsViewController *gameDetailsViewController = (GameDetailsViewController*)[segue destinationViewController];
//        if (addedGame) {
//            [(GameDetailsViewController*)[segue destinationViewController] setDetailItem:addedGame];
//        } else {
        [gameDetailsViewController setDetailItem:game];
        [gameDetailsViewController setFromSearch:YES];
//        }
    }
    
}

#pragma mark - Other

- (NSMutableArray*)canceledOperations
{
    if (!_canceledOperations) {
        _canceledOperations = [[NSMutableArray alloc] init];
    }
    return _canceledOperations;
}

@end
