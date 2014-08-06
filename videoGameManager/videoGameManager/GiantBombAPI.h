//
//  GiantBombAPI.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSEARCH_ITEMS_PER_PAGE 25

@class Game;

typedef enum coverImageSize {
    CoverImageSizeThumbnail = 1,
    CoverImageSizeMedium = 2
} CoverImageSize;

@interface GiantBombAPI : NSObject

+ (void)fetchGameDataForSearchTerm:(NSString*)searchTerm withLimit:(NSUInteger)limit page:(NSUInteger)page results:(void(^)(NSArray* gamesArray, BOOL isSuccess, NSUInteger totalCount))results;
+ (void)fetchDetailsFor:(Game*)game results:(void(^)(BOOL isSuccess))results;

+ (void)cancelOperations;

@end
