//
//  PreciseTime.swift
//  PreciseTime
//
//  Created by Stéphane Copin on 5/19/16.
//  Copyright © 2016 Stéphane Copin. All rights reserved.
//

import Foundation
import Darwin

/**
Describe a time interval in nanoseconds.
`PreciseTime` provides helpers methods to convert to/from a NSTimeInterval,
which stores a time interval in seconds.
*/
public typealias PreciseTimeInterval = UInt64

/**
A struct representing a precise time.
It's basically a wrapper around the `mach_absolute_time()` function, with some goodies.
*/
public struct PreciseTime {
	private let timeReference: PreciseTimeInterval

	/// Returns the precise time interval that elapsed since the creation of the object.
	public var preciseTimeIntervalSinceNow: PreciseTimeInterval {
		return self.preciseTimeIntervalSincePreciseTime(PreciseTime())
	}

	/// Returns the time interval that elapsed since the creation of the object.
	public var timeIntervalSinceNow: NSTimeInterval {
		return PreciseTime.preciseTimeIntervalToTimeInterval(self.preciseTimeIntervalSinceNow)
	}

	/**
	Initialize a new PreciseTime object with a time reference set to now.

	- returns: An initialized PreciseTime object.
	*/
	public init() {
		var timeBaseInfo = mach_timebase_info_data_t()
		mach_timebase_info(&timeBaseInfo);

		self.init(timeReference: mach_absolute_time() * UInt64(timeBaseInfo.numer) / UInt64(timeBaseInfo.denom))
	}

	/**
	Initialize a new PreciseTime object with a time reference set to that of the argument.

	- parameter preciseTime The precise time to copy the time reference from.

	- returns: An initialized PreciseTime object.
	*/
	public init(preciseTime: PreciseTime) {
		self.init(timeReference: preciseTime.timeReference)
	}

	public init(_ preciseTime: __PreciseTime) {
		self.init(preciseTime: preciseTime.preciseTimeReference)
	}

	/**
	Initialize a new PreciseTime object with a time reference set to that of the second argument,
	added with the first argument.

	- parameter preciseTimeInterval The interval to add to the time reference.
	- parameter preciseTime         The precise time to copy the time reference from.

	- returns: An initialized PreciseTime object.
	*/
	public init(preciseTimeInterval: PreciseTimeInterval, sincePreciseTime preciseTime: PreciseTime) {
		self.init(timeReference: preciseTime.timeReference + preciseTimeInterval)
	}

	private init(timeReference: PreciseTimeInterval) {
		self.timeReference = timeReference
	}

	/**
	Return the precise time interval that elapsed compared to another PreciseTime's time reference.

	- parameter preciseTime The PreciseTime to compare to.

	- returns: The resulting precise time interval
	*/
	public func preciseTimeIntervalSincePreciseTime(preciseTime: PreciseTime) -> PreciseTimeInterval {
		if preciseTime.timeReference < self.timeReference {
			return 0
		}
		return preciseTime.timeReference - self.timeReference
	}

	/**
	Return the time interval that elapsed compared to another PreciseTime's time reference.

	- parameter preciseTime The PreciseTime to compare to.

	- returns: The resulting time interval
	*/
	public func timeIntervalSincePreciseTime(preciseTime: PreciseTime) -> NSTimeInterval {
		return PreciseTime.preciseTimeIntervalToTimeInterval(self.preciseTimeIntervalSincePreciseTime(preciseTime))
	}

	/**
	Create a new PreciseTime object by adding a precise time interval to the time reference to the receiver.
	Equivalent to doing:

		[PreciseTime @c preciseTimeWithPreciseTimeInterval:<#preciseTimeInterval#> @c preciseTime:self]

	- parameter preciseTimeInterval The interval to add to the receiver's time reference.

	- returns: A new PreciseTime object.
	*/
	public func preciseTimeByAddingPreciseTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> PreciseTime {
		return PreciseTime(preciseTimeInterval: preciseTimeInterval, sincePreciseTime: self)
	}

	/**
	Create a new PreciseTime object by adding a time interval to the time reference to the receiver.
	Equivalent to doing:

		PreciseTimeInterval preciseTimeInterval = [PreciseTime timeIntervalToPreciseTimeInterval:<#timeInterval#>];
		[PreciseTime preciseTimeWithPreciseTimeInterval:preciseTimeInterval preciseTime:self];

	- parameter timeInterval The interval to add to the receiver's time reference.

	- returns: A new PreciseTime object.
	*/
	public func preciseTimeByAddingTimeInterval(timeInterval: NSTimeInterval) -> PreciseTime {
		return self.preciseTimeByAddingPreciseTimeInterval(PreciseTime.timeIntervalToPreciseTimeInterval(timeInterval))
	}

	/**
	Converts a precise time interval to a time interval (nanoseconds to seconds conversion)

	- parameter preciseTimeInterval The precise time interval to convert from in nanoseconds.

	- returns: The resulting time interval in seconds
	*/
	public static func preciseTimeIntervalToTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> NSTimeInterval {
		return NSTimeInterval(preciseTimeInterval) / 1e9
	}

	/**
	Converts a time interval to a precise time interval (seconds to nanoseconds conversion)

	- parameter timeInterval The time interval to convert from in seconds.

	- returns: The resulting precise time interval in nanoseconds
	*/
	public static func timeIntervalToPreciseTimeInterval(timeInterval: NSTimeInterval) -> PreciseTimeInterval {
		return PreciseTimeInterval(timeInterval * 1e9)
	}

	/**
	Compare the receiver against the first argument.

	- parameter preciseTime The precise time to compare the receiver against.

	- returns:
	`NSOrderedDescending` if the receiver has a time reference later than the first argument.  \
	`NSOrderedEqual` if the receiver and the first argument have the same time reference.  \
	`NSOrderedAscending` if the receiver has a time reference earlier than the first argument.
	*/
	public func compare(preciseTime: PreciseTime) -> NSComparisonResult {
		if self.timeReference == preciseTime.timeReference {
			return .OrderedSame
		}
		return self.timeReference > preciseTime.timeReference ? .OrderedDescending : .OrderedAscending
	}
}

extension PreciseTime: Hashable {
	public var hashValue: Int {
		return self.timeReference.hashValue
	}
}

public func ==(preciseTime1: PreciseTime, preciseTime2: PreciseTime) -> Bool {
	return preciseTime1.timeReference == preciseTime2.timeReference
}

/**
A class representing a precise time.
It is a wrapper against the swift struct PreciseTime, please refer to the documentation of that struct for more information.
It shouldn't be used in Swift.
*/
@objc(PreciseTime)
public final class __PreciseTime : NSObject {
	private let preciseTimeReference: PreciseTime
	public var preciseTimeIntervalSinceNow: PreciseTimeInterval {
		return self.preciseTimeReference.preciseTimeIntervalSinceNow
	}

	public var timeIntervalSinceNow: NSTimeInterval {
		return self.preciseTimeReference.timeIntervalSinceNow
	}

	public override init() {
		self.preciseTimeReference = PreciseTime()
	}

	public init(preciseTime: __PreciseTime) {
		self.preciseTimeReference = PreciseTime(preciseTime: preciseTime.preciseTimeReference)
	}

	public init(_ preciseTime: PreciseTime) {
		self.preciseTimeReference = PreciseTime(preciseTime: preciseTime)
	}

	public init(preciseTimeInterval: PreciseTimeInterval, sincePreciseTime preciseTime: __PreciseTime) {
		self.preciseTimeReference = PreciseTime(preciseTimeInterval: preciseTimeInterval, sincePreciseTime: preciseTime.preciseTimeReference)
	}

	private init(timeReference: PreciseTimeInterval) {
		self.preciseTimeReference = PreciseTime(timeReference: timeReference)
	}

	public func preciseTimeIntervalSincePreciseTime(preciseTime: __PreciseTime) -> PreciseTimeInterval {
		return self.preciseTimeReference.preciseTimeIntervalSincePreciseTime(preciseTime.preciseTimeReference)
	}

	public func timeIntervalSincePreciseTime(preciseTime: __PreciseTime) -> NSTimeInterval {
		return self.preciseTimeReference.timeIntervalSincePreciseTime(preciseTime.preciseTimeReference)
	}

	public func preciseTimeByAddingPreciseTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> __PreciseTime {
		return __PreciseTime(self.preciseTimeReference.preciseTimeByAddingPreciseTimeInterval(preciseTimeInterval))
	}

	public func preciseTimeByAddingTimeInterval(timeInterval: NSTimeInterval) -> __PreciseTime {
		return __PreciseTime(self.preciseTimeReference.preciseTimeByAddingTimeInterval(timeInterval))
	}

	public class func preciseTimeIntervalToTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> NSTimeInterval {
		return PreciseTime.preciseTimeIntervalToTimeInterval(preciseTimeInterval)
	}

	public class func timeIntervalToPreciseTimeInterval(timeInterval: NSTimeInterval) -> PreciseTimeInterval {
		return PreciseTime.timeIntervalToPreciseTimeInterval(timeInterval)
	}

	/**
	Test if the receiver is equal to the first argument.

	- parameter preciseTime The precise time to compare the receiver against.

	- returns: YES if both objects have the same time difference, NO otherwise.
	*/
	public func isEqualToPreciseTime(preciseTime: __PreciseTime) -> Bool {
		return self.preciseTimeReference == preciseTime.preciseTimeReference
	}

	public func compare(preciseTime: __PreciseTime) -> NSComparisonResult {
		return self.preciseTimeReference.compare(preciseTime.preciseTimeReference)
	}
}

extension __PreciseTime: NSCopying {
	public func copyWithZone(zone: NSZone) -> AnyObject {
		return self
	}
}

extension __PreciseTime: NSSecureCoding {
	public convenience init?(coder decoder: NSCoder) {
		guard let timeReference = decoder.decodeObjectOfClass(NSNumber.self, forKey: "timeReference") else {
			return nil
		}
		self.init(timeReference: timeReference.unsignedLongLongValue)
	}

	public func encodeWithCoder(coder: NSCoder) {
		coder.encodeObject(NSNumber(unsignedLongLong: self.preciseTimeReference.timeReference))
	}

	public static func supportsSecureCoding() -> Bool {
		return true
	}
}
