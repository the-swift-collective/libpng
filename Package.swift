// swift-tools-version: 5.8
//
// SPDX-License-Identifier: libpng-2.0
// Copyright Contributors to the PNG Reference Library project

import PackageDescription

let package = Package(
  name: "libpng",
  products: [
    .library(
      name: "png",
      targets: ["pnglibconf", "png"]
    ),
    .library(
      name: "LibPNG",
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
