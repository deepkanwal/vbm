//
//  GiantBombAPI.m
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//


#import "GiantBombAPI.h"
#import "NetworkingHelper.h"
#import "GiantBombParser.h"
#import "Game.h"

#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

#warning TODO: Update GiantBomb API Key for release.
#define NW_GB_API_KEY @"abc"
#define NW_GB_BASE_URL @"http://www.giantbomb.com/api/search"
#define NW_GB_API_REQUIRED_PARAMETERS [NSString stringWithFormat:@"?api_key=%@&format=json", NW_GB_API_KEY]
#define GB_API_TAG @"GiantBombAPI:"

@implementation GiantBombAPI

#pragma mark - fetch methods

+ (void)fetchGameDataForSearchTerm:(NSString*)searchTerm withLimit:(NSUInteger)limit page:(NSUInteger)page results:(void(^)(NSArray* gamesArray, BOOL isSuccess, NSUInteger totalCount))results
{
 
    static NSInteger numberOfConnections = 0;
    numberOfConnections++;
    
    NSURL *url = [GiantBombAPI generateURLForSearchTerm:searchTerm withLimit:limit page:page];
    [GiantBombAPI showStatusBarIndicator];
    
    [GiantBombAPI startJSONOperationForURL:url success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *searchResultsArray = [[NSMutableArray alloc] init];
        BOOL isSuccess = NO;
        NSUInteger totalCount = 0;
        
        if (JSON && [self isValidJSONDictionary:JSON]) {
            
            id total = [JSON objectForKey:@"number_of_total_results"];
            if (total && [total isKindOfClass:[NSNumber class]]) {
                totalCount = [total unsignedIntegerValue];
            }
            
            id resultsArray = [JSON objectForKey:@"results"];
            if (resultsArray && [resultsArray isKindOfClass:[NSArray class]]){
                for (id gameDictionary in resultsArray) {
                    if (gameDictionary && [gameDictionary isKindOfClass:[NSDictionary class]]) {
                        Game* game = [GiantBombParser gameWithRequiredInfoFromJSONDictionary:gameDictionary];
                        [searchResultsArray addObject:game];
                    }
                }
            }
            isSuccess = YES;
        }
        
        numberOfConnections--;
        if (numberOfConnections == 0) [GiantBombAPI hideStatusBarIndicator];
        
        results(searchResultsArray, isSuccess, totalCount);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        numberOfConnections--;
        if (numberOfConnections == 0) [GiantBombAPI hideStatusBarIndicator];
        results(nil, NO, 0);
    }];
    
}

//
//+ (void)fetchGameDataForSearchTerm:(NSString*)searchTerm withLimit:(NSUInteger)limit page:(NSUInteger)page results:(void(^)(NSArray* gamesArray, BOOL isSuccess, NSUInteger totalCount))results
//{
//    dispatch_queue_t fetchGameDataQueue = dispatch_queue_create("fetchGameDataForSearchTerm", NULL);
//
//    dispatch_async(fetchGameDataQueue, ^{
//
//        NSMutableArray *searchResultsArray = [[NSMutableArray alloc] init];
//        BOOL isSuccess = NO;
//        NSUInteger totalCount = 0;
//
//        NSURL *url = [GiantBombAPI generateURLForSearchTerm:searchTerm withLimit:limit page:page];
//
//        if (url) {
//            NSDictionary *jsonDictionary = [NetworkingHelper getJSONDictionaryForURL:url];
//
//            if (jsonDictionary && [self isValidJSONDictionary:jsonDictionary]) {
//                id total = [jsonDictionary objectForKey:@"number_of_total_results"];
//                if (total && [total isKindOfClass:[NSNumber class]]) {
//                    totalCount = [total unsignedIntegerValue];
//                }
//
//                id resultsArray = [jsonDictionary objectForKey:@"results"];
//                if (resultsArray && [resultsArray isKindOfClass:[NSArray class]]){
//                    for (id gameDictionary in resultsArray) {
//                        if (gameDictionary && [gameDictionary isKindOfClass:[NSDictionary class]]) {
//                            Game* game = [GiantBombParser gameWithRequiredInfoFromJSONDictionary:gameDictionary];
//                            [searchResultsArray addObject:game];
//                        }
//                    }
//                }
//                isSuccess = YES;
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            results(searchResultsArray, isSuccess, totalCount);
//        });
//
//    });
//}

+ (void)fetchDetailsFor:(Game*)game results:(void(^)(BOOL isSuccess))results
{
    NSURL *url = [GiantBombAPI generateURLForGameDetailsUrlString:game.detailsURLString];
    [GiantBombAPI showStatusBarIndicator];
    [GiantBombAPI startJSONOperationForURL:url success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        BOOL isSuccess = NO;
        
        if (JSON && [self isValidJSONDictionary:JSON]) {
            id results = [JSON objectForKey:@"results"];
            if (results && [results isKindOfClass:[NSDictionary class]]) {
                [GiantBombParser updateGame:game withDetailedInfoFromJSONDictionary:results];
            }
            isSuccess = YES;
        }
        [GiantBombAPI hideStatusBarIndicator];
        results(YES);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [GiantBombAPI hideStatusBarIndicator];
        results(NO);
    }];
}
//
//+ (void)fetchDetailsFor:(Game*)game results:(void(^)(BOOL isSuccess))results
//{
//    dispatch_queue_t fetchGameDetailsQueue = dispatch_queue_create("fetchGameDetailsForSearchTerm", NULL);
//
//    dispatch_async(fetchGameDetailsQueue, ^{
//
//        BOOL isSuccess = NO;
//        NSURL *url = [GiantBombAPI generateURLForGameDetailsUrlString:game.detailsURLString];
//
//        if (url) {
//            NSDictionary *jsonDictionary = [NetworkingHelper getJSONDictionaryForURL:url];
//
//            if (jsonDictionary && [self isValidJSONDictionary:jsonDictionary]) {
//                id results = [jsonDictionary objectForKey:@"results"];
//                if (results && [results isKindOfClass:[NSDictionary class]]) {
//                    [GiantBombParser updateGame:game withDetailedInfoFromJSONDictionary:results];
//                }
//                isSuccess = YES;
//            }
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                results(isSuccess);
//            });
//        }
//    });
//}

+ (void)cancelOperations
{
    [[[AFHTTPClient client] operationQueue] cancelAllOperations];
}

# pragma mark - helper methods

+ (void)startJSONOperationForURL:(NSURL*)url
                         success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                         failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success failure:failure];
    [operation start];
}

+ (NSURL*)generateURLForSearchTerm:(NSString*)searchTerm withLimit:(NSUInteger)limit page:(NSUInteger)page
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@&query=\"%@\"&resources=game&limit=%lu&page=%lu", NW_GB_BASE_URL, NW_GB_API_REQUIRED_PARAMETERS,  searchTerm, (unsigned long)limit, (unsigned long)page];
    
    [GiantBombAPI logRequest:urlString];
    NSURL *url = [NetworkingHelper getEncodedURLFromString:urlString];
    return url;
}

+ (NSURL*)generateURLForGameDetailsUrlString:(NSString*)urlString
{
    if ([urlString characterAtIndex:urlString.length - 1] != '/') {
        [urlString stringByAppendingString:@"/"];
    }
    
    NSString *detailsUrlString = [NSString stringWithFormat:@"%@%@", urlString, NW_GB_API_REQUIRED_PARAMETERS];
    
    [GiantBombAPI logRequest:detailsUrlString];
    NSURL *url = [NetworkingHelper getEncodedURLFromString:detailsUrlString];
    return url;
}

+ (BOOL)isValidJSONDictionary:(NSDictionary*)JSONDictionary
{
    id error = [JSONDictionary objectForKey:@"error"];
    if (error && [error isKindOfClass:[NSString class]] && [error isEqualToString:@"OK"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)logRequest:(NSString*)urlString
{
    NSLog(@"%@ Sending request - %@",  GB_API_TAG, urlString);
}

+ (void)showStatusBarIndicator
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideStatusBarIndicator
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end

