// SPDX-License-Identifier: libpng-2.0
// Copyright Contributors to the PNG Reference Library project

@testable import LibPNG
import XCTest

class LibPNGTests: XCTestCase
{
  func testLibPNGVersion() throws
  {
    print("libpng version: \(String(cString: png_get_libpng_ver(nil)))")
  }
}
