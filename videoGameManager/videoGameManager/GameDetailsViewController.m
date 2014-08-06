//
//  GameDetailsViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GameDetailsViewController.h"
#import "CoverArtViewController.h"
#import "GameStatsContentView.h"
#import "LoadingSpinner.h"
#import "Game.h"
#import "AddedGame.h"
#import "AddedPlatform.h"

#import "GiantBombAPI.h"

#import "UIHelper.h"
#import "CoreDataHelper.h"
#import "UILabel+Additions.h"
#import "UIView+Additions.h"
#import "UIScrollView+Additions.h"
#import "NSArray+Additions.h"
#import "UITableViewCell+Additions.h"
#import "UIImageView+Additions.h"

#define kSEGUE_RELATED_GAMES_TO_DETAILS_VIEW @"RelatedGamesToDetailsSegue"
#define kSEGUE_DETAILS_VIEW_TO_PHOTO_VIEWER @"GameDetailsToImageViewerSegue"
#define kSEGUE_DETAILS_VIEW_TO_ADD_GAME @"GameDetailsToAddGameSegue"

typedef enum {
    SegmentedControlSelectionDetails = 0,
    SegmentedControlSelectionStats
} SegmentedControlSelection;

@interface GameDetailsViewController ()

@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) AddedGame* addedGame;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addGameBarButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *showMediumCoverButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (strong, nonatomic) GameDetailsContentView *gameDetailsContentView;
@property (strong, nonatomic) GameStatsContentView *gameStatsContentView;
@property (strong, nonatomic) LoadingSpinner *spinner;

@end

@implementation GameDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
     self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.contentScrollView setInitialPositionBelowNavigationBar:self.navigationController.navigationBar];
    
    [self setupProperties];
    [self setupSubviews];
    [self fetchGameDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupProperties
{
    self.gameDetailsContentView = [[GameDetailsContentView alloc] init];
    [self.gameDetailsContentView shiftToYOrigin:CGRectGetMaxY(self.headerView.frame)];
    [self.contentScrollView addSubview:self.gameDetailsContentView];
    self.gameDetailsContentView.delegate = self;

    self.gameStatsContentView = [[GameStatsContentView alloc] init];
    [self.gameStatsContentView shiftToYOrigin:CGRectGetMaxY(self.headerView.frame)];
    [self.contentScrollView addSubview:self.gameStatsContentView];
    [self.gameStatsContentView setHidden:YES];
    
    if ([self.detailItem isKindOfClass:[Game class]]) {
        [self configureForGame:self.detailItem];
    } else if ([self.detailItem isKindOfClass:[AddedGame class]]) {
        [self configureForAddedGame:self.detailItem];
    }
    
    [self.segmentedControl setSelectedSegmentIndex:SegmentedControlSelectionDetails];
    
    [self.addGameBarButton setEnabled:NO];
    [self.segmentedControl setEnabled:NO];

}

- (void)configureForGame:(Game*)game
{
    self.game = game;
    self.addedGame = nil;
    [self.platformLabel setHidden:YES];
    [self.addGameBarButton setTitle:@"Add"];
    [self.segmentedControl setSelectedSegmentIndex:SegmentedControlSelectionDetails];
}

- (void)configureForAddedGame:(AddedGame*)addedGame
{
    if (self.fromSearch) {
        return;
    }
    
    self.addedGame = addedGame;
    self.game = [addedGame getGame];
    [self.platformLabel setText:addedGame.platform.name];
    [self.platformLabel setHidden:NO];
    [self updatePlatformLabel];
    
    [self.addGameBarButton setTitle:@"Edit"];
    [self.gameStatsContentView updateWithAddedGame:self.addedGame];
}

- (void)setupSubviews
{
    [self.gameDetailsContentView setHidden:YES];
    
    [self.segmentedControl setTintColor:kUI_COLOR_DEFAULT_TINT];
    
    [self.contentScrollView setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
    [self.contentScrollView setFrame:self.view.bounds];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    [self.contentScrollView setScrollIndicatorInsets:self.contentScrollView.contentInset];
    
    self.spinner = [[LoadingSpinner alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), CGRectGetWidth(self.view.bounds), 200.0f) large:NO];
    [self.spinner setHidden:YES];
    [self.contentScrollView addSubview:self.spinner];
    
    [self setUpHeaderView];
    
    [self.imageWithCaptionsView configureWithImageName:@"plus" caption:[NSString stringWithFormat:@"The Stats screen can be accessed once you add a game and view it from the Now Playing, Backlog or Library sections of the app."]];
    [self.imageWithCaptionsView shiftToYOrigin:CGRectGetMaxY(self.headerView.frame) + 30.0f];
    [self.imageWithCaptionsView setDelegate:self];
    [self.contentScrollView addSubview:self.imageWithCaptionsView];
    
    [self showAppropriateContentView];

}

- (void)fetchGameDetails
{
    if (self.addedGame && !self.addedGame.isMissingDataValue) {
        [self showDetails];
    } else {
        [self.gameDetailsContentView setHidden:YES];
        [self showLoadingView];
    }
    
    [GiantBombAPI fetchDetailsFor:self.game results:^(BOOL isSuccess) {
        if (isSuccess) {
            if (self.addedGame && self.addedGame.isMissingDataValue) {
                [self.addedGame updateWithGame:self.game saveContext:YES];
                [self showDetails];
            } else if (self.addedGame) {
                [self.addedGame updateWithGame:self.game saveContext:YES];
            } else {
                [self showDetails];
            }
        } else {
            if (!self.addedGame) [self showAlertViewWithTitle:@"Error" andMessage:@"Could not fetch game details."];
        }
        [self hideLoadingView];
    }];
}

- (void)showDetails
{
    [self.gameDetailsContentView applyFadeTransition];
    [self.addGameBarButton setEnabled:YES];
    [self.segmentedControl setEnabled:YES];
    [self updateViewsWithContent];
    if (self.segmentedControl.selectedSegmentIndex == SegmentedControlSelectionDetails) [self.gameDetailsContentView setHidden:NO];
}

- (void)updateViewsWithContent
{
    [self.showMediumCoverButton setAutoresizingMask:UIViewAutoresizingNone];
    if (self.game.coverImageThumbnailURLString.length == 0 || self.game.coverImageMediumURLString.length == 0) {
        [self.showMediumCoverButton setHidden:YES];
    }
    
    [self.gameDetailsContentView updateWithGame:self.game];
    
    if (self.segmentedControl.selectedSegmentIndex == SegmentedControlSelectionDetails) {
        [self.contentScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.gameDetailsContentView.frame) + kUI_PADDING_10)];
    }

}

- (void)setUpHeaderView
{
    [self.nameLabel setText:self.game.gameName];
    [self.nameLabel sizeToFitWithMaxHeight:50.0f];
    
    [self.nameLabel adjustFontSizeToFitWithMinFontSize:12.0f];
    
    [self.releaseYearLabel setText:self.game.releaseYear];
    [self.releaseYearLabel sizeToFit];
    [self.releaseYearLabel shiftToYOrigin:CGRectGetMaxY(self.nameLabel.frame) + 2.0f];
    
    [self updatePlatformLabel];
    
    [self.coverImageView setAutoresizingMask:UIViewAutoresizingNone];
    [self.coverImageView setImageWithURLString:self.game.coverImageThumbnailURLString placeHolderImageName:@"details_thumb" fade:NO];
    [self.coverImageView applyBorder];
}

- (void)updatePlatformLabel
{
    [self.platformLabel sizeToFit];
    if (self.releaseYearLabel.text.length > 0) {
        [self.platformLabel shiftToYOrigin:CGRectGetMaxY(self.releaseYearLabel.frame) + 2.0f];
    } else {
        [self.platformLabel shiftToYOrigin:CGRectGetMaxY(self.nameLabel.frame) + 2.0f];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GameDetailsToCoverArtSegue"]) {
        [(CoverArtViewController*)segue.destinationViewController setUrlString:self.game.coverImageMediumURLString];
//    } else if ([segue.identifier isEqualToString:kSEGUE_RELATED_GAMES_TO_DETAILS_VIEW]){
//        Game *relatedGame = [self.game.relatedGames objectAtIndex:[self.relatedGamesTableView indexPathForSelectedRow].row];
//        [self.relatedGamesTableView deselectRowAtIndexPath:[self.relatedGamesTableView indexPathForSelectedRow] animated:YES];
//        [segue.destinationViewController setDetailItem:relatedGame];
    } else if ([segue.identifier isEqualToString:kSEGUE_DETAILS_VIEW_TO_PHOTO_VIEWER]) {
        NSInteger index = [(NSNumber*)sender integerValue];
        [(CoverArtViewController*)segue.destinationViewController setUrlString:[self.game.largeImages objectAtIndex:index]];
    } else if ([segue.identifier isEqualToString:kSEGUE_DETAILS_VIEW_TO_ADD_GAME]) {
        AddGameViewController *addGameViewController = (AddGameViewController*)[((UINavigationController*)segue.destinationViewController).viewControllers objectAtIndex:0];
        [addGameViewController setDelegate:self];
        if (self.addedGame) {
            [addGameViewController setDetailItem:self.addedGame];
        } else {
            [addGameViewController setDetailItem:self.game];
        }
    }
}


- (IBAction)actionSelectAddOrEditBarButton:(id)sender {
        
    [self performSegueWithIdentifier:kSEGUE_DETAILS_VIEW_TO_ADD_GAME sender:nil];
}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSEGUE_RELATED_GAMES_TO_DETAILS_VIEW sender:nil];
}

#pragma mark - Outlets

- (IBAction)segmentedControllerSelected:(id)sender {
    [self showAppropriateContentView];
}

- (void)showAppropriateContentView
{
    if (self.segmentedControl.selectedSegmentIndex == SegmentedControlSelectionDetails) {
        [self hideImageViewWithCaption];
        [self.gameStatsContentView applyFadeTransition];
        [self.gameStatsContentView setHidden:YES];
        [self.gameDetailsContentView applyFadeTransition];
        [self.gameDetailsContentView setHidden:NO];
        [self.contentScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.gameDetailsContentView.frame) + kUI_PADDING_10)];
    } else {
        [self.gameDetailsContentView applyFadeTransition];
        [self.gameDetailsContentView setHidden:YES];
        if (self.addedGame) {
            [self hideImageViewWithCaption];
            [self.gameStatsContentView applyFadeTransition];
            [self.gameStatsContentView setHidden:NO];
        } else {
            [self showImageViewWithCaption];
        }
        [self.contentScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.gameStatsContentView.frame) + kUI_PADDING_10)];
    }
}

#pragma mark - LoadingView methods

- (void)showLoadingView
{
//    [self.spinner applyFadeTransition];
    [self.spinner setHidden:NO];
    [self.spinner startAnimation];
}

- (void)hideLoadingView
{
//    [self.spinner applyFadeTransition];
    [self.spinner stopAnimation];
    [self.spinner setHidden:YES];
}

#pragma mark - AddGameViewControllerDelegate

- (void)toggleGameAdded:(AddedGame*)addedGame
{
    if (addedGame) {
        if (!self.addedGame) {
            [self showToastWithMessage:@"Added Game"];
        }
        [self configureForAddedGame:addedGame];
    } else {
        if (self.addedGame) {
            [self showToastWithMessage:@"Deleted Game"];
        }
        [self configureForGame:self.game];
    }
    [self showAppropriateContentView];
}

#pragma mark - GameDetailsContentViewDelegate

- (void)imageSelectedAtIndex:(NSInteger)index
{
    [self performSegueWithIdentifier:kSEGUE_DETAILS_VIEW_TO_PHOTO_VIEWER sender:[NSNumber numberWithInteger:index]];
}

#pragma mark - ImageWithCaptionViewDelegate

- (void)imageButtonPressed
{
    NSArray *addedGames = [AddedGame getMatchesForGameId:self.game.gameId inContext:[CoreDataHelper sharedContext]];
    
    if (addedGames.count == self.game.platforms.count) {
        [self showToastWithMessage:@"This game has already been added to all avaliable platforms."];
        return;
    }
    
    [self performSegueWithIdentifier:kSEGUE_DETAILS_VIEW_TO_ADD_GAME sender:nil];
}

@end
