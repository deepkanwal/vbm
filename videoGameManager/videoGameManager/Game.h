//
//  Game.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *releaseYear;
@property (nonatomic, strong) NSString *detailsURLString;
@property (nonatomic, strong) NSString *coverImageThumbnailURLString;
@property (nonatomic, strong) NSString *coverImageMediumURLString;
@property (nonatomic, strong) NSString *gameDescription;
@property (nonatomic, strong) NSString *pageURLString;


@property (nonatomic, strong) NSArray *platforms;
@property (nonatomic, strong) NSArray *developers;
@property (nonatomic, strong) NSArray *publishers;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *thumbnailImages;
@property (nonatomic, strong) NSArray *largeImages;
@property (nonatomic, strong) NSArray *relatedGames;

@property (nonatomic, assign) BOOL isMissingDetails;

@end
