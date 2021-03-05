//
//  Assignment8Tests.swift
//  Assignment8Tests
//
//  Created by Takayasu Nasu on 2021/03/04.
//

import XCTest
@testable import Assignment8

class Assignment8Tests: XCTestCase {

  var viewModel: TimHortonViewModel?

  override func setUp() {
    self.viewModel = TimHortonViewModel()
  }

  func test_viewModel() {
    XCTAssertEqual(self.viewModel!.food.name, "Timbits")
  }
}
