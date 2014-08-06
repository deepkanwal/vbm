//
//  CoreDataHelper.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-04.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "AddedGame.h"
#import "AddedPlatform.h"
#import "GeneralHelpers.h"

#define kBACKUP_GAMES_ARRAY_KEY @"gamesArray"
#define kBACKUP_VERSION_NUM     @"version"
#define kBACKUP_DATE            @"date"

@implementation CoreDataHelper

+ (NSManagedObjectContext*)sharedContext
{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

+ (BOOL)saveCoreDataInContext:(NSManagedObjectContext*)context
{
    NSError *error;
    BOOL saved = [context save:&error];

    if (!saved){
        NSLog(@"Saving Error: %@", error.description);
        return NO;
    }
    return YES;
}

+ (NSString*)generateJSONStringForSavedGames
{
    
    NSArray *matches = [AddedGame getAllGames];
    
    if (matches.count == 0) {
        NSLog(@"Error: nothing to back up.");
        return nil;
    }
    
    NSMutableArray *backupArray = [[NSMutableArray alloc] init];
    for (AddedGame* game in matches) {
        [backupArray addObject:[CoreDataHelper dictionaryForAddedGame:game]];
    }
    
    NSMutableDictionary *backupContainerDictionary = [[NSMutableDictionary alloc] init];
    [backupContainerDictionary setObject:backupArray forKey:kBACKUP_GAMES_ARRAY_KEY];
    [backupContainerDictionary setObject:kVERSION_STRING forKey:kBACKUP_VERSION_NUM];
    [backupContainerDictionary setObject:[GeneralHelpers dateString] forKey:kBACKUP_DATE];

    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:backupContainerDictionary options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"ERROR: BACKUP FAILED");
        return nil;
    }
    
    NSString *backupString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return backupString;
}

+ (NSDictionary*)dictionaryForAddedGame:(AddedGame*)addedGame
{
    NSMutableDictionary *backupDictionary = [[NSMutableDictionary alloc] init];
    
    if (addedGame.gameId.length > 0) {
        [backupDictionary setObject:addedGame.gameId forKey:AddedGameAttributes.gameId];
    }
    if (addedGame.gameName.length > 0) {
        [backupDictionary setObject:addedGame.gameName forKey:AddedGameAttributes.gameName];
    }
    if (addedGame.detailsURLString.length > 0) {
        [backupDictionary setObject:addedGame.detailsURLString forKey:AddedGameAttributes.detailsURLString];
    }
    if (addedGame.coverImageThumbnailURLString.length > 0) {
        [backupDictionary setObject:addedGame.coverImageThumbnailURLString forKey:AddedGameAttributes.coverImageThumbnailURLString];
    }
    if (addedGame.coverImageMediumURLString.length > 0) {
        [backupDictionary setObject:addedGame.coverImageMediumURLString forKey:AddedGameAttributes.coverImageMediumURLString];
    }
    if (addedGame.releaseYear.length > 0) {
        [backupDictionary setObject:addedGame.releaseYear forKey:AddedGameAttributes.releaseYear];
    }
    
    if (addedGame.platform.name.length > 0) {
        [backupDictionary setObject:addedGame.platform.name forKey:AddedGameRelationships.platform];
    }
    
    if (addedGame.notes.length > 0) {
        [backupDictionary setObject:addedGame.notes forKey:AddedGameAttributes.notes];
    }

    
    [backupDictionary setObject:[NSNumber numberWithBool:addedGame.nowPlayingValue] forKey:AddedGameAttributes.nowPlaying];
    [backupDictionary setObject:[NSNumber numberWithBool:addedGame.isFavouriteValue] forKey:AddedGameAttributes.isFavourite];
    [backupDictionary setObject:[NSNumber numberWithBool:addedGame.isBeatenValue] forKey:AddedGameAttributes.isBeaten];
    [backupDictionary setObject:[NSNumber numberWithInteger:addedGame.ratingValue] forKey:AddedGameAttributes.rating];
    [backupDictionary setObject:[NSNumber numberWithInteger:addedGame.progressValue] forKey:AddedGameAttributes.progress];

    return backupDictionary;
}

+ (BOOL)restoreGamesFromJSONDictionary:(NSDictionary*)dictionary
{
    NSArray *gamesToRestore = [dictionary objectForKey:kBACKUP_GAMES_ARRAY_KEY];
    if (![gamesToRestore isKindOfClass:[NSArray class]]) {
        NSLog(@"Error: no games dictionary");
        return NO;
    }
    
    [CoreDataHelper deleteAllEntities];
    
    for (NSDictionary* game in gamesToRestore) {
        BOOL success = [CoreDataHelper restoreGameFromJSONDictionary:game];
        if (!success) {
            [[CoreDataHelper sharedContext] rollback];
            return NO;
        }
    }
    
    [CoreDataHelper saveCoreDataInContext:[CoreDataHelper sharedContext]];
    return YES;
}

+ (BOOL)restoreGameFromJSONDictionary:(NSDictionary*)gameDictionary
{
    if (![gameDictionary objectForKey:AddedGameRelationships.platform]) {
        NSLog(@"Error: could not find platform in restore dictionary.");
        return NO;
    }
    
    AddedGame* addedGame = [AddedGame newAddedGameInContext:[CoreDataHelper sharedContext]];
    
    addedGame.gameId = [gameDictionary objectForKey:AddedGameAttributes.gameId];
    addedGame.gameName = [gameDictionary objectForKey:AddedGameAttributes.gameName];
    addedGame.detailsURLString = [gameDictionary objectForKey:AddedGameAttributes.detailsURLString];
    addedGame.coverImageThumbnailURLString = [gameDictionary objectForKey:AddedGameAttributes.coverImageThumbnailURLString];
    addedGame.coverImageMediumURLString = [gameDictionary objectForKey:AddedGameAttributes.coverImageMediumURLString];
    addedGame.releaseYear = [gameDictionary objectForKey:AddedGameAttributes.releaseYear];
   [addedGame updateWithPlatformOfName:[gameDictionary objectForKey:AddedGameRelationships.platform] inContext:[CoreDataHelper sharedContext]];
    
    
    addedGame.notes = [gameDictionary objectForKey:AddedGameAttributes.notes];
    addedGame.nowPlaying = [gameDictionary objectForKey:AddedGameAttributes.nowPlaying];
    addedGame.isFavourite = [gameDictionary objectForKey:AddedGameAttributes.isFavourite];
    addedGame.isBeaten = [gameDictionary objectForKey:AddedGameAttributes.isBeaten];
    addedGame.rating = [gameDictionary objectForKey:AddedGameAttributes.rating];
    addedGame.progress = [gameDictionary objectForKey:AddedGameAttributes.progress];
    addedGame.isMissingDataValue = YES;
    
    return YES;
}

+ (void)deleteAllEntities
{
    NSArray* matches = [AddedGame getAllGames];
    for (AddedGame* game in matches) {
        [AddedGame deleteAddedGame:game inContext:[CoreDataHelper sharedContext]];
    }
    [CoreDataHelper saveCoreDataInContext:[CoreDataHelper sharedContext]];
    NSLog(@"");
}

@end
