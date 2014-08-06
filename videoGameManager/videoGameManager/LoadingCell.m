//
//  LoadingCell.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-01.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "LoadingCell.h"
#import "LoadingSpinner.h"
#import "UIHelper.h"
#import "UIView+Additions.h"

@interface LoadingCell ()
@property (nonatomic, strong) LoadingSpinner *spinner;
@end

@implementation LoadingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createSpinner];
    }
    return self;
}

- (void)createSpinner
{
    [self resizeHeight:kLOADING_CELL_HEIGHT];
    self.spinner = [[LoadingSpinner alloc] initWithFrame:self.bounds large:NO];
    [self addSubview:self.spinner];
}

- (void)startAnimating
{
    [self.spinner startAnimation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
