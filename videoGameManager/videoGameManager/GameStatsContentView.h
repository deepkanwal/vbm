//
//  GameStatsContentView.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddedGame;

@interface GameStatsContentView : UIView
- (void)updateWithAddedGame:(AddedGame*)addedGame;
@end
