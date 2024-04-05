// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RxSwift",
  platforms: [.iOS(.v9), .macOS(.v10_10), .watchOS(.v3), .tvOS(.v9)],
  products: [
    .library(
      name: "RxSwift",
      targets: ["RxSwift"]
    )
  ],
  targets: [
    .binaryTarget(
      name: "RxSwift",
      url: "https://github.com/Buzzvil/RxSwift/releases/download/v7.0.0/BuzzRxSwift.zip",
      checksum: "772edfb6e77b41f888d4430e46e00d1ec147dc9d26b3f2ce464dbc00d678f963"
    )
  ],
  swiftLanguageVersions: [.v5]
)
