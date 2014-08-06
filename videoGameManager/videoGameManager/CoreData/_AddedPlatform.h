// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedPlatform.h instead.

#import <CoreData/CoreData.h>


extern const struct AddedPlatformAttributes {
	__unsafe_unretained NSString *count;
	__unsafe_unretained NSString *name;
} AddedPlatformAttributes;

extern const struct AddedPlatformRelationships {
	__unsafe_unretained NSString *games;
} AddedPlatformRelationships;

extern const struct AddedPlatformFetchedProperties {
} AddedPlatformFetchedProperties;

@class AddedGame;




@interface AddedPlatformID : NSManagedObjectID {}
@end

@interface _AddedPlatform : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AddedPlatformID*)objectID;





@property (nonatomic, strong) NSNumber* count;



@property int32_t countValue;
- (int32_t)countValue;
- (void)setCountValue:(int32_t)value_;

//- (BOOL)validateCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *games;

- (NSMutableSet*)gamesSet;





@end

@interface _AddedPlatform (CoreDataGeneratedAccessors)

- (void)addGames:(NSSet*)value_;
- (void)removeGames:(NSSet*)value_;
- (void)addGamesObject:(AddedGame*)value_;
- (void)removeGamesObject:(AddedGame*)value_;

@end

@interface _AddedPlatform (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCount;
- (void)setPrimitiveCount:(NSNumber*)value;

- (int32_t)primitiveCountValue;
- (void)setPrimitiveCountValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveGames;
- (void)setPrimitiveGames:(NSMutableSet*)value;


@end
