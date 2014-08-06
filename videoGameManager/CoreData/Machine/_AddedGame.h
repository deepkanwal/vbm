// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedGame.h instead.

#import <CoreData/CoreData.h>


extern const struct AddedGameAttributes {
	__unsafe_unretained NSString *coverImageMediumURLString;
	__unsafe_unretained NSString *coverImageThumbnailURLString;
	__unsafe_unretained NSString *destailsURLString;
	__unsafe_unretained NSString *gameDescription;
	__unsafe_unretained NSString *gameId;
	__unsafe_unretained NSString *gameName;
	__unsafe_unretained NSString *isMissingData;
	__unsafe_unretained NSString *pageURLString;
	__unsafe_unretained NSString *releaseYear;
} AddedGameAttributes;

extern const struct AddedGameRelationships {
} AddedGameRelationships;

extern const struct AddedGameFetchedProperties {
} AddedGameFetchedProperties;












@interface AddedGameID : NSManagedObjectID {}
@end

@interface _AddedGame : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AddedGameID*)objectID;





@property (nonatomic, strong) NSString* coverImageMediumURLString;



//- (BOOL)validateCoverImageMediumURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* coverImageThumbnailURLString;



//- (BOOL)validateCoverImageThumbnailURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* destailsURLString;



//- (BOOL)validateDestailsURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* gameDescription;



//- (BOOL)validateGameDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* gameId;



@property int32_t gameIdValue;
- (int32_t)gameIdValue;
- (void)setGameIdValue:(int32_t)value_;

//- (BOOL)validateGameId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* gameName;



//- (BOOL)validateGameName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isMissingData;



@property BOOL isMissingDataValue;
- (BOOL)isMissingDataValue;
- (void)setIsMissingDataValue:(BOOL)value_;

//- (BOOL)validateIsMissingData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* pageURLString;



//- (BOOL)validatePageURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* releaseYear;



//- (BOOL)validateReleaseYear:(id*)value_ error:(NSError**)error_;






@end

@interface _AddedGame (CoreDataGeneratedAccessors)

@end

@interface _AddedGame (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCoverImageMediumURLString;
- (void)setPrimitiveCoverImageMediumURLString:(NSString*)value;




- (NSString*)primitiveCoverImageThumbnailURLString;
- (void)setPrimitiveCoverImageThumbnailURLString:(NSString*)value;




- (NSString*)primitiveDestailsURLString;
- (void)setPrimitiveDestailsURLString:(NSString*)value;




- (NSString*)primitiveGameDescription;
- (void)setPrimitiveGameDescription:(NSString*)value;




- (NSNumber*)primitiveGameId;
- (void)setPrimitiveGameId:(NSNumber*)value;

- (int32_t)primitiveGameIdValue;
- (void)setPrimitiveGameIdValue:(int32_t)value_;




- (NSString*)primitiveGameName;
- (void)setPrimitiveGameName:(NSString*)value;




- (NSNumber*)primitiveIsMissingData;
- (void)setPrimitiveIsMissingData:(NSNumber*)value;

- (BOOL)primitiveIsMissingDataValue;
- (void)setPrimitiveIsMissingDataValue:(BOOL)value_;




- (NSString*)primitivePageURLString;
- (void)setPrimitivePageURLString:(NSString*)value;




- (NSString*)primitiveReleaseYear;
- (void)setPrimitiveReleaseYear:(NSString*)value;




@end
