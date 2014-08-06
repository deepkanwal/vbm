//
//  GameList.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GameList.h"
#import "Game.h"

@interface GameList()
@property (nonatomic, strong) NSMutableArray *gameList;
@end

@implementation GameList

- (id)init
{
    self = [super init];
    if (self) {
        self.gameList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)appendGamesArray:(NSArray*)gameModelsArray
{
    [self.gameList addObjectsFromArray:gameModelsArray];
}

- (void)updateWithNewGamesArray:(NSArray*)gameModelsArray
{
    [self.gameList removeAllObjects];
    [self.gameList addObjectsFromArray:gameModelsArray];
}

- (void)deleteAllGames
{
    [self.gameList removeAllObjects];
}

- (NSUInteger)countOfGameList
{
    return self.gameList.count;
}

- (Game*)gameAtIndex:(NSUInteger)index
{
    if (self.gameList.count > 0 && self.gameList.count > index) {
        return [self.gameList objectAtIndex:index];
    }
    return nil;
}

@end
