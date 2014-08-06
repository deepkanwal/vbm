//
//  GameTableViewCell.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGAME_TABLE_VIEW_CELL_HEIGHT 60.0f

@class Game, AddedGame;

@interface GameTableViewCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureCellForGame:(Game*)game;
- (void)configureCellForAddedGame:(AddedGame*)game;


@end
