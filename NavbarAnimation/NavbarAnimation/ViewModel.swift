//
//  ViewModel.swift
//  NavbarAnimation
//
//  Created by Takayasu Nasu on 2021/03/01.
//

import Foundation

class ViewModel {

  var offset: Int = 0
  let sweet: Model
  var isOpened: Bool = false

  var imageNamesDataSource: [String] = []

  let sweets: [Sweet] = {
    let sweets = Sweets()
    return sweets.items
  }()

  init(model: Model = Sweet(id: 1, name: "oreos")) {
    self.sweet = model
  }

  func toggleOffset() {
    if self.offset == 0 {
      self.offset = 280
    } else {
      self.offset = 0
    }
  }

  func toggleOpened() {
    self.isOpened = !self.isOpened
  }
}
