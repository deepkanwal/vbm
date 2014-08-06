//
//  GameDetailsContentView.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@class Game;

@protocol GameDetailsContentViewDelegate <NSObject>
- (void)imageSelectedAtIndex:(NSInteger)index;
@end

@interface GameDetailsContentView : UIView <SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, weak) id <GameDetailsContentViewDelegate>delegate;

- (void)updateWithGame:(Game*)game;

@end
