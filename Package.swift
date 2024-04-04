// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "BuzzRxSwift",
  platforms: [.iOS(.v12)],
  products: ([
    [
      .library(name: "BuzzRxSwift", targets: ["BuzzRxSwift"]),
      .library(name: "BuzzRxSwift-Dynamic", type: .dynamic, targets: ["BuzzRxSwift"]),
    ],
  ] as [[Product]]).flatMap { $0 },
  targets: ([
    [
      .target(name: "BuzzRxSwift", dependencies: []),
    ], 
  ] as [[Target]]).flatMap { $0 },
  swiftLanguageVersions: [.v5]
)
