//
//  PreciseTime.h
//  PreciseTime
//
//  Created by Stéphane Copin on 5/13/16.
//  Copyright © 2016 Stéphane Copin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Describe a time interval in nanoseconds.
 *  @c PreciseTime provides helpers methods to convert to/from a NSTimeInterval,
 *  which stores a time interval in seconds.
 */
typedef uint64_t PreciseTimeInterval;

/**
 *  A class representing a precise time.
 *  It's basically a wrapper around the @c mach_absolute_time() function, with some goodies.
 *  This object can be compared via @c[-isEqual] and its @c hash is defined
 */
NS_REFINED_FOR_SWIFT
@interface PreciseTime : NSObject <NSCopying, NSSecureCoding>

/**
 *  Returns the precise time interval that elapsed since the creation of the object.
 */
@property (nonatomic, assign, readonly) PreciseTimeInterval preciseTimeIntervalSinceNow;
/**
 *  Returns the time interval that elapsed since the creation of the object.
 */
@property (nonatomic, assign, readonly) NSTimeInterval timeIntervalSinceNow;

/**
 *  Initialize a new PreciseTime object with a time reference set to now.
 *
 *  @return An initialized PreciseTime object.
 */
- (instancetype)init;
/**
 *  Initialize a new PreciseTime object with a time reference set to that of the argument.
 *
 *  @param preciseTime The precise time to copy the time reference from.
 *
 *  @return An initialized PreciseTime object.
 */
- (instancetype)initWithPreciseTime:(PreciseTime *)preciseTime;
/**
 *  Initialize a new PreciseTime object with a time reference set to that of the second argument,
 *  added with the first argument.
 *
 *  @param preciseTimeInterval The interval to add to the time reference.
 *  @param preciseTime         The precise time to copy the time reference from.
 *
 *  @return An initialized PreciseTime object.
 */
- (instancetype)initWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime;

/**
 *  Create a new PreciseTime object with a time reference set to now.
 *
 *  @return A new PreciseTime object.
 */
+ (instancetype)preciseTime;
/**
 *  Create a new PreciseTime object with a time reference set to that of the argument.
 *
 *  @param preciseTime The precise time to copy the time reference from.
 *
 *  @return A new PreciseTime object.
 */
+ (instancetype)preciseTimeWithPreciseTime:(PreciseTime *)preciseTime;
/**
 *  Create a new PreciseTime object with a time reference set to that of the second argument,
 *  added with the first argument.
 *
 *  @param preciseTimeInterval The interval to add to the time reference.
 *  @param preciseTime         The precise time to copy the time reference from.
 *
 *  @return A new PreciseTime object.
 */
+ (instancetype)preciseTimeWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime;

/**
 *  Return the precise time interval that elapsed compared to another PreciseTime's time reference.
 *
 *  @param preciseTime The PreciseTime to compare to.
 *
 *  @return The resulting precise time interval
 */
- (PreciseTimeInterval)preciseTimeIntervalSincePreciseTime:(PreciseTime *)preciseTime;

/**
 *  Return the time interval that elapsed compared to another PreciseTime's time reference.
 *
 *  @param preciseTime The PreciseTime to compare to.
 *
 *  @return The resulting time interval
 */
- (NSTimeInterval)timeIntervalSincePreciseTime:(PreciseTime *)preciseTime;

/**
 *  Create a new PreciseTime object by adding a precise time interval to the time reference to the receiver.
 *  Equivalent to doing:
 *  @code
 *    [PreciseTime @c preciseTimeWithPreciseTimeInterval:<#preciseTimeInterval#> @c preciseTime:self]
 *  @endcode
 *
 *  @param preciseTimeInterval The interval to add to the receiver's time reference.
 *
 *  @return A new PreciseTime object.
 */
- (PreciseTime *)preciseTimeByAddingPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval;
/**
 *  Create a new PreciseTime object by adding a time interval to the time reference to the receiver.
 *  Equivalent to doing:
 *  @code
 *    PreciseTimeInterval preciseTimeInterval = [PreciseTime timeIntervalToPreciseTimeInterval:<#timeInterval#>];
 *		[PreciseTime preciseTimeWithPreciseTimeInterval:preciseTimeInterval preciseTime:self];
 *  @endcode
 *
 *  @param timeInterval The interval to add to the receiver's time reference.
 *
 *  @return A new PreciseTime object.
 */
- (PreciseTime *)preciseTimeByAddingTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  Converts a precise time interval to a time interval (nanoseconds to seconds conversion)
 *
 *  @param preciseTimeInterval The precise time interval to convert from in nanoseconds.
 *
 *  @return The resulting time interval in seconds
 */
+ (NSTimeInterval)preciseTimeIntervalToTimeInterval:(PreciseTimeInterval)preciseTimeInterval;
/**
 *  Converts a time interval to a precise time interval (seconds to nanoseconds conversion)
 *
 *  @param timeInterval The time interval to convert from in seconds.
 *
 *  @return The resulting precise time interval in nanoseconds
 */
+ (PreciseTimeInterval)timeIntervalToPreciseTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  Test if the receiver is equal to the first argument.
 *
 *  @param preciseTime The precise time to compare the receiver against.
 *
 *  @return YES if both objects have the same time difference, NO otherwise.
 */
- (BOOL)isEqualToPreciseTime:(PreciseTime *)preciseTime;

/**
 *  Compare the receiver against the first argument.
 *
 *  @param preciseTime The precise time to compare the receiver against.
 *
 *  @return
 *		NSOrderedDescending if the receiver has a time reference later than the first argument.
 *		NSOrderedEqual if the receiver and the first argument have the same time reference.
 *		NSOrderedAscending if the receiver has a time reference earlier than the first argument.
 */
- (NSComparisonResult)compare:(PreciseTime *)preciseTime;

@end

NS_ASSUME_NONNULL_END
