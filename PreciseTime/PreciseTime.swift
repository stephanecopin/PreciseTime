//
//  PreciseTime.swift
//  PreciseTime
//
//  Created by Stéphane Copin on 5/19/16.
//  Copyright © 2016 Stéphane Copin. All rights reserved.
//

import Foundation

public struct PreciseTime {
	private let __preciseTime: __PreciseTime

	public var preciseTimeIntervalSinceNow: PreciseTimeInterval {
		return self.__preciseTime.preciseTimeIntervalSinceNow
	}

	public var timeIntervalSinceNow: NSTimeInterval {
		return self.__preciseTime.timeIntervalSinceNow
	}

	public init() {
		self.__preciseTime = __PreciseTime()
	}

	public init(preciseTime: PreciseTime) {
		self.__preciseTime = __PreciseTime(preciseTime: preciseTime.__preciseTime)
	}

	public init(_ preciseTime: __PreciseTime) {
		self.__preciseTime = __PreciseTime(preciseTime: preciseTime)
	}

	public init(preciseTimeInterval: PreciseTimeInterval, sincePreciseTime preciseTime: PreciseTime) {
		self.__preciseTime = __PreciseTime(preciseTimeInterval: preciseTimeInterval, sincePreciseTime: preciseTime.__preciseTime)
	}

	public func preciseTimeIntervalSincePreciseTime(preciseTime: PreciseTime) -> PreciseTimeInterval {
		return self.__preciseTime.preciseTimeIntervalSincePreciseTime(preciseTime.__preciseTime)
	}

	public func timeIntervalSincePreciseTime(preciseTime: PreciseTime) -> NSTimeInterval {
		return self.__preciseTime.timeIntervalSincePreciseTime(preciseTime.__preciseTime)
	}

	public func preciseTimeByAddingPreciseTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> __PreciseTime {
		return self.__preciseTime.preciseTimeByAddingPreciseTimeInterval(preciseTimeInterval)
	}

	public func preciseTimeByAddingTimeInterval(timeInterval: NSTimeInterval) -> PreciseTime
 {
	return PreciseTime(self.__preciseTime.preciseTimeByAddingTimeInterval(timeInterval))
	}

	public static func preciseTimeIntervalToTimeInterval(preciseTimeInterval: PreciseTimeInterval) -> NSTimeInterval {
		return __PreciseTime.preciseTimeIntervalToTimeInterval(preciseTimeInterval)
	}

	public static func timeIntervalToPreciseTimeInterval(timeInterval: NSTimeInterval) -> PreciseTimeInterval {
		return __PreciseTime.timeIntervalToPreciseTimeInterval(timeInterval)
	}

	public func isEqualToPreciseTime(preciseTime: PreciseTime) -> Bool {
		return self.__preciseTime.isEqualToPreciseTime(preciseTime.__preciseTime)
	}

	public func compare(preciseTime: PreciseTime) -> NSComparisonResult {
		return self.__preciseTime.compare(preciseTime.__preciseTime)
	}
}

extension PreciseTime: Hashable {
	public var hashValue: Int {
		return self.__preciseTime.hashValue
	}
}

public func ==(preciseTime1: PreciseTime, preciseTime2: PreciseTime) -> Bool {
	return preciseTime1.__preciseTime == preciseTime2.__preciseTime
}

extension __PreciseTime {
	convenience init(_ preciseTime: PreciseTime) {
		self.init(preciseTime: preciseTime.__preciseTime)
	}
}
