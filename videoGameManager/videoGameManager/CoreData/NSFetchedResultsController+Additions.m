//
//  NSFetchedResultsController+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "NSFetchedResultsController+Additions.h"
#import "CoreDataHelper.h"

@implementation NSFetchedResultsController (Additions)

+ (NSFetchedResultsController*)fetchResultsControllerForEntityName:(NSString*)entityName sortDescriptors:(NSArray*)sortDescriptors
{
    NSManagedObjectContext *managedObjectContext = [CoreDataHelper sharedContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return theFetchedResultsController;
}

- (BOOL)contextChanged
{
    if (self.managedObjectContext != [CoreDataHelper sharedContext]) {
        return YES;
    }
    return NO;
}

- (BOOL)performFetchRequest
{
    if (self.managedObjectContext != [CoreDataHelper sharedContext]) {
        NSLog(@"Error: managed object contexts not the same.");
        return NO;
    }
    
    NSError *error;
    [self performFetch:&error];
    if (error) {
        NSLog(@"Error in fetch request: %@", error);
        return NO;
    }
    return YES;
}

@end
