//
//  GameDetailsContentView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GameDetailsContentView.h"
#import "Game.h"
#import "UIHelper.h"
#import "UIView+Additions.h"
#import "UIImageView+Additions.h"
#import "UILabel+Additions.h"
#import "NSArray+Additions.h"

#define kRELATED_GAMES_CELL_IDENTIFIER @"RelatedGamesCell"
#define kRELATED_GAMES_CELL_HEIGHT 20
#define kIMAGES_SIZE CGSizeMake(120.0f, 120.0f)

@interface GameDetailsContentView ()
@property (weak, nonatomic) IBOutlet UILabel *platformsLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *developerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *developersLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *imagesTitleLabel;
@property (weak, nonatomic) IBOutlet SwipeView *imagesSwipeView;

@property (strong, nonatomic) Game* game;
@end

@implementation GameDetailsContentView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"GameDetailsContentView"
                                          owner:nil
                                        options:nil] lastObject];
    return self;
}


- (void)updateWithGame:(Game*)game
{
    self.game = game;
    [self updateViewsWithContent];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.imagesSwipeView setAlignment:SwipeViewAlignmentCenter];
    [self.imagesSwipeView setItemsPerPage:2];
    [self.imagesSwipeView setPagingEnabled:NO];
    [self.imagesSwipeView setWrapEnabled:NO];
    
//    [self.relatedGamesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kRELATED_GAMES_CELL_IDENTIFIER];
}

- (void)updateViewsWithContent
{
    [self.descriptionTitleLabel sizeToFitWithWidthConserved];
    [self.descriptionLabel setText:self.game.gameDescription];
    [self.descriptionLabel shiftToYOrigin:CGRectGetMaxY(self.descriptionTitleLabel.frame) + kUI_PADDING_10];
    [self.descriptionLabel sizeToFitWithWidthConserved];
    
    [UIHelper addDividerBelowView:self.descriptionLabel inView:self];
    
    CGFloat detailsYOrigin;
    
    if (self.game.thumbnailImages.count > 0) {
        
        [self.imagesTitleLabel shiftToYOrigin:CGRectGetMaxY(self.descriptionLabel.frame) + kUI_PADDING_20];
        [self.imagesSwipeView shiftToYOrigin:CGRectGetMaxY(self.imagesTitleLabel.frame) + kUI_PADDING_5];
        [UIHelper addDividerBelowView:self.imagesSwipeView inView:self];
        detailsYOrigin = CGRectGetMaxY(self.imagesSwipeView.frame);
        
    } else {
        [self.imagesTitleLabel setHidden:YES];
        [self.imagesSwipeView setHidden:YES];
        detailsYOrigin = CGRectGetMaxY(self.descriptionLabel.frame);
    }
    
    [self.detailsTitleLabel shiftToYOrigin:detailsYOrigin + kUI_PADDING_15];
    
    [self.publisherTitleLabel shiftToYOrigin:CGRectGetMaxY(self.detailsTitleLabel.frame) + kUI_PADDING_10];
    [self.publisherTitleLabel sizeToFitWithWidthConserved];
    [self.pubisherLabel shiftToYOrigin:CGRectGetMinY(self.publisherTitleLabel.frame)];
    [self.pubisherLabel setText:[self commaSeperatedStringWithNilCheckForArray:self.game.publishers]];
    [self.pubisherLabel sizeToFitWithWidthConserved];
    
    [self.developerTitleLabel shiftToYOrigin:CGRectGetMaxY(self.pubisherLabel.frame) + kUI_PADDING_5];
    [self.developerTitleLabel sizeToFitWithWidthConserved];
    [self.developersLabel shiftToYOrigin:CGRectGetMinY(self.developerTitleLabel.frame)];
    [self.developersLabel setText:[self commaSeperatedStringWithNilCheckForArray:self.game.developers]];
    [self.developersLabel sizeToFitWithWidthConserved];
    
    [self.platformsTitleLabel shiftToYOrigin:CGRectGetMaxY(self.developersLabel.frame) + kUI_PADDING_5];
    [self.platformsTitleLabel sizeToFitWithWidthConserved];
    [self.platformsLabel shiftToYOrigin:CGRectGetMinY(self.platformsTitleLabel.frame)];
    [self.platformsLabel setText:[self commaSeperatedStringWithNilCheckForArray:self.game.platforms]];
    [self.platformsLabel sizeToFitWithWidthConserved];
    
    [self.genresTitleLabel shiftToYOrigin:CGRectGetMaxY(self.platformsLabel.frame) + kUI_PADDING_5];
    [self.genresTitleLabel sizeToFitWithWidthConserved];
    [self.genresLabel shiftToYOrigin:CGRectGetMinY(self.genresTitleLabel.frame)];
    [self.genresLabel setText:[self commaSeperatedStringWithNilCheckForArray:self.game.genres]];
    [self.genresLabel sizeToFitWithWidthConserved];
    
    //    [UIHelper addDividerBelowView:self.genresLabel inView:self.contentView];
    //
    //    [self.relatedGamesTitleLabel shiftToYOrigin:CGRectGetMaxY(self.genresLabel.frame) + kUI_PADDING_20];
    //    [self.relatedGamesTableView shiftToYOrigin:CGRectGetMaxY(self.relatedGamesTitleLabel.frame) + kUI_PADDING_10];
    //    [self.relatedGamesTableView resizeHeight:kRELATED_GAMES_CELL_HEIGHT * self.game.relatedGames.count];
    
    [self resizeHeight:CGRectGetMaxY(self.genresLabel.frame) + kUI_PADDING_15];
    
    [self.imagesSwipeView reloadData];
    
//    [self.relatedGamesTableView reloadData];
}

#pragma mark - SwipeViewDataSource methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.game.thumbnailImages.count;
}

- (UIView*)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *thumbImage = (UIImageView*)view;
    if (!thumbImage) {
        thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kIMAGES_SIZE.width, kIMAGES_SIZE.height)];
        [thumbImage setContentMode:UIViewContentModeScaleAspectFill];
        [thumbImage setClipsToBounds:YES];
        [thumbImage applyBorder];
    }
    [thumbImage setImageWithURLString:[self.game.thumbnailImages objectAtIndex:index] placeHolderImageName:@"image_placeholder" fade:YES];
    return thumbImage;
}

#pragma mark - SwipeViewDelegate methods

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(kIMAGES_SIZE.width + 20.0f, kIMAGES_SIZE.height);
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate) {
        [self.delegate imageSelectedAtIndex:index];
    }
}

#pragma mark - Helpers

- (NSString*)commaSeperatedStringWithNilCheckForArray:(NSArray*)array
{
    return ((array.count == 0) ? @"N/A" : [array commaSeperatedString]);
}

//#pragma mark - UITableViewDataSource methods
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return kRELATED_GAMES_CELL_HEIGHT;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.game.relatedGames.count;
//}
//
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UITableViewCell *cell = [self.relatedGamesTableView dequeueReusableCellWithIdentifier:kRELATED_GAMES_CELL_IDENTIFIER forIndexPath:indexPath];
//    [cell formatAsRelatedGamesCell];
//    
//    Game *relatedGame = [self.game.relatedGames objectAtIndex:indexPath.row];
//    [cell.textLabel setText:relatedGame.gameName];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    return cell;
//}

@end
