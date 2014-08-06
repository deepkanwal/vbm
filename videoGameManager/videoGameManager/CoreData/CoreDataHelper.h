//
//  CoreDataHelper.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-04.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (NSManagedObjectContext*)sharedContext;
+ (BOOL)saveCoreDataInContext:(NSManagedObjectContext*)context;

+ (NSString*)generateJSONStringForSavedGames;
+ (BOOL)restoreGamesFromJSONDictionary:(NSDictionary*)dictionary;

@end
