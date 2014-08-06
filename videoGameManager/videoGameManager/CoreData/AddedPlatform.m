#import "AddedPlatform.h"
#import "AddedGame.h"
#import "CoreDataHelper.h"

#define kCD_PLATFORM_TAG @"CD Platform:"

@interface AddedPlatform ()

// Private interface goes here.

@end


@implementation AddedPlatform

+ (AddedPlatform *)addedPlatformWithName:(NSString*)name inContext:(NSManagedObjectContext *)context
{
    AddedPlatform *platform = nil;
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AddedPlatform.entityName];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AddedPlatformAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedPlatformAttributes.name, name];
        
        NSError *error;
        NSArray *existingMatches = [context executeFetchRequest:request error:&error];
        
        if (!existingMatches) {
            NSLog(@"%@ Error saving platform to database", kCD_PLATFORM_TAG);
        } else if (existingMatches.count == 0) {
            platform = [NSEntityDescription insertNewObjectForEntityForName:AddedPlatform.entityName inManagedObjectContext:context];
            platform.name = name;
            platform.count = [NSNumber numberWithInteger:1];
            NSLog(@"%@ Added platform with name %@", kCD_PLATFORM_TAG, platform.name);
        } else {
            platform = [existingMatches lastObject];
            platform.count = [NSNumber numberWithInteger:[platform.count integerValue] + 1];
            NSLog(@"%@ Updated platform %@'s count to %@", kCD_PLATFORM_TAG, platform.name, platform.count);
        }
    }
    
    return platform;
}

+ (void)deleteAddedPlatform:(AddedPlatform*)addedPlatform inContext:(NSManagedObjectContext*)context
{
    NSLog(@"%@ deleting platform %@ with count %@", kCD_PLATFORM_TAG, addedPlatform.name, addedPlatform.count);
    [context deleteObject:addedPlatform];
}

+ (void)decrementPlatformCountForAddedGame:(AddedGame*)addedGame inContext:(NSManagedObjectContext*)context
{
    addedGame.platform.count = [NSNumber numberWithInteger:[addedGame.platform.count integerValue] - 1];
    NSLog(@"Updated Count:%@", addedGame.platform.count);
    if (addedGame.platform && [addedGame.platform.count integerValue] == 0) {
        [AddedPlatform deleteAddedPlatform:addedGame.platform inContext:context];
    }
}

+ (NSArray*)getAllPlatforms
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AddedPlatform.entityName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AddedPlatformAttributes.name
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    NSArray *matches = [[CoreDataHelper sharedContext] executeFetchRequest:request error:nil];
    
    if (matches.count == 0) {
        return nil;
    }
    return matches;
}

@end
