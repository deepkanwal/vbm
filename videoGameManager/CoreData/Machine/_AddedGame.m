// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedGame.m instead.

#import "_AddedGame.h"

const struct AddedGameAttributes AddedGameAttributes = {
	.coverImageMediumURLString = @"coverImageMediumURLString",
	.coverImageThumbnailURLString = @"coverImageThumbnailURLString",
	.destailsURLString = @"destailsURLString",
	.gameDescription = @"gameDescription",
	.gameId = @"gameId",
	.gameName = @"gameName",
	.isMissingData = @"isMissingData",
	.pageURLString = @"pageURLString",
	.releaseYear = @"releaseYear",
};

const struct AddedGameRelationships AddedGameRelationships = {
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
	
	if ([key isEqualToString:@"gameIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gameId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isMissingDataValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isMissingData"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic coverImageMediumURLString;






@dynamic coverImageThumbnailURLString;






@dynamic destailsURLString;






@dynamic gameDescription;






@dynamic gameId;



- (int32_t)gameIdValue {
	NSNumber *result = [self gameId];
	return [result intValue];
}

- (void)setGameIdValue:(int32_t)value_ {
	[self setGameId:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveGameIdValue {
	NSNumber *result = [self primitiveGameId];
	return [result intValue];
}

- (void)setPrimitiveGameIdValue:(int32_t)value_ {
	[self setPrimitiveGameId:[NSNumber numberWithInt:value_]];
}





@dynamic gameName;






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





@dynamic pageURLString;






@dynamic releaseYear;











@end
