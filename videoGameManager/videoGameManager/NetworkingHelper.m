//
//  NetworkingHelper.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "NetworkingHelper.h"
#import "AFHTTPClient.h"

@implementation NetworkingHelper

+ (NSDictionary*)getJSONDictionaryForURL:(NSURL*)url
{
    
    NSData *recievedData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    
    if (!recievedData) {
        return nil;
    }
    
    id jsonDictionary = [NSJSONSerialization JSONObjectWithData:recievedData
                                                        options:kNilOptions
                                                          error:&error];
    
    if ([jsonDictionary isKindOfClass:[NSDictionary class]]) {
        return jsonDictionary;
    } else {
        return nil;
    }
    
}

+ (NSURL*)getEncodedURLFromString:(NSString*)urlString
{
    NSString *urlEncodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:urlEncodedString];
}

+ (BOOL)connected
{
    return ([[AFHTTPClient client] networkReachabilityStatus] > 0);
}


@end
