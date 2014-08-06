//
//  GeneralHelpers.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "GeneralHelpers.h"
#import "Reachability.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@implementation GeneralHelpers

+ (void)logSubclassImplementationRequired:(const char*)callerString
{
    NSLog(@"%s should be implemented by subclass.", callerString);
}

+ (NSString*)dateString
{
    return [GeneralHelpers dateStringFromDate:[NSDate date]];
}

+ (NSString*)dateStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString* dateString =  [dateFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@", dateString];
}

+ (BOOL)isNetworkAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        return NO;
    } else {
        NSLog(@"There IS internet connection");
        return YES;
    }
}

+ (void)trackEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    if (action.length == 0) {
         action = @"Action";
    }
    if (category.length == 0) {
        category = @"Category";
    }
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Add Games"     // Event category (required)
                                                          action:action  // Event action (required)
                                                           label:label          // Event label
                                                           value:nil] build]];
}

@end
