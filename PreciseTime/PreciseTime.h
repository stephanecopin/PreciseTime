//
//  PreciseTime.h
//  PreciseTime
//
//  Created by Stéphane Copin on 5/13/16.
//  Copyright © 2016 Stéphane Copin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef uint64_t PreciseTimeInterval; // Describe a time interval in nanoseconds

@interface PreciseTime : NSObject <NSCopying, NSSecureCoding>

@property (nonatomic, assign, readonly) PreciseTimeInterval preciseTimeIntervalSinceNow;
@property (nonatomic, assign, readonly) NSTimeInterval timeIntervalSinceNow;

- (instancetype)init;
- (instancetype)initWithPreciseTime:(PreciseTime *)preciseTime;
- (instancetype)initWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime;

+ (instancetype)preciseTime;
+ (instancetype)preciseTimeWithPreciseTime:(PreciseTime *)preciseTime;
+ (instancetype)preciseTimeWithPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval sincePreciseTime:(PreciseTime *)preciseTime;

- (PreciseTimeInterval)preciseTimeIntervalSincePreciseTime:(PreciseTime *)preciseTime;

- (NSTimeInterval)timeIntervalSincePreciseTime:(PreciseTime *)preciseTime;

- (PreciseTime *)preciseTimeByAddingPreciseTimeInterval:(PreciseTimeInterval)preciseTimeInterval;
- (PreciseTime *)preciseTimeByAddingTimeInterval:(NSTimeInterval)timeInterval;

+ (NSTimeInterval)preciseTimeIntervalToTimeInterval:(PreciseTimeInterval)preciseTimeInterval;
+ (PreciseTimeInterval)timeIntervalToPreciseTimeInterval:(NSTimeInterval)preciseTimeInterval;

- (BOOL)isEqualToPreciseTime:(PreciseTime *)preciseTime;

- (NSComparisonResult)compare:(PreciseTime *)preciseTime;

@end

NS_ASSUME_NONNULL_END
