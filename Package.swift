// swift-tools-version: 5.5
//
// SPDX-License-Identifier: libpng-2.0
// Copyright Contributors to the PNG Reference Library project

import Foundation
import PackageDescription

// static unless SWIFT_COLLECTIVE_DYNAMIC_LIBRARIES=1, which a host linking this into several
// dynamic frameworks sets so they share one copy instead of each carrying its own
// windows stays static since a dynamic C library there exports nothing
#if os(Windows)
  let sharedLinkage: Product.Library.LibraryType? = nil
#else
  let sharedLinkage: Product.Library.LibraryType? =
    ProcessInfo.processInfo.environment["SWIFT_COLLECTIVE_DYNAMIC_LIBRARIES"] == "1" ? .dynamic : nil
#endif

let package = Package(
  name: "libpng",
  products: [
    .library(
      name: "png",
      targets: ["pnglibconf", "png"]
    ),
    .library(
      name: "LibPNG",
      type: sharedLinkage,
      targets: ["LibPNG"]
    )
  ],
  dependencies: [
    // note: when bumping zlib versions, also update PNG_ZLIB_VERNUM in pnglibconf.
    .package(url: "https://github.com/the-swift-collective/zlib.git", from: "1.3.1")
  ],
  targets: [
    .target(
      name: "pnglibconf"
    ),
    .target(
      name: "png",
      dependencies: [
        .target(name: "pnglibconf"),
        .product(name: "ZLib", package: "zlib")
      ],
      path: "libpng",
      exclude: [
        "ci",
        "contrib",
        "projects",
        "scripts",
        "tests",
        "pngtest.c",
        "example.c"
      ],
      publicHeadersPath: "."
    ),
    .target(
      name: "LibPNG",
      dependencies: [
        .target(name: "png")
      ]
    ),
    .testTarget(
      name: "LibPNGTests",
      dependencies: [
        .target(name: "LibPNG")
      ]
    ),
  ]
)
