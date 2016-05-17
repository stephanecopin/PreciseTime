//
//  PreciseTime.m
//  PreciseTime
//
//  Created by Stéphane Copin on 5/13/16.
//  Copyright © 2016 Stéphane Copin. All rights reserved.
//

#import "PreciseTime.h"

@import Darwin;

@interface PreciseTime ()

@property (nonatomic, assign) PreciseTimeInterval elapsedTime;

- (instancetype)initWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)decoder NS_DESIGNATED_INITIALIZER;

@end

@implementation PreciseTime

- (instancetype)init {
	mach_timebase_info_data_t timeBaseInfo;
	mach_timebase_info(&timeBaseInfo);

	return [self initWithPreciseTimeInterval:mach_absolute_time() * timeBaseInfo.numer / timeBaseInfo.denom];
}

- (instancetype)initWithPreciseTime:(PreciseTime *)preciseTime {
	return [self initWithPreciseTimeInterval:0 sincePreciseTime:preciseTime];
}

- (instancetype)initWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime {
	return [self initWithPreciseTimeInterval:preciseTimeInterval + preciseTime.elapsedTime];
}

- (instancetype)initWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval {
	self = [super init];
	if (self != nil) {
		_elapsedTime = preciseTimeInterval;
	}
	return self;
}

+ (instancetype)preciseTime {
	return [[self alloc] init];
}

+ (instancetype)preciseTimeWithPreciseTime:(PreciseTime *)preciseTime {
	return [[self alloc] initWithPreciseTime:preciseTime];
}

+ (instancetype)preciseTimeWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime {
	return [[self alloc] initWithPreciseTimeInterval:preciseTimeInterval sincePreciseTime:preciseTime];
}

- (PreciseTimeInterval)preciseTimeIntervalSincePreciseTime:(PreciseTime *)preciseTime {
	if (preciseTime.elapsedTime < self.elapsedTime) {
		return 0;
	}
	return preciseTime.elapsedTime - self.elapsedTime;
}

- (PreciseTimeInterval)preciseTimeIntervalSinceNow {
	return [self preciseTimeIntervalSincePreciseTime:[[PreciseTime alloc] init]];
}

- (NSTimeInterval)timeIntervalSincePreciseTime:(PreciseTime *)preciseTime {
	return [[self class] preciseTimeIntervalToTimeInterval:[self preciseTimeIntervalSincePreciseTime:preciseTime]];
}

- (NSTimeInterval)timeIntervalSinceNow {
	return [[self class] preciseTimeIntervalToTimeInterval:[self preciseTimeIntervalSinceNow]];
}

- (PreciseTime *)preciseTimeByAddingPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval {
	return [[self class] preciseTimeWithPreciseTimeInterval:preciseTimeInterval
																				 sincePreciseTime:self];
}

- (PreciseTime *)preciseTimeByAddingTimeInterval:(NSTimeInterval)timeInterval {
	return [[self class] preciseTimeWithPreciseTimeInterval:[[self class] timeIntervalToPreciseTimeInterval:timeInterval]
																				 sincePreciseTime:self];
}

+ (NSTimeInterval)preciseTimeIntervalToTimeInterval:(PreciseTimeInterval)preciseTimeInterval {
	return (NSTimeInterval)preciseTimeInterval / 1e9;
}

+ (PreciseTimeInterval)timeIntervalToPreciseTimeInterval:(NSTimeInterval)timeInterval {
	return (PreciseTimeInterval)(timeInterval * 1e9);
}

- (BOOL)isEqualToPreciseTime:(PreciseTime *)preciseTime {
	return self.elapsedTime == preciseTime.elapsedTime;
}

- (NSComparisonResult)compare:(PreciseTime *)preciseTime {
	if ([self isEqualToPreciseTime:preciseTime]) {
		return NSOrderedSame;
	}
	return self.elapsedTime > preciseTime.elapsedTime ? NSOrderedDescending : NSOrderedAscending;
}

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[PreciseTime class]]) {
		return false;
	}
	return [self isEqualToPreciseTime:(PreciseTime *)object];
}

- (NSUInteger)hash {
	return (NSUInteger)self.elapsedTime;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<PreciseTime %p>(interval: %llu)", self, self.elapsedTime];
}

#pragma mark - NSCopying implementation

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

#pragma mark - NSCoding implementation

- (instancetype)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if (self != nil) {
		_elapsedTime = (PreciseTimeInterval)[[decoder decodeObjectOfClass:[NSNumber class] forKey:@"elapsedTime"] unsignedLongLongValue];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:@(self.elapsedTime) forKey:@"elapsedTime"];
}

#pragma mark - NSSecureCoding implementation

+ (BOOL)supportsSecureCoding {
	return YES;
}

@end
