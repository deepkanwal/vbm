#import "_AddedPlatform.h"

@interface AddedPlatform : _AddedPlatform {}

+ (AddedPlatform *)addedPlatformWithName:(NSString*)name inContext:(NSManagedObjectContext *)context;
+ (void)deleteAddedPlatform:(AddedPlatform*)addedPlatform inContext:(NSManagedObjectContext*)context;
+ (void)decrementPlatformCountForAddedGame:(AddedGame*)addedGame inContext:(NSManagedObjectContext*)context;
+ (NSArray*)getAllPlatforms;

@end
