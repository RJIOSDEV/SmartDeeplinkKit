// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SmartDeeplink",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SmartDeeplink",             // This is the name users will import via SPM
            targets: ["SmartDeeplinkKit"]      // This is your actual target folder name
        ),
    ],
    targets: [
        .target(
            name: "SmartDeeplinkKit",          // Target name matches your Sources/<target>
            dependencies: [],
            path: "Sources/SmartDeeplinkKit"   // Explicit path is safer
        ),
        .testTarget(
            name: "SmartDeeplinkTests",
            dependencies: ["SmartDeeplinkKit"],
            path: "Tests/SmartDeeplinkTests"
        ),
    ]
)
