//
//  UITableViewCell+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-31.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UITableViewCell+Additions.h"
#import "UIHelper.h"

@implementation UITableViewCell (Additions)

- (void)formatAsRelatedGamesCell
{
    [self.textLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.textLabel setTextColor:[UIColor darkTextColor]];
}

- (void)formatAsGroupedCell
{
    [self.textLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.detailTextLabel setFont:[UIFont systemFontOfSize:13.0f]];
}

- (void)formatAsPickerCell
{
    [self.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self setIndentationLevel:1];
    [self setIndentationWidth:kUI_PADDING_20];
}

@end
