//
//  GeneralHelpers.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kVERSION_STRING [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
#define kNOTIFICATION_DROPBOX_LINKED @"kNOTIFICATION_DROPBOX_LINKED"

@interface GeneralHelpers : NSObject

+ (void)logSubclassImplementationRequired:(const char*)callerString;
+ (NSString*)dateString;
+ (NSString*)dateStringFromDate:(NSDate*)date;
+ (BOOL)isNetworkAvailable;

+ (void)trackEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label;

@end
