// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedGame.m instead.

#import "_AddedGame.h"

const struct AddedGameAttributes AddedGameAttributes = {
	.coverImageMediumURLString = @"coverImageMediumURLString",
	.coverImageThumbnailURLString = @"coverImageThumbnailURLString",
	.detailsURLString = @"detailsURLString",
	.developers = @"developers",
	.gameDescription = @"gameDescription",
	.gameId = @"gameId",
	.gameName = @"gameName",
	.genres = @"genres",
	.isBeaten = @"isBeaten",
	.isFavourite = @"isFavourite",
	.isMissingData = @"isMissingData",
	.largeImages = @"largeImages",
	.notes = @"notes",
	.nowPlaying = @"nowPlaying",
	.pageURLString = @"pageURLString",
	.platforms = @"platforms",
	.progress = @"progress",
	.publishers = @"publishers",
	.rating = @"rating",
	.releaseYear = @"releaseYear",
	.thumbnailImages = @"thumbnailImages",
	.yearBought = @"yearBought",
};

const struct AddedGameRelationships AddedGameRelationships = {
	.platform = @"platform",
};

const struct AddedGameFetchedProperties AddedGameFetchedProperties = {
};

@implementation AddedGameID
@end

@implementation _AddedGame

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AddedGame" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AddedGame";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AddedGame" inManagedObjectContext:moc_];
}

- (AddedGameID*)objectID {
	return (AddedGameID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isBeatenValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isBeaten"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isFavouriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavourite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isMissingDataValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isMissingData"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"nowPlayingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nowPlaying"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"progressValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"progress"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic coverImageMediumURLString;






@dynamic coverImageThumbnailURLString;






@dynamic detailsURLString;






@dynamic developers;






@dynamic gameDescription;






@dynamic gameId;






@dynamic gameName;






@dynamic genres;






@dynamic isBeaten;



- (BOOL)isBeatenValue {
	NSNumber *result = [self isBeaten];
	return [result boolValue];
}

- (void)setIsBeatenValue:(BOOL)value_ {
	[self setIsBeaten:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsBeatenValue {
	NSNumber *result = [self primitiveIsBeaten];
	return [result boolValue];
}

- (void)setPrimitiveIsBeatenValue:(BOOL)value_ {
	[self setPrimitiveIsBeaten:[NSNumber numberWithBool:value_]];
}





@dynamic isFavourite;



- (BOOL)isFavouriteValue {
	NSNumber *result = [self isFavourite];
	return [result boolValue];
}

- (void)setIsFavouriteValue:(BOOL)value_ {
	[self setIsFavourite:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFavouriteValue {
	NSNumber *result = [self primitiveIsFavourite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavouriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavourite:[NSNumber numberWithBool:value_]];
}





@dynamic isMissingData;



- (BOOL)isMissingDataValue {
	NSNumber *result = [self isMissingData];
	return [result boolValue];
}

- (void)setIsMissingDataValue:(BOOL)value_ {
	[self setIsMissingData:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsMissingDataValue {
	NSNumber *result = [self primitiveIsMissingData];
	return [result boolValue];
}

- (void)setPrimitiveIsMissingDataValue:(BOOL)value_ {
	[self setPrimitiveIsMissingData:[NSNumber numberWithBool:value_]];
}





@dynamic largeImages;






@dynamic notes;






@dynamic nowPlaying;



- (BOOL)nowPlayingValue {
	NSNumber *result = [self nowPlaying];
	return [result boolValue];
}

- (void)setNowPlayingValue:(BOOL)value_ {
	[self setNowPlaying:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveNowPlayingValue {
	NSNumber *result = [self primitiveNowPlaying];
	return [result boolValue];
}

- (void)setPrimitiveNowPlayingValue:(BOOL)value_ {
	[self setPrimitiveNowPlaying:[NSNumber numberWithBool:value_]];
}





@dynamic pageURLString;






@dynamic platforms;






@dynamic progress;



- (int32_t)progressValue {
	NSNumber *result = [self progress];
	return [result intValue];
}

- (void)setProgressValue:(int32_t)value_ {
	[self setProgress:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProgressValue {
	NSNumber *result = [self primitiveProgress];
	return [result intValue];
}

- (void)setPrimitiveProgressValue:(int32_t)value_ {
	[self setPrimitiveProgress:[NSNumber numberWithInt:value_]];
}





@dynamic publishers;






@dynamic rating;



- (int32_t)ratingValue {
	NSNumber *result = [self rating];
	return [result intValue];
}

- (void)setRatingValue:(int32_t)value_ {
	[self setRating:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result intValue];
}

- (void)setPrimitiveRatingValue:(int32_t)value_ {
	[self setPrimitiveRating:[NSNumber numberWithInt:value_]];
}





@dynamic releaseYear;






@dynamic thumbnailImages;






@dynamic yearBought;






@dynamic platform;

	






@end
