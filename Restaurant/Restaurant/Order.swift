//
//  Order.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import Foundation

struct Order: Codable {
  var menuItems: [MenuItem]

  init(menuItems: [MenuItem] = []) {
    self.menuItems = menuItems
  }

}
