//
//  NowPlayingView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-22.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "NowPlayingView.h"
#import "AddedGame.h"
#import "AddedPlatform.h"
#import "UIHelper.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+Additions.h"

@interface NowPlayingView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *detailsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *completionPercentage;
@property (weak, nonatomic) IBOutlet UILabel *platformLabel;
@end

@implementation NowPlayingView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"NowPlayingView"
                                          owner:nil
                                        options:nil] lastObject];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self applyBorderOfColor:kUI_COLOR_SEPERATOR_COLOR width:1.0f];
    [self applyRoundedCorners:7.0f];
    [self.coverImageView applyInnerShadow];

}

- (void)updateWithAddedGame:(AddedGame*)addedGame
{
    UIImage *placeHolder = [[UIImage imageNamed:@"cell_thumb"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)];

    [self.coverImageView setImageWithURL:[NSURL URLWithString:addedGame.coverImageMediumURLString] placeholderImage:placeHolder];
    [self.titleLabel setText:addedGame.gameName];
    [self.completionPercentage setText:[NSString stringWithFormat:@"%d%%", addedGame.progressValue]];
    [self.platformLabel setText:addedGame.platform.name];
}

- (void)flip
{
    
}

@end
