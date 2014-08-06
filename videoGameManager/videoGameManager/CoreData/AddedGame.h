#import "_AddedGame.h"

#define kUNSELECTED_PLATFORM @"UNSELECTED_PLATFORM"

@class Game;

@interface AddedGame : _AddedGame {}

+ (AddedGame*)createAddedGameForGame:(Game*)game inContext:(NSManagedObjectContext*)context;
+ (void)deleteGameWithId:(NSString*)gameId andPlatform:(NSString*)platform inContext:(NSManagedObjectContext*)context;
+ (NSArray*)getMatchesForGameId:(NSString*)gameId inContext:(NSManagedObjectContext*)context;
+ (NSArray*)getMatchesForGameId:(NSString*)gameId andPlatform:(NSString*)platform inContext:(NSManagedObjectContext*)context;

+ (void)deleteAddedGame:(AddedGame*)addedGame inContext:(NSManagedObjectContext*)context;
+ (NSArray*)getFavouriteGames;
+ (NSArray*)getAllGames;
+ (NSArray*)getGamesWithPredicate:(NSPredicate*)predicate;

+ (AddedGame*)newAddedGameInContext:(NSManagedObjectContext*)context;


- (Game*)getGame;
- (void)updateWithGame:(Game*)game saveContext:(BOOL)saveContext;
- (void)updateWithPlatformOfName:(NSString*)platformName inContext:(NSManagedObjectContext*)context;
- (NSArray*)platformsArray;

@end
