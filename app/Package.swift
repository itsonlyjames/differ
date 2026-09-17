// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Differ",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "Differ",
            resources: [
                .copy("Resources/index.html")
            ]
        )
    ]
)
