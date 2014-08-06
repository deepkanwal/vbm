//
//  GameStatsContentView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GameStatsContentView.h"
#import "ProgressBarView.h"
#import "AddedGame.h"
#import "UIHelper.h"
#import "UIView+Additions.h"
#import "UILabel+Additions.h"

@interface GameStatsContentView ()
@property (weak, nonatomic) IBOutlet UILabel *progressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPlayingLabel;
@property (weak, nonatomic) IBOutlet UILabel *beatenLabel;
@property (weak, nonatomic) IBOutlet UILabel *favouriteLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *infoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (strong, nonatomic) UIView *dividerA;
@property (strong, nonatomic) UIView *dividerB;
@property (strong, nonatomic) UIView *dividerC;

@property (nonatomic, strong) ProgressBarView *progressBarView;
@end

@implementation GameStatsContentView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"GameStatsContentView"
                                          owner:nil
                                        options:nil] lastObject];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureSubviews];
}

- (void)configureSubviews
{
    self.progressBarView = [[ProgressBarView alloc] initWithFrame:CGRectMake(kUI_PADDING_10, 0, CGRectGetWidth(self.bounds) - 2 * kUI_PADDING_10, 30.0f)];
    [self.progressBarView shiftToYOrigin:CGRectGetMaxY(self.progressTitleLabel.frame) + kUI_PADDING_10];
    [self addSubview:self.progressBarView];
}

- (void)updateWithAddedGame:(AddedGame*)addedGame
{
    [self.progressBarView setProgress:addedGame.progressValue];
    [self.nowPlayingLabel setText:[NSString stringWithFormat:@"%@", addedGame.nowPlayingValue ? @"Yes" : @"No"]];
    [self.beatenLabel setText:[NSString stringWithFormat:@"%@", addedGame.isBeatenValue ? @"Yes" : @"No"]];
    [self.favouriteLabel setText:[NSString stringWithFormat:@"%@", addedGame.isFavouriteValue ? @"Yes" : @"No"]];
    [self.notesLabel setText:addedGame.notes.length > 0 ? addedGame.notes : @"No Notes"];
    [self.notesLabel sizeToFitWithWidthConserved];
    
    if (addedGame.ratingValue == 0) {
        [self.ratingLabel setText:@"Unrated"];
    } else {
        [self.ratingLabel setText:[NSString stringWithFormat:@"%d / 10", addedGame.ratingValue]];
    }
    
    [self updateSubviews];
}

- (void)updateSubviews
{
    if (self.dividerA) {
        [self.dividerA removeFromSuperview];
    }
    self.dividerA = [UIHelper addDividerBelowView:self.progressBarView inView:self];
    [self.infoTitleLabel shiftToYOrigin:CGRectGetMaxY(self.progressBarView.frame) + kUI_PADDING_20];
    [self.infoView shiftToYOrigin:CGRectGetMaxY(self.infoTitleLabel.frame) + kUI_PADDING_5];
    
    if (self.dividerB) {
        [self.dividerB removeFromSuperview];
    }
    self.dividerB = [UIHelper addDividerBelowView:self.infoView inView:self];
    [self.notesTitleLabel shiftToYOrigin:CGRectGetMaxY(self.infoView.frame) + kUI_PADDING_20];
    [self.notesLabel shiftToYOrigin:CGRectGetMaxY(self.notesTitleLabel.frame) + kUI_PADDING_10];
    
    if (self.dividerC) {
        [self.dividerC removeFromSuperview];
    }
    self.dividerC = [UIHelper addDividerBelowView:self.notesLabel inView:self];
    [self.ratingTitleLabel shiftToYOrigin:CGRectGetMaxY(self.notesLabel.frame) + kUI_PADDING_20];
    [self.ratingLabel shiftToYOrigin:CGRectGetMaxY(self.ratingTitleLabel.frame) + kUI_PADDING_10];
    
    [self resizeHeight:CGRectGetMaxY(self.ratingLabel.frame) + kUI_PADDING_10];
}

@end
