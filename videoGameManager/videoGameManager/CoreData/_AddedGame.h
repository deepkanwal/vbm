// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedGame.h instead.

#import <CoreData/CoreData.h>


extern const struct AddedGameAttributes {
	__unsafe_unretained NSString *coverImageMediumURLString;
	__unsafe_unretained NSString *coverImageThumbnailURLString;
	__unsafe_unretained NSString *detailsURLString;
	__unsafe_unretained NSString *developers;
	__unsafe_unretained NSString *gameDescription;
	__unsafe_unretained NSString *gameId;
	__unsafe_unretained NSString *gameName;
	__unsafe_unretained NSString *genres;
	__unsafe_unretained NSString *isBeaten;
	__unsafe_unretained NSString *isFavourite;
	__unsafe_unretained NSString *isMissingData;
	__unsafe_unretained NSString *largeImages;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *nowPlaying;
	__unsafe_unretained NSString *pageURLString;
	__unsafe_unretained NSString *platforms;
	__unsafe_unretained NSString *progress;
	__unsafe_unretained NSString *publishers;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *releaseYear;
	__unsafe_unretained NSString *thumbnailImages;
	__unsafe_unretained NSString *yearBought;
} AddedGameAttributes;

extern const struct AddedGameRelationships {
	__unsafe_unretained NSString *platform;
} AddedGameRelationships;

extern const struct AddedGameFetchedProperties {
} AddedGameFetchedProperties;

@class AddedPlatform;
























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





@property (nonatomic, strong) NSString* detailsURLString;



//- (BOOL)validateDetailsURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* developers;



//- (BOOL)validateDevelopers:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* gameDescription;



//- (BOOL)validateGameDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* gameId;



//- (BOOL)validateGameId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* gameName;



//- (BOOL)validateGameName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* genres;



//- (BOOL)validateGenres:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isBeaten;



@property BOOL isBeatenValue;
- (BOOL)isBeatenValue;
- (void)setIsBeatenValue:(BOOL)value_;

//- (BOOL)validateIsBeaten:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isFavourite;



@property BOOL isFavouriteValue;
- (BOOL)isFavouriteValue;
- (void)setIsFavouriteValue:(BOOL)value_;

//- (BOOL)validateIsFavourite:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isMissingData;



@property BOOL isMissingDataValue;
- (BOOL)isMissingDataValue;
- (void)setIsMissingDataValue:(BOOL)value_;

//- (BOOL)validateIsMissingData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* largeImages;



//- (BOOL)validateLargeImages:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* notes;



//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* nowPlaying;



@property BOOL nowPlayingValue;
- (BOOL)nowPlayingValue;
- (void)setNowPlayingValue:(BOOL)value_;

//- (BOOL)validateNowPlaying:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* pageURLString;



//- (BOOL)validatePageURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* platforms;



//- (BOOL)validatePlatforms:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* progress;



@property int32_t progressValue;
- (int32_t)progressValue;
- (void)setProgressValue:(int32_t)value_;

//- (BOOL)validateProgress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* publishers;



//- (BOOL)validatePublishers:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rating;



@property int32_t ratingValue;
- (int32_t)ratingValue;
- (void)setRatingValue:(int32_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* releaseYear;



//- (BOOL)validateReleaseYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* thumbnailImages;



//- (BOOL)validateThumbnailImages:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* yearBought;



//- (BOOL)validateYearBought:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) AddedPlatform *platform;

//- (BOOL)validatePlatform:(id*)value_ error:(NSError**)error_;





@end

@interface _AddedGame (CoreDataGeneratedAccessors)

@end

@interface _AddedGame (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCoverImageMediumURLString;
- (void)setPrimitiveCoverImageMediumURLString:(NSString*)value;




- (NSString*)primitiveCoverImageThumbnailURLString;
- (void)setPrimitiveCoverImageThumbnailURLString:(NSString*)value;




- (NSString*)primitiveDetailsURLString;
- (void)setPrimitiveDetailsURLString:(NSString*)value;




- (NSData*)primitiveDevelopers;
- (void)setPrimitiveDevelopers:(NSData*)value;




- (NSString*)primitiveGameDescription;
- (void)setPrimitiveGameDescription:(NSString*)value;




- (NSString*)primitiveGameId;
- (void)setPrimitiveGameId:(NSString*)value;




- (NSString*)primitiveGameName;
- (void)setPrimitiveGameName:(NSString*)value;




- (NSData*)primitiveGenres;
- (void)setPrimitiveGenres:(NSData*)value;




- (NSNumber*)primitiveIsBeaten;
- (void)setPrimitiveIsBeaten:(NSNumber*)value;

- (BOOL)primitiveIsBeatenValue;
- (void)setPrimitiveIsBeatenValue:(BOOL)value_;




- (NSNumber*)primitiveIsFavourite;
- (void)setPrimitiveIsFavourite:(NSNumber*)value;

- (BOOL)primitiveIsFavouriteValue;
- (void)setPrimitiveIsFavouriteValue:(BOOL)value_;




- (NSNumber*)primitiveIsMissingData;
- (void)setPrimitiveIsMissingData:(NSNumber*)value;

- (BOOL)primitiveIsMissingDataValue;
- (void)setPrimitiveIsMissingDataValue:(BOOL)value_;




- (NSData*)primitiveLargeImages;
- (void)setPrimitiveLargeImages:(NSData*)value;




- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;




- (NSNumber*)primitiveNowPlaying;
- (void)setPrimitiveNowPlaying:(NSNumber*)value;

- (BOOL)primitiveNowPlayingValue;
- (void)setPrimitiveNowPlayingValue:(BOOL)value_;




- (NSString*)primitivePageURLString;
- (void)setPrimitivePageURLString:(NSString*)value;




- (NSData*)primitivePlatforms;
- (void)setPrimitivePlatforms:(NSData*)value;




- (NSNumber*)primitiveProgress;
- (void)setPrimitiveProgress:(NSNumber*)value;

- (int32_t)primitiveProgressValue;
- (void)setPrimitiveProgressValue:(int32_t)value_;




- (NSData*)primitivePublishers;
- (void)setPrimitivePublishers:(NSData*)value;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int32_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int32_t)value_;




- (NSString*)primitiveReleaseYear;
- (void)setPrimitiveReleaseYear:(NSString*)value;




- (NSData*)primitiveThumbnailImages;
- (void)setPrimitiveThumbnailImages:(NSData*)value;




- (NSString*)primitiveYearBought;
- (void)setPrimitiveYearBought:(NSString*)value;





- (AddedPlatform*)primitivePlatform;
- (void)setPrimitivePlatform:(AddedPlatform*)value;


@end
