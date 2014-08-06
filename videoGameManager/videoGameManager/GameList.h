//
//  GameList.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface GameList : NSObject

@property (nonatomic, assign) NSUInteger totalCount;

- (void)appendGamesArray:(NSArray*)gamesArray;
- (void)updateWithNewGamesArray:(NSArray*)gamesArray;
- (void)deleteAllGames;
- (NSUInteger)countOfGameList;
- (Game*)gameAtIndex:(NSUInteger)index;

@end
