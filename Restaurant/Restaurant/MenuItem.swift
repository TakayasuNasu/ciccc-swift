//
//  MenuItem.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import Foundation

struct MenuItem: Codable {
  var id: Int
  var name: String
  var detailText: String
  var price: Double
  var category: String
  var imageURL: URL

  static let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    return formatter
  }()

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case detailText = "description"
    case price
    case category
    case imageURL = "image_url"
  }
}
