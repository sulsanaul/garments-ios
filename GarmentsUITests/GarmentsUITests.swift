//
//  GarmentsUITests.swift
//  GarmentsUITests
//
//  Created by Sul S. on 5/11/23.
//

import XCTest

final class GarmentsUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
  }
}
