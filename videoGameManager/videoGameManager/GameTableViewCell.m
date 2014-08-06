//
//  GameTableViewCell.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GameTableViewCell.h"
#import "Game.h"
#import "AddedGame.h"
#import "AddedPlatform.h"

#import "UIHelper.h"
#import "UIView+Additions.h"
#import "UILabel+Additions.h"
#import "UIImageView+Additions.h"

@interface GameTableViewCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *rightContainerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *releaseYearLabel;
@property (nonatomic, strong) UILabel *platformLabel;
@end

@implementation GameTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializeCell
{
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kGAME_TABLE_VIEW_CELL_HEIGHT, kGAME_TABLE_VIEW_CELL_HEIGHT)];
    [self.coverImageView shiftToYCenter:floorf(kGAME_TABLE_VIEW_CELL_HEIGHT/2.0f)];
    [self.coverImageView setClipsToBounds:YES];
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:self.coverImageView];
    
    self.rightContainerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame) + kUI_PADDING_10, 0,
                                                                       CGRectGetWidth(self.bounds) - CGRectGetMaxX(self.coverImageView.frame) - 2 * kUI_PADDING_10, 0)];
    [self addSubview:self.rightContainerView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setNumberOfLines:2];
    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [self.nameLabel setLineBreakMode:(NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail)];
    [self.rightContainerView addSubview:self.nameLabel];

    self.releaseYearLabel = [[UILabel alloc] init];
    [self.releaseYearLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [self.releaseYearLabel setTextColor:[UIColor darkGrayColor]];
    [self.rightContainerView addSubview:self.releaseYearLabel];
    
    self.platformLabel = [[UILabel alloc] init];
    [self.platformLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [self.platformLabel setTextColor:[UIColor darkGrayColor]];
    [self.rightContainerView addSubview:self.platformLabel];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat maxWidth = CGRectGetWidth(self.rightContainerView.bounds);
    
    [self.nameLabel resizeLabelToFitMaxWidth:maxWidth];
    [self.releaseYearLabel resizeLabelToFitMaxWidth:maxWidth];
    [self.platformLabel resizeLabelToFitMaxWidth:maxWidth];
    
    [self.releaseYearLabel shiftToYOrigin:CGRectGetMaxY(self.nameLabel.frame) + 1.0f];
    
    if (self.releaseYearLabel.text.length > 0) {
        [self.platformLabel shiftToYOrigin:CGRectGetMinY(self.releaseYearLabel.frame)];
        [self.platformLabel shiftToXOrigin:CGRectGetMaxX(self.releaseYearLabel.frame)];
    } else {
        [self.platformLabel shiftToYOrigin:CGRectGetMaxY(self.nameLabel.frame) + 1.0f];
    }

    CGFloat height = CGRectGetHeight(self.nameLabel.bounds) + CGRectGetHeight(self.releaseYearLabel.bounds);
    [self.rightContainerView resizeHeight:height];
    [self.rightContainerView shiftToYCenter:floorf(kGAME_TABLE_VIEW_CELL_HEIGHT/2.0f)];
}

- (void)configureCellForGame:(Game*)game
{
    self.nameLabel.text = game.gameName;
    self.releaseYearLabel.text = game.releaseYear;
    self.platformLabel.text = @"";
    [self.coverImageView setImageWithURLString:game.coverImageThumbnailURLString placeHolderImageName:@"cell_thumb" fade:YES];
}

- (void)configureCellForAddedGame:(AddedGame*)game
{
    self.nameLabel.text = game.gameName;
    self.releaseYearLabel.text = [NSString stringWithFormat:@"%d%%", game.progressValue];
    self.platformLabel.text = [NSString stringWithFormat:@"  |  %@", game.platform.name];
    [self.coverImageView setImageWithURLString:game.coverImageThumbnailURLString placeHolderImageName:@"cell_thumb" fade:YES];
}

@end
