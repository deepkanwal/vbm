//
//  GeneralStatsViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/11/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GeneralStatsViewController.h"
#import "UIHelper.h"
#import "AddedGame.h"

@interface GeneralStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numOfGamesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numNowPlayingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numBacklogLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFullBacklog;
@property (weak, nonatomic) IBOutlet UILabel *overallProgressLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numGamesBeaten;


@end

@implementation GeneralStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   [self populateStats];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.view setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateStats
{
    NSArray *results = [AddedGame getAllGames];
    NSInteger numOfGames = 0, numNowPlaying = 0, numBacklog = 0, numFullBacklog = 0, numGamesBeaten = 0, numGamesRated = 0, numTotalProgress = 0;
    CGFloat totalRating = 0;
    
    
    for (AddedGame *game in results) {
        numOfGames++;
        numTotalProgress += game.progressValue;
        if (game.nowPlayingValue) numNowPlaying++;
        if (game.isBeatenValue) numGamesBeaten++;
        if (!game.nowPlayingValue && !game.isBeatenValue) numBacklog++;
        if (!game.nowPlayingValue && game.progressValue < 100) numFullBacklog ++;
        if (game.ratingValue > 0) {
            numGamesRated++;
            totalRating += game.ratingValue;
        }
    }
    
    CGFloat averageProgress = numOfGames > 0 ? floorf((CGFloat)numTotalProgress / numOfGames) : 0;
    CGFloat averageRating = (CGFloat)totalRating / numGamesRated;
    
    [self.numBacklogLabel setText:[NSString stringWithFormat:@"%ld / %ld", (long)numBacklog, (long)numOfGames]];
    [self.numFullBacklog setText:[NSString stringWithFormat:@"%ld / %ld", (long)numFullBacklog, (long)numOfGames]];
    [self.numGamesBeaten setText:[NSString stringWithFormat:@"%ld / %ld", (long)numOfGames, (long)numOfGames]];
    [self.numNowPlayingLabel setText:[NSString stringWithFormat:@"%ld / %ld", (long)numNowPlaying, (long)numOfGames]];
    [self.numGamesBeaten setText:[NSString stringWithFormat:@"%ld / %ld", (long)numGamesBeaten, (long)numOfGames]];
    [self.averageRatingLabel setText:numGamesRated > 0 ? [NSString stringWithFormat:@"%.2f / 10", averageRating] : @"N/A"];
    [self.overallProgressLabel setText:[NSString stringWithFormat:@"%.0f %%", averageProgress]];
}

@end
