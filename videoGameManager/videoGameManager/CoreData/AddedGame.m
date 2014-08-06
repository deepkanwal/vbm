#import "AddedGame.h"
#import "AddedPlatform.h"
#import "Game.h"
#import "CoreDataHelper.h"

#define kCD_ADDED_GAME_TAG @"CD AddedGame:"

@interface AddedGame ()

// Private interface goes here.

@end


@implementation AddedGame

+ (AddedGame*)createAddedGameForGame:(Game*)game inContext:(NSManagedObjectContext*)context
{
    NSArray *matches = [AddedGame getMatchesForGameId:game.gameId andPlatform:kUNSELECTED_PLATFORM inContext:context];
   
    if (!matches || matches.count >= 1) {
        NSLog(@"%@ Error inserting game %@", kCD_ADDED_GAME_TAG, game.gameName);
        return nil;
    } else {
         AddedGame* addedGame;
        addedGame = [AddedGame newAddedGameInContext:context];
        [addedGame updateWithGame:game saveContext:NO];
        NSLog(@"%@ added %@.", kCD_ADDED_GAME_TAG, addedGame.gameName);
        return addedGame;
    }
}

+ (void)deleteGameWithId:(NSString*)gameId andPlatform:(NSString*)platform inContext:(NSManagedObjectContext*)context
{
    NSArray *matches = [AddedGame getMatchesForGameId:gameId andPlatform:platform inContext:context];
    if (matches.count == 1) {
        [AddedGame deleteAddedGame:[matches lastObject] inContext:context];
        [CoreDataHelper saveCoreDataInContext:context];
    } else {
        NSLog(@"%@ Error deleting gameId %@ and platform %@", kCD_ADDED_GAME_TAG, gameId, platform);
    }
}

+ (NSArray*)getMatchesForGameId:(NSString*)gameId inContext:(NSManagedObjectContext*)context
{
    if (gameId) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AddedGame.entityName];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AddedGameAttributes.gameId
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedGameAttributes.gameId, gameId];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        return matches;
    }
    return nil;
}

+ (NSArray*)getMatchesForGameId:(NSString*)gameId andPlatform:(NSString*)platform inContext:(NSManagedObjectContext*)context
{
    if (gameId) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AddedGame.entityName];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AddedGameAttributes.gameId
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", AddedGameAttributes.gameId, gameId, @"platform.name", platform];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        return matches;
    }
    return nil;
}

+ (AddedGame*)newAddedGameInContext:(NSManagedObjectContext*)context
{
    AddedGame *addedGame = [NSEntityDescription insertNewObjectForEntityForName:AddedGame.entityName inManagedObjectContext:context];
    [addedGame setNowPlayingValue:NO];
    [addedGame setIsBeatenValue:NO];
    [addedGame setIsFavouriteValue:NO];
    [addedGame setRatingValue:0];
    [addedGame setNotes:@""];
    
    return addedGame;
}

+ (NSArray*)getFavouriteGames
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedGameAttributes.isFavourite, [NSNumber numberWithBool:YES]];
    return [AddedGame getGamesWithPredicate:predicate];
}

+ (NSArray*)getAllGames
{
    return [AddedGame getGamesWithPredicate:nil];
}

+ (NSArray*)getGamesWithPredicate:(NSPredicate*)predicate
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AddedGame.entityName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AddedGameAttributes.gameId
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    if (predicate) {
        request.predicate = predicate;
    }
    NSArray *matches = [[CoreDataHelper sharedContext] executeFetchRequest:request error:nil];
    
    if (matches.count == 0) {
        return nil;
    }
    return matches;
}

- (void)updateWithGame:(Game*)game saveContext:(BOOL)saveContext
{
    self.gameId = game.gameId;
    self.gameName = game.gameName;
    self.releaseYear = game.releaseYear;
    self.gameDescription = game.gameDescription;
    self.coverImageThumbnailURLString = game.coverImageThumbnailURLString;
    self.coverImageMediumURLString = game.coverImageMediumURLString;
    self.pageURLString = game.pageURLString;
    self.detailsURLString = game.detailsURLString;
    self.developers = [NSKeyedArchiver archivedDataWithRootObject:game.developers];
    self.publishers = [NSKeyedArchiver archivedDataWithRootObject:game.publishers];
    self.genres = [NSKeyedArchiver archivedDataWithRootObject:game.genres];
    self.thumbnailImages = [NSKeyedArchiver archivedDataWithRootObject:game.thumbnailImages];
    self.largeImages = [NSKeyedArchiver archivedDataWithRootObject:game.largeImages];
    self.platforms = [NSKeyedArchiver archivedDataWithRootObject:game.platforms];
    self.isMissingDataValue = NO;
    
    if (saveContext) {
        [CoreDataHelper saveCoreDataInContext:[CoreDataHelper sharedContext]];
    }
}

- (Game*)getGame
{
    Game* game = [[Game alloc] init];
    game.gameId = self.gameId;
    game.gameName = self.gameName;
    game.releaseYear = self.releaseYear;
    game.gameDescription = self.gameDescription;
    game.coverImageThumbnailURLString = self.coverImageThumbnailURLString;
    game.coverImageMediumURLString = self.coverImageMediumURLString;
    game.pageURLString = self.pageURLString;
    game.detailsURLString = self.detailsURLString;
    game.developers = [NSKeyedUnarchiver unarchiveObjectWithData:self.developers];
    game.publishers = [NSKeyedUnarchiver unarchiveObjectWithData:self.publishers];
    game.genres = [NSKeyedUnarchiver unarchiveObjectWithData:self.genres];
    game.thumbnailImages = [NSKeyedUnarchiver unarchiveObjectWithData:self.thumbnailImages];
    game.largeImages = [NSKeyedUnarchiver unarchiveObjectWithData:self.largeImages];
    game.platforms = [NSKeyedUnarchiver unarchiveObjectWithData:self.platforms];

    return game;
    
}

+ (void)deleteAddedGame:(AddedGame*)addedGame inContext:(NSManagedObjectContext*)context {
    NSLog(@"%@ deleting %@ on platform %@ with count %@", kCD_ADDED_GAME_TAG, addedGame.gameName, addedGame.platform.name, addedGame.platform.count);
    [AddedPlatform decrementPlatformCountForAddedGame:addedGame inContext:context];
    [context deleteObject:addedGame];
}

- (void)updateWithPlatformOfName:(NSString*)platformName inContext:(NSManagedObjectContext*)context
{
    if (self.platform.name.length != 0 && ![self.platform.name isEqualToString:platformName]) {
        [AddedPlatform decrementPlatformCountForAddedGame:self inContext:context];
        self.platform = [AddedPlatform addedPlatformWithName:platformName inContext:context];
    } else if (self.platform.name.length == 0) {
        self.platform = [AddedPlatform addedPlatformWithName:platformName inContext:context];
    }

}

- (NSArray*)platformsArray
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.platforms];
}

#pragma mark - Helpers

+ (void)decrementPlatformCountForAddedGame:(AddedGame*)addedGame inContext:(NSManagedObjectContext*)context
{
    addedGame.platform.count = [NSNumber numberWithInteger:[addedGame.platform.count integerValue] - 1];
    NSLog(@"Updated Count:%@", addedGame.platform.count);
    if ([addedGame.platform.count integerValue] <= 0) {
        [AddedPlatform deleteAddedPlatform:addedGame.platform inContext:context];
    }
}

@end
