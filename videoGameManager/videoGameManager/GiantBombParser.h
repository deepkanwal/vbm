//
//  GiantBombParser.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface GiantBombParser : NSObject

+ (Game*)gameWithRequiredInfoFromJSONDictionary:(NSDictionary*)dictionary;
+ (void)updateGame:(Game*)game withDetailedInfoFromJSONDictionary:(NSDictionary*)dictionary;

@end
