//
//  GiantBombParser.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GiantBombParser.h"
#import "Game.h"

#define kNUM_IMAGES 100

@implementation GiantBombParser

+ (Game*)gameWithRequiredInfoFromJSONDictionary:(NSDictionary*)dictionary
{
    Game* game = [[Game alloc] init];

    id gameId = [dictionary objectForKey:@"id"];
    if (gameId && [gameId isKindOfClass:[NSNumber class]]) {
        game.gameId = [gameId stringValue];
    }
    
    id gameName = [dictionary objectForKey:@"name"];
    if (gameName && [gameName isKindOfClass:[NSString class]]) {
        game.gameName = gameName;
    }
    
    id detailsURL = [dictionary objectForKey:@"api_detail_url"];
    if (detailsURL && [detailsURL isKindOfClass:[NSString class]]) {
        game.detailsURLString = detailsURL;
    }
    
    id imageDictionary = [dictionary objectForKey:@"image"];
    if (imageDictionary && [imageDictionary isKindOfClass:[NSDictionary class]]) {
        id smallURL = [imageDictionary objectForKey:@"thumb_url"];
        if (smallURL && [smallURL isKindOfClass:[NSString class]]) {
            game.coverImageThumbnailURLString = smallURL;
        }
    }
    
    id releaseDate = [dictionary objectForKey:@"original_release_date"];
    if (releaseDate && [releaseDate isKindOfClass:[NSString class]]) {
        game.releaseYear = [releaseDate substringToIndex:4];
    }
    
    return game;
}

+ (void)updateGame:(Game*)game withDetailedInfoFromJSONDictionary:(NSDictionary*)dictionary
{
    
    id imageDictionary = [dictionary objectForKey:@"image"];
    if (imageDictionary && [imageDictionary isKindOfClass:[NSDictionary class]]) {
        id smallURL = [imageDictionary objectForKey:@"small_url"];
        if (smallURL && [smallURL isKindOfClass:[NSString class]]) {
            game.coverImageThumbnailURLString = smallURL;
        }
        id mediumURL = [imageDictionary objectForKey:@"medium_url"];
        if (mediumURL && [mediumURL isKindOfClass:[NSString class]]) {
            game.coverImageMediumURLString = mediumURL;
        }
    }
    

    id releaseDate = [dictionary objectForKey:@"original_release_date"];
    if (releaseDate && [releaseDate isKindOfClass:[NSString class]]) {
        game.releaseYear = [releaseDate substringToIndex:4];
    }
    
    id description = [dictionary objectForKey:@"deck"];
    if (description && [description isKindOfClass:[NSString class]]) {
        game.gameDescription = description;
    } else {
        game.gameDescription = @"No description avaliable :(";
    }
    
    id platforms = [dictionary objectForKey:@"platforms"];
    if (platforms && [platforms isKindOfClass:[NSArray class]]) {
        game.platforms = [GiantBombParser getPlatformsArray:platforms];
    }
    
    id imagesArray = [dictionary objectForKey:@"images"];
    if ([imagesArray isKindOfClass:[NSArray class]]) {
        NSInteger limit = 0;
        NSMutableArray *smallImages = [[NSMutableArray alloc] init];
        NSMutableArray *largeImages = [[NSMutableArray alloc] init];
        
        for (NSDictionary* imageDictionary in imagesArray) {
            if (limit > 0) {
                id thumbUrl = [imageDictionary objectForKey:@"thumb_url"];
                id superUrl = [imageDictionary objectForKey:@"super_url"];
                if ([thumbUrl isKindOfClass:[NSString class]] && [superUrl isKindOfClass:[NSString class]]) {
                    [smallImages addObject:thumbUrl];
                    [largeImages addObject:superUrl];
                }
            }
            limit++;
            if (limit == kNUM_IMAGES) {
                break;
            }
        }
        
        game.largeImages = largeImages;
        game.thumbnailImages = smallImages;
    }
    
    id developers = [dictionary objectForKey:@"developers"];
    if (developers && [developers isKindOfClass:[NSArray class]]) {
        game.developers = [GiantBombParser getGeneralArray:developers];
    }
    
    id genres = [dictionary objectForKey:@"genres"];
    if (genres && [genres isKindOfClass:[NSArray class]]) {
        game.genres = [GiantBombParser getGeneralArray:genres];
    }
    
    id publishers = [dictionary objectForKey:@"publishers"];
    if (publishers && [publishers isKindOfClass:[NSArray class]]) {
        game.publishers = [GiantBombParser getGeneralArray:publishers];
    }
    
    id relatedGames = [dictionary objectForKey:@"similar_games"];
    if (relatedGames && [relatedGames isKindOfClass:[NSArray class]]) {
        game.relatedGames = [GiantBombParser getRelatedGamesArray:relatedGames];
    }
    
    game.isMissingDetails = NO;
}

#pragma mark - helpers

+ (NSArray*)getPlatformsArray:(NSArray*)JSONArray
{
    NSMutableArray *platformArray = [[NSMutableArray alloc] init];
    for (NSDictionary* platformDictionary in JSONArray) {
        id platform = [GiantBombParser getShortenedPlatformNameForOriginalName:[platformDictionary objectForKey:@"name"]];
        if (platform && [platform isKindOfClass:[NSString class]]) {
            [platformArray addObject:platform];
        }
    }
    return platformArray;
}

+ (NSArray*)getGeneralArray:(NSArray*)JSONArray
{
    NSMutableArray *generalArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dictionary in JSONArray) {
        id generalElement = [dictionary objectForKey:@"name"];
        if (generalElement && [generalElement isKindOfClass:[NSString class]]) {
            [generalArray addObject:generalElement];
        }
    }
    
    return generalArray;
}

+ (NSArray*)getRelatedGamesArray:(NSArray*)JSONArray
{
    NSMutableArray *gamesArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dictionary in JSONArray) {
        Game *gameToAdd = [GiantBombParser gameWithRequiredInfoFromJSONDictionary:dictionary];
        [gamesArray addObject:gameToAdd];
    }
    return gamesArray;
}

+ (NSString*)getShortenedPlatformNameForOriginalName:(NSString*)originalName
{
    if ([originalName isEqualToString:@"Super Nintendo Entertainment System"]) {
        return @"SNES";
    }
    if ([originalName isEqualToString:@"Nintendo Entertainment System"]) {
        return @"NES";
    }
    if ([originalName isEqualToString:@"Nintendo 64"]) {
        return @"N64";
    }
    if ([originalName isEqualToString:@"Famicom Disk System"]) {
        return @"Famicom";
    }
    if ([originalName isEqualToString:@"Game Boy Advance"]) {
        return @"GBA";
    }
    if ([originalName isEqualToString:@"Game Boy Color"]) {
        return @"GBC";
    }
    if ([originalName isEqualToString:@"PlayStation Network (PS3)"]) {
        return @"PSN (PS3)";
    }
    if ([originalName isEqualToString:@"PlayStation Network (Vita)"]) {
        return @"PSN (Vita)";
    }
    if ([originalName isEqualToString:@"PlayStation Vita"]) {
        return @"Vita";
    }
    if ([originalName isEqualToString:@"PlayStation Portable"]) {
        return @"PSP";
    }
    if ([originalName isEqualToString:@"Xbox Live Marketplace"]) {
        return @"Xbox Live";
    }
    if ([originalName rangeOfString:@"PlayStation"].location == 0 && originalName.length > @"Playstation".length)
    {
        return [originalName stringByReplacingOccurrencesOfString:@"PlayStation " withString:@"PS"];
    }
    
    return [originalName stringByReplacingOccurrencesOfString:@"Nintendo " withString:@""];
}


@end
