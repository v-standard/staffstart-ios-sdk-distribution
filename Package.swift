// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StaffStartSDKDistribution",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreModule",
            targets: ["CoreModule"]),
        .library(
            name: "StaffStartCore",
            targets: ["StaffStart__Core"]),
        .library(
            name: "StaffStartApp",
            targets: ["StaffStart__App"]),
        .library(
            name: "StaffStartTracking",
            targets: ["StaffStart__Tracking"])
    ],
    targets: [
        .binaryTarget(name: "CoreModule",
                      path: "CoreModule.xcframework"),
        .binaryTarget(name: "StaffStart__Core",
                      path: "StaffStart__Core.xcframework"),
        .binaryTarget(name: "StaffStart__App",
                      path: "StaffStart__App.xcframework"),
        .binaryTarget(name: "StaffStart__Tracking",
                      path: "StaffStart__Tracking.xcframework")
    ]
)
