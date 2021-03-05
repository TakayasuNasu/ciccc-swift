//
//  Food.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/03/04.
//

import Foundation
import UIKit

struct Food: ModelProtocol, Hashable {
  var id: Int
  var name: String
  var category: Category
  var time: String
  var price: Rank
  var image: URL!

  enum Category: String, CaseIterable {
    case hotDrink
    case icedDrink
    case breakfast
    case lunch
    case soup
    case snack
    case wrap
    case donuts
    case expensive
    case cheap
  }

  enum Rank: String {
    case expensive
    case cheap
  }

  func all() -> [ModelProtocol] {
    return Foods.data
  }

  static func == (lhs: Food, rhs: Food) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
