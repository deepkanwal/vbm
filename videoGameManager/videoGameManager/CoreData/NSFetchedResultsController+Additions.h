//
//  NSFetchedResultsController+Additions.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (Additions)

+ (NSFetchedResultsController*)fetchResultsControllerForEntityName:(NSString*)entityName sortDescriptors:(NSArray*)sortDescriptors;
- (BOOL)performFetchRequest;
- (BOOL)contextChanged;

@end
