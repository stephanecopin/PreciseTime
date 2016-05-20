# PreciseTime [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/stephanecopin/PreciseTime/master/LICENSE) [![GitHub release](https://img.shields.io/github/release/stephanecopin/PreciseTime.svg)](https://github.com/stephanecopin/PreciseTime/releases)

Defines a class (Objective-C) and a struct (Swift) called `PreciseTime` allowing to use the precise timing capabilities of iOS/Mac OS X using the function `mach_absolute_time()`.  
For convenience, `PreciseTime` has an interface very similar to `NSDate`, allowing to switch one for another and directly benefits from its amazing precision.

`PreciseTime` is completely documented via xcode documentation comment.

# Compatibility

Compatible with iOS 8.0, OSX 10.9, tvOS and watchOS.

# Installation

You can either add `PreciseTime` to your project (By manually copying the relevant files) or manage it via Carthage. To add it via Carthage, follow the instructions in the [Carthage repository readme](https://github.com/Carthage/Carthage).
Cocoapods support coming soon!
