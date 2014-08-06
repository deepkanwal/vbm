//
//  NSArray+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-31.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (NSString*)commaSeperatedString
{
    return [self componentsJoinedByString:@", "];
}

@end
