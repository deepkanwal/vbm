// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddedPlatform.m instead.

#import "_AddedPlatform.h"

const struct AddedPlatformAttributes AddedPlatformAttributes = {
	.count = @"count",
	.name = @"name",
};

const struct AddedPlatformRelationships AddedPlatformRelationships = {
	.games = @"games",
};

const struct AddedPlatformFetchedProperties AddedPlatformFetchedProperties = {
};

@implementation AddedPlatformID
@end

@implementation _AddedPlatform

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AddedPlatform" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AddedPlatform";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AddedPlatform" inManagedObjectContext:moc_];
}

- (AddedPlatformID*)objectID {
	return (AddedPlatformID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"countValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"count"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic count;



- (int32_t)countValue {
	NSNumber *result = [self count];
	return [result intValue];
}

- (void)setCountValue:(int32_t)value_ {
	[self setCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCountValue {
	NSNumber *result = [self primitiveCount];
	return [result intValue];
}

- (void)setPrimitiveCountValue:(int32_t)value_ {
	[self setPrimitiveCount:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic games;

	
- (NSMutableSet*)gamesSet {
	[self willAccessValueForKey:@"games"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"games"];
  
	[self didAccessValueForKey:@"games"];
	return result;
}
	






@end
