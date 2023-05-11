//
//  GarmentsTests.swift
//  GarmentsTests
//
//  Created by Sul S. on 5/11/23.
//

import XCTest
@testable import Garments
import CoreData

final class GarmentsTests: XCTestCase {
  var sut: GarmentStore!
  var context: NSManagedObjectContext!
  
  override func setUpWithError() throws {
    context = PersistenceController.preview.container.viewContext
    sut = GarmentStore(context: context)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    context = nil
  }
  func testFetchGarments_WhenGarmentsExist_FetchesGarments() {
      // Create a Garment.
      let garment = Garment(context: context)
      garment.name = "Test"
      garment.creationDate = Date()

      // Save the context.
      try? context.save()

      // Fetch the garments.
      sut.fetchGarments()

      // Check that the fetched garments include the one we just created.
      XCTAssertTrue(sut.garments.contains(garment))
  }

  func testAddGarment() {
      // Add a garment.
      sut.addGarment(name: "Test")

      // Check that count >= 1
      XCTAssertGreaterThanOrEqual(sut.garments.count, 1)
  }
  
}
