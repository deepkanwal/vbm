//
//  NetworkingHelper.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingHelper : NSObject

+ (NSDictionary*)getJSONDictionaryForURL:(NSURL*)url;
+ (NSURL*)getEncodedURLFromString:(NSString*)urlString;
+ (BOOL)connected;

@end
